# Projeto: Teste Técnico Tatic

- Build e deploy do projeto Calculadora fornecido pela empresa localmente.
- Deploy de S3 bucket utilizando Terraform
- CI/CD para criação do sistema de Storage usando Terraform
- CI/CD para deploy da aplicação no bucket S3 criado pelo Terraform na AWS


## 1. Build e deploy local

Para testar a aplicação localmente, foram criados os arquivos [Dockerfile](Dockerfile) e [nginx.conf](nginx.conf). O Dockerfile realiza o build para gerar os arquivos estáticos na pasta build e depois serve esses arquivos utilizando nginx na porta 8080.

### Para rodar:

1. docker build -t calculadora .
2. docker run -it -p8080:8080 calculadora
3. Acessar localhost:8080 no navegador de sua preferência

## 2. CI/CD para criação do sistema de Storage usando Terraform

Testado 
