# Teste Técnico - Banco de Sangue

Uma agência de banco de sangue forneceu uma lista de candidatos a doadores e precisa de um sistema que processe esses dados para extrair algumas informações.

## Objetivo

Desenvolver um sistema mobile que carregue um JSON salvo no dispositivo com os dados e mostre os seguintes resultados:

- **Quantidade de candidatos** em cada estado do Brasil.
- **IMC médio** em cada faixa etária de 10 em 10 anos:  
  *(0 a 10, 11 a 20, 21 a 30, etc.)*  
  *(Fórmula: IMC = peso / altura²)*
- **Percentual de obesos** entre homens e mulheres. *(IMC > 30 é considerado obeso)*
- **Média de idade** para cada tipo sanguíneo.
- **Quantidade de possíveis doadores** para cada tipo sanguíneo receptor.  

> **Regras para doação:**  
> Somente pessoas com idade entre **16 a 69 anos** e com **peso acima de 50 Kg** podem doar sangue.

## Compatibilidade Sanguínea

| Tipo Sanguíneo | Pode Doar Para          | Pode Receber De            |
|---------------|-------------------------|----------------------------|
| **A+**       | AB+, A+                  | A+, A-, O+, O-            |
| **A-**       | A+, A-, AB+, AB-         | A-, O-                    |
| **B+**       | B+, AB+                  | B+, B-, O+, O-            |
| **B-**       | B+, B-, AB+, AB-         | B-, O-                    |
| **AB+**      | AB+                      | Todos os tipos sanguíneos  |
| **AB-**      | AB+, AB-                 | A-, B-, O-, AB-           |
| **O+**       | A+, B+, O+, AB+          | O+, O-                    |
| **O-**       | Todos os tipos sanguíneos | O-                         |

## Tecnologias Utilizadas

- **Back-end:** Java com Spring Boot
- **Front-end:** Flutter
- **Banco de Dados:** MySQL
- **Gerenciamento de Pacotes:** Maven (Java) e Pub (Flutter)

## Requisitos de Implementação

### **Back-end**
- ✅ Java
- ✅ Programação Orientada a Objetos (POO)
- ✅ Spring Boot
- ✅ JPA
- ✅ Imutabilidade
- ✅ Segurança
- ✅ Protocolo HTTP e REST
- ✅ JSON
- ✅ Maven

### **Front-end**
- ✅ Usabilidade
- ✅ Estética e design responsivo
- ✅ Flutter
- ✅ npm

### **Banco de Dados**
- ✅ SQL
- ✅ DDL
- ✅ Normalização
- ✅ Desempenho e integridade

### **Geral**
- ✅ Lógica de Programação
- ✅ Arquitetura de Software
- ✅ Padronização de Código
- ✅ Boas Práticas de Desenvolvimento
- ✅ Utilização de Recursos Avançados

## Como Executar o Projeto

### **Back-end**
1. Instale o Java e o Maven.
2. Clone o repositório:
   ```sh
   git clone (https://github.com/NatanaelB2020/testeFlutter.git)
