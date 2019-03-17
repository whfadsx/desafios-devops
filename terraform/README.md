# Desafio 01: Infrastructure-as-code - Terraform

## Status

Feito<br>
Extras feito

## Instruções de uso

É utilizado o arquivo idwall.auto.tfvars para configuração das variáveis na construção dos recursos. <br>
Esse terraform constrói toda infra necessária para o deploy da EC2, se necessário lançar a EC2 em uma infra legada, é preciso mudar a variável <i> create_enabled </i> para <i><b>false</i></b>.

## Dependências
- git
- Terraform

## Execução

- Clone esse repositório e entre no diretório terraform
```
$ git clone https://github.com/whfadsx/desafios-devops.git
$ cd desafios-devops/terraform
```
- Inicie o terraform
```
$ terraform init
```
- Crie um plan e salve em um arquivo
```
$ terrafom plan -out idwall.tfplan
```
- Execute o plan
```
$ terraform apply idwall.tfplan
``` 
- Para acessar o site, clique no link após a conclusão do plan

## Notas
- Foi utilizado AWS para prover a instância.