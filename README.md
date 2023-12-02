# Provisionando um servidor EC2 e expondo aplicação com docker utilizando script bash

## O que utilizei?

- Terraform
- AWS
- Docker

## Pré-requisitos

- Conta AWS
- AWS-CLI
- Terraform

## Como funciona?

No privionamento do server EC2 nosso script é executado e nosso container docker com a aplicação roda na porta 80 do servidor

## Como utilizar?

Crie um bucket com o nome de sua preferência e altere no arquivo main.tf

Comando para inicialiar terraform

```bash
terraform init
```

Comando para verificar recursos a serem criados

```bash
terraform plan -out plan.tfplan
```

Comando para criar recursos na AWS

```bash
terraform apply plan.tfplan
```

Após a criação dos recursos, vá no console e verique o ip público da sua instância e a utilize no seu navegador

Destruição dos recursos criados

Comando para destruir os recursos na AWS

```bash
terraform destroy
```

Após esse comando confirme digitando "yes"
