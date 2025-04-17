# 🐳 Introdução ao Docker

## O que é Docker?

Docker é uma **plataforma de virtualização de containers** que permite empacotar aplicações com todas as suas dependências, garantindo que funcionem de forma consistente em qualquer ambiente.

> "Funciona na minha máquina" deixa de ser uma desculpa!

Com Docker, você:
- Garante portabilidade da aplicação
- Empacota tudo que a aplicação precisa para rodar (ambiente + dependências)
- Isola a aplicação em **containers**

---

## 🏗️ Containers x Máquinas Virtuais

| Característica        | Container (Docker)                              | Máquina Virtual (VM)                         |
|------------------------|--------------------------------------------------|-----------------------------------------------|
| Sistema Operacional    | Compartilha o SO do hospedeiro                  | Cada VM roda um SO completo                   |
| Desempenho             | Mais leve e rápido                              | Mais pesado                                   |
| Isolamento             | Alto (usando cgroups e namespaces)              | Completo, mas com mais consumo de recursos    |
| Uso de recursos        | Compartilhado e eficiente                       | Aloca mais memória e CPU                      |

No Docker, os **containers compartilham o kernel** do sistema hospedeiro, mas são isolados entre si.

### 🔒 Conceitos envolvidos:

- **cgroups**: controlam o uso de CPU, memória e I/O por container
- **namespaces**: fornecem isolamento de processos, rede e variáveis de ambiente

---

## 🚀 Por que usar Docker?

- Resolve conflitos de ambiente
- Facilita o deploy em diferentes máquinas
- Permite criar ambientes consistentes para desenvolvimento, testes e produção
- Escalabilidade com containers independentes
- Portabilidade total: desenvolva localmente, rode em produção

---

## 📚 Conceitos Básicos do Docker

### 📄 Dockerfile

Arquivo que descreve **como construir uma imagem** da aplicação. Contém instruções como base de imagem, comandos para instalar dependências, copiar arquivos, etc.

### 📦 Imagem

Uma **imagem Docker** contém tudo que a aplicação precisa para rodar: código, runtime, bibliotecas, etc.

> É como uma "foto congelada" do ambiente da aplicação.

### 🧱 Container

Um **container** é uma **instância em execução** de uma imagem. Cada container é isolado, mas usa o kernel do SO hospedeiro.

### 🌐 Registro

Um **registro** é onde as imagens são armazenadas e compartilhadas. Exemplos:
- Docker Hub (`hub.docker.com`)
- Amazon ECR (AWS)
- Azure Container Registry
- Google Container Registry

---

## 🛠️ Exemplo de Dockerfile para aplicação Java (Spring Boot)

```Dockerfile
# Etapa 1: Build
FROM maven:3.9.9-amazoncorretto-17-alpine AS build
COPY src /app/src
WORKDIR /app
RUN mvn clean install

# Etapa 2: Runtime
FROM openjdk:17-slim
COPY --from=build /app/target/docker-example-0.0.1-SNAPSHOT.jar /app/app.jar
WORKDIR /app
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```
## 🧪 Comandos Docker Úteis

### 📥 Construir uma imagem

```bash
docker build -t docker-example:1.0 .
```

- `-t` define o nome e a tag da imagem
- `.` indica o diretório atual, onde deve estar o `Dockerfile`

---

### ▶️ Rodar um container

```bash
docker run -p 8080:8080 docker-example:1.0
```

- `-p 8080:8080` mapeia a porta 8080 do container para a porta 8080 do host

---

### 🧪 Interagir com o terminal do container

```bash
docker run -it ubuntu bash
```

- `-it` permite interação com o terminal (modo interativo)
- `bash` inicia o terminal dentro da imagem Ubuntu

---

### 📦 Executar comandos em um container em execução

```bash
docker exec -it <idContainer> bash
```

- Permite executar comandos dentro de um container em execução
- Substitua `<idContainer>` pelo ID ou nome do seu container

---

## ☁️ Docker Hub e Push da Imagem

### 📤 Subir uma imagem para o Docker Hub

```bash
docker build -t gabrielleon/docker-example:1.0 .
docker push gabrielleon/docker-example:1.0
```

- Antes de dar o push, certifique-se de:
    - Ter criado um repositório no Docker Hub
    - Ter feito login do dockerHub na máquina que está utilizando.

---

### 💻 Rodar a imagem em outra máquina

```bash
docker run gabrielleon/docker-example:1.0
```

> ⚠️ Se a máquina tiver uma arquitetura diferente da usada no build (ex: ARM64 vs AMD64), pode ser necessário gerar uma imagem compatível:

```bash
docker build --platform linux/amd64 -t gabrielleon/docker-example:1.0 .
```

---

## 🧠 Dicas Finais

- Containers são **isolados da máquina hospedeira** — lembre-se de mapear portas e volumes, se necessário
- Um container **só permanece ativo enquanto há um processo rodando** dentro dele
- Docker é ideal para:
    - Ambientes modernos de desenvolvimento
    - Pipelines CI/CD
    - Arquiteturas baseadas em microserviços
    - Garantir consistência entre desenvolvimento e produção

---

## 📎 Recursos Recomendados

- [📘 Documentação oficial do Docker](https://docs.docker.com/)
- [💻 Play with Docker (ambiente online)](https://labs.play-with-docker.com/)
- [🐳 Docker Hub](https://hub.docker.com/)

---

✍️ Criado por [Gabriel Leon](https://github.com/GLeonBS) com base em estudos e prática.  
📤 Compartilhe com alguém que esteja começando com Docker!
