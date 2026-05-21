#  OJJ Académico – Sistema de Gestão Académica

[![Java](https://img.shields.io/badge/Java-17-blue.svg)](https://adoptium.net/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-red.svg)](https://jakarta.ee/)
[![Tomcat](https://img.shields.io/badge/Tomcat-10.1-green.svg)](https://tomcat.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-orange.svg)](https://mysql.com/)

Sistema desenvolvido em **Java MVC (Model-View-Controller)** para gestão de estudantes, funcionários e atendimentos da **Universidade OJJ**.

---

##  Índice

- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Pré‑requisitos](#pré‑requisitos)
  -Estudante:
    *Consultar e atualizar seus dados académicos e pessoais.
    *Solicitar atendimento e acompanhar o status.
    *Visualizar histórico de interações com a instituição.
    *Receber respostas a dúvidas ou pedidos de forma organizada.
  - Funcionário (atendente,administrativo):
    *Registrar atendimentos de forma rápida e padronizada.
    *Acessar o histórico completo de um estudante.
    *Gerenciar filas ou fluxos de atendimento.
    *Consultar informações académicas básicas do estudante(curso, matrícula, etc.).
    *Gerar relatórios ou estatísticas de atendimento.
- [Configuração do Ambiente](#configuração-do-ambiente)
  - [1. Instalar JDK 17](#1-instalar-jdk-17)
  - [2. Instalar Apache Maven](#2-instalar-apache-maven)
  - [3. Instalar MySQL (via XAMPP)](#3-instalar-mysql-via-xampp)
  - [4. Instalar Tomcat 10](#4-instalar-tomcat-10)
  - [5. Instalar Git (opcional)](#5-instalar-git-opcional)
- [Clonar o Repositório](#clonar-o-repositório)
- [Configurar a Base de Dados](#configurar-a-base-de-dados)
- [Configurar o Projecto](#configurar-o-projecto)
- [Compilar e Gerar o WAR](#compilar-e-gerar-o-war)
- [Executar no Tomcat](#executar-no-tomcat)
- [Aceder ao Sistema](#aceder-ao-sistema)
- [Credenciais de Teste](#credenciais-de-teste)
- [Estrutura do Projecto](#estrutura-do-projecto)
- [Contribuição (para a equipa)](#contribuição-para-a-equipa)
- [Resolução de Problemas Comuns](#resolução-de-problemas-comuns)

---

## Tecnologias Utilizadas

| Camada          | Tecnologia                          |
|----------------|-------------------------------------|
| Linguagem      | Java 17                             |
| Web            | Jakarta Servlet 6.0, JSP, JSTL      |
| Servidor       | Apache Tomcat 10.1                  |
| Banco de Dados | MySQL 8.0                           |
| Gestor de Build| Apache Maven 3.9+                   |
| Segurança      | BCrypt (hashing de senhas)          |
| Front-end      | HTML5, CSS3, JavaScript (ES6)       |
| Controle versão| Git / GitHub                        |

---

## ⚙️ Pré‑requisitos

Antes de começar, certifique-se de ter instalado:

- **JDK 17** (ou superior, mas recomendado 17)
- **Apache Maven** (3.9+)
- **MySQL Server** (8.0+) – pode usar XAMPP para facilitar
- **Apache Tomcat 10.1** (não use Tomcat 9 ou inferior)
- **Git** (opcional, para clonar via terminal)

>  **Atenção**: O projecto usa **Jakarta EE 10** e **Tomcat 10**. **Não funciona em Tomcat 9** (que usa javax.servlet).

---

##  Configuração do Ambiente

### 1. Instalar JDK 17

- Descarregue do [Adoptium](https://adoptium.net/temurin/releases/?version=17)
- Instale e defina a variável de ambiente `JAVA_HOME`.
- Verifique: `java --version`

### 2. Instalar Apache Maven

- Descarregue do [site oficial](https://maven.apache.org/download.cgi)
- Extraia para `C:\maven` (exemplo)
- Adicione `C:\maven\bin` ao `PATH`
- Verifique: `mvn --version`

### 3. Instalar MySQL (via XAMPP)

- Descarregue [XAMPP](https://www.apachefriends.org/) com PHP 8.2+
- Durante a instalação, seleccione **MySQL** e **phpMyAdmin**
- Inicie o MySQL no XAMPP Control Panel
- Aceda ao phpMyAdmin: `http://localhost/phpmyadmin`

### 4. Instalar Tomcat 10

- Descarregue a versão **10.1.x** (Core Windows zip) de [tomcat.apache.org](https://tomcat.apache.org/download-10.cgi)
- Extraia para `C:\tomcat10`
- **Não** use Tomcat 9.

### 5. Instalar Git (opcional)

- Descarregue de [git-scm.com](https://git-scm.com/)
- Verifique: `git --version`

---

## 📥 Clonar o Repositório


git clone https://github.com/luisquetadev/ojj-academico.git
cd ojj-academico
