# Provisionando um servidor EC2 e expondo aplicação com docker utilizando script bash

## O que utilizei?

- Terraform
- AWS
- Docker
- Módulos oficiais do Terraform Registry (`terraform-aws-modules`)

## Pré-requisitos

- Conta AWS
- AWS-CLI
- Terraform `>= 1.0` (testado com a versão 1.8.4)

## Como funciona?

No provisionamento do server EC2 nosso script (`script.sh`) é executado como `user_data` e o container docker com a aplicação roda na porta 80 do servidor.

O código Terraform é organizado em **pastas separadas** (uma por módulo) e a `main.tf` só faz as chamadas. Cada pasta é um **módulo local (wrapper)** que encapsula um **módulo oficial** da comunidade `terraform-aws-modules`:

| Chamada na `main.tf` | Recurso provisionado | Módulo oficial encapsulado | Versão |
| --- | --- | --- | --- |
| `./vpc` | VPC, Internet Gateway, subnet pública, route table e associações | `terraform-aws-modules/vpc/aws` | `~> 5.0` |
| `./security_group` | Security group com as portas 80, 443 e 22 | `terraform-aws-modules/security-group/aws` | `~> 5.0` |
| `./ec2` | Instância EC2 com o `user_data` | `terraform-aws-modules/ec2-instance/aws` | `~> 5.0` |

Estrutura de arquivos:

```
main.tf                         # provider, backend e chamadas dos módulos locais
variables.tf                    # variáveis do projeto (região, CIDRs, tipo da instância, etc.)
outputs.tf                      # saídas do projeto (IP público, URL da aplicação, IDs)
vpc/                            # wrapper do módulo oficial de VPC
  main.tf, variables.tf, outputs.tf
security_group/                 # wrapper do módulo oficial de security group
  main.tf, variables.tf, outputs.tf
ec2/                            # wrapper do módulo oficial de instância EC2
  main.tf, variables.tf, outputs.tf
script.sh                       # script executado no boot da instância (Docker + aplicação)
terraform.tfvars.example        # exemplo de personalização dos valores
```

Cada pasta declara só as variáveis e saídas de que a `main.tf` precisa, então a `main.tf` fica enxuta e a versão do módulo oficial fica encapsulada dentro do próprio wrapper (no Terraform o argumento `version` do módulo precisa ser uma string literal e não aceita variável).

> As versões `~> 5.0` foram escolhidas porque são compatíveis com o provider `hashicorp/aws ~> 5.9` já usado no projeto. Os módulos `v6.x` exigem provider AWS `>= 6.29`.

## Como utilizar?

1. Crie um bucket S3 para o `tfstate` e altere o nome dele no bloco `backend "s3"` do `main.tf`.

2. (Opcional) Personalize os valores copiando o arquivo de exemplo:

```bash
cp terraform.tfvars.example terraform.tfvars
```

3. Comando para inicialiar terraform (baixa os módulos oficiais):

```bash
terraform init
```

4. Comando para verificar recursos a serem criados:

```bash
terraform plan -out plan.tfplan
```

5. Comando para criar recursos na AWS:

```bash
terraform apply plan.tfplan
```

6. Após a criação dos recursos, o Terraform mostra as saídas. Para ver o IP/URL da aplicação:

```bash
terraform output application_url
```

Cole a URL no navegador (a aplicação leva alguns minutos para subir, pois o `script.sh` instala o Docker e faz o build da imagem).

7. Destruição dos recursos criados:

```bash
terraform destroy
```

Após esse comando confirme digitando "yes".

## Variáveis principais

| Variável | Descrição | Default |
| --- | --- | --- |
| `aws_region` | Região da AWS | `us-east-1` |
| `project_name` | Prefixo de nome/tags dos recursos | `project-devops` |
| `vpc_cidr` | CIDR da VPC | `10.0.0.0/16` |
| `availability_zones` | Zonas de disponibilidade das subnets públicas | `["us-east-1a"]` |
| `public_subnets` | CIDRs das subnets públicas | `["10.0.1.0/24"]` |
| `allowed_ingress_cidr_blocks` | CIDRs liberados para 80/443/22 | `["0.0.0.0/0"]` |
| `ami_id` | AMI da instância (precisa ser Ubuntu, pois o script usa `apt`) | `ami-0fc5d935ebf8bc3bc` |
| `instance_type` | Tipo da instância | `t2.micro` |
| `key_name` | Key pair para SSH | `aws-server` |

> ⚠️ O default de `allowed_ingress_cidr_blocks` libera SSH para a internet. Em ambientes reais, restrinja para o seu IP (`["203.0.113.10/32"]`).

> ⚠️ O `ami_id` é um ID de AMI da região `us-east-1` e pode expirar. Use `aws ec2 describe-images` (ou o console) para pegar uma AMI Ubuntu atual e passe o novo valor via `terraform.tfvars`.

## Migrando de uma infra já criada

Como os endereços dos recursos no state mudaram (cada pasta agora encapsula um módulo do registry, gerando endereços como `module.vpc.module.vpc.aws_vpc.this`), o `terraform apply` **não reaproveita** a infra existente: ele cria uma nova VPC/subnet/EC2. Se você já tem a infra antiga aplicada, destrua antes com o código anterior (ex.: `git stash` → `terraform destroy` → `git stash pop`) ou remova os recursos antigos pelo console antes de aplicar o novo código.

