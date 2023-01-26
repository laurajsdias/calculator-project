# Projeto: Teste Técnico Tatic

- Build e deploy do projeto Calculadora fornecido pela empresa localmente.
- Deploy de S3 bucket utilizando Terraform
- CI/CD para criação do sistema de Storage usando Terraform
- CI/CD para deploy da aplicação no bucket S3 criado pelo Terraform na AWS


## 1. Build e deploy local

Para testar a aplicação localmente, foram criados os arquivos [Dockerfile](Dockerfile) e [nginx.conf](nginx.conf). O Dockerfile realiza o build para gerar os arquivos estáticos na pasta build e depois serve esses arquivos utilizando nginx na porta 8080.

### Para rodar:

1. `docker build -t calculadora .`
2. `docker run -it -p8080:8080 calculadora`
3. `Acessar localhost:8080 no navegador de sua preferência`


## 2. Deploy de S3 bucket utilizando Terraform

Feito o teste local da aplicação, o próximo passo foi criar o código Terraform para criação do bucket S3 onde o site do projeto será hospedado. Os arquivos criados foram os seguintes:

- [main.tf](terraform/main.tf): define o provider aws e o módulo s3 (diretório com todas as configurações necessárias para criação do s3)
- [s3.tf](terraform/s3/s3.tf): define os principais resources para criação do s3 bucket. Primeiro o resource aws_s3_bucket, onde foi definido o nome do bucket. Depois, o resource aws_s3_bucket_website_configuration para definir o index.html do site. Depois os resources que definem as permissões de acesso ao bucket (acl: public_read e a policy: allow_access_to_bucket)
- [iam.tf](terraform/s3/iam.tf): define a política de acesso aos objetos do bucket. No caso, foi definido que todos tenham permissão para que o site fique acessível publicamente.
- [outputs.tf](terraform/s3/outputs.tf): define o output 'website_endpoint' para que ter o endereço de acesso ao site ao final do terraform apply.

### Para rodar:

Pré-requisitos:
- Possuir um arquivo ~/.aws/credentials com as variáveis **AWS_ACCESS_KEY_ID** e **AWS_SECRET_ACCESS_KEY** definidas. 

1. `cd terraform`
2. `terraform init`
3. `terraform apply` (se todo o plan estiver ok, digite yes)


## 3. CI/CD para criação do sistema de Storage usando Terraform

Nesta etapa, foi criado um processo CI/CD para criação do bucket S3 utilizando o Github Actions.

Foi criado o arquivo [00_provision-infra.yml](.github/workflows/00_provision-infra.yml). Os steps criados basicamente são uma tradução do fluxo que é utilizado localmente para rodar um código terraform (terraform init, terraform validate e terraform apply) utilizando o working-directory 'terraform' do repositório.

### Para rodar:

Pré-requisitos:
- Possuir os seguintes secrets criados no repositório do projeto: **AWS_ACCESS_KEY_ID** e **AWS_SECRET_ACCESS_KEY**.

O workflow roda automaticamente caso haja push na branch 'infra' do repositório.

## 4. CI/CD para deploy da aplicação no bucket S3 criado pelo Terraform na AWS

Nesta etapa, foi criado um processo CI/CD deploy da aplicação no bucket S3 criado pelo Terraform na AWS no workflow anterior.

Foi criado o arquivo [01_deploy-app.yml](.github/workflows/01_deploy-app.yml). Os steps criados basicamente são para criação da pasta build com os arquivos estáticos e upload desses arquivos no bucket S3: npm install, npm run build, aws s3 sync.

### Para rodar:

Pré-requisitos:
- Adicionar o seguinte secret no repositório do projeto: **S3_BUCKET** com o valor **projeto-calculadora**.

O workflow roda automaticamente caso haja push na branch 'main' do repositório.
Para acessar o site, acesse o bucket criado, depois em Propriedades, copie e cole o endereço do endpoint no navegador. O site estará acessível.

# Considerações Finais

- [x] Diferencial 1: item 4 acima.
- [x] Diferencial 2: item 3 acima.
- [x] Diferencial 3: foi criado o módulo s3 com os resources separados para facilitar reuso.

### Decisões

Separei o código do terraform na branch 'infra' para que o workflow do terraform não fosse iniciado a cada push na branch main. Por isso, defini que o workflow do terraform só rode quando houver push na branch 'infra'. 