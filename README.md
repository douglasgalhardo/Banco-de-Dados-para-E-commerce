# 🛒 Projeto Conceitual de Banco de Dados para E-commerce

Este repositório contém o **projeto conceitual de um banco de dados** desenvolvido para um sistema de **e-commerce**.  
O objetivo é **refinar um esquema inicial**, adicionando **novas funcionalidades e regras de negócio**, tornando-o mais robusto e próximo de um cenário real de mercado.

---

## 🧩 Descrição do Esquema

O modelo de dados foi projetado para gerenciar as principais entidades de um e-commerce, incluindo:

- **Clientes**
- **Produtos**
- **Pedidos**
- **Pagamentos**
- **Entregas**
- **Estoque**
- **Fornecedores**
- **Vendedores Terceiros (Marketplace)**

---

## 🧱 Entidades Principais

### 👥 Cliente

Armazena informações gerais dos clientes.  
Foi implementada uma **especialização** para diferenciar **Clientes Pessoa Física (PF)** e **Pessoa Jurídica (PJ)**.

### 📦 Produto

Contém os detalhes dos produtos disponíveis na plataforma, como nome, categoria, preço e descrição.

### 🧾 Pedido

Registra as compras realizadas pelos clientes, incluindo:

- Itens adquiridos
- Valor total
- Valor do frete
- Data do pedido

### 💳 Pagamento

Gerencia as transações financeiras associadas a um pedido.  
Um único pedido pode ser quitado com **múltiplas formas de pagamento** (ex: cartão de crédito + vale-presente).

### 🚚 Entrega

Controla o processo de envio do pedido, incluindo:

- Status da entrega
- Código de rastreamento

### 🏭 Fornecedor

Armazena informações sobre os fornecedores dos produtos.

### 🏬 Estoque

Gerencia os locais de armazenamento e as quantidades disponíveis de cada produto.

### 🤝 Vendedor Terceiro

Permite que produtos de vendedores parceiros (marketplace) sejam vendidos na plataforma.

---

## ⚙️ Refinamentos Implementados

### 1. Cliente Pessoa Física (PF) e Pessoa Jurídica (PJ)

Para atender à regra de que **um cliente pode ser PF ou PJ, mas nunca ambos**, foi adotada uma abordagem de **generalização/especialização**:

- **Tabela `Cliente` (Generalização)**  
  Contém os atributos comuns, como:

  - `idCliente`
  - `Endereco`
  - `TipoCliente` (campo discriminador: PF ou PJ)

- **Tabelas `ClientePF` e `ClientePJ` (Especialização)**  
  Armazenam os dados específicos de cada tipo:
  - `ClientePF`: `Nome`, `CPF`
  - `ClientePJ`: `RazaoSocial`, `CNPJ`

Ambas se relacionam com a tabela `Cliente` através da chave **primária/estrangeira** `idCliente`.  
Essa estrutura **garante integridade referencial** e evita inconsistências (como um cliente possuir CPF e CNPJ simultaneamente).

---

### 2. Múltiplas Formas de Pagamento

Para permitir que um pedido seja pago de formas diferentes (ex: **parte no cartão, parte no vale**), foi criada a **tabela `Pagamento`**.

- **Tabela `Pagamento`**
  - Cada registro representa uma **transação financeira**.
  - Relaciona-se diretamente com a tabela `Pedido` (`idPedido`).

💡 **Flexibilidade:**  
Um único pedido pode ter **múltiplos registros** na tabela `Pagamento`, possibilitando combinações de tipos e valores para quitar o total da compra.

---

### 3. Status e Código de Rastreio da Entrega

A gestão de entregas foi separada da entidade `Pedido` para garantir **maior clareza e modularidade**.

- **Tabela `Entrega`**
  - Relacionada à tabela `Pedido`
  - Campos principais:
    - `StatusEntrega`: armazena o estado atual (ex: _Preparando_, _Em trânsito_, _Entregue_)
    - `CodigoRastreio`: código fornecido pela transportadora

Essa separação torna o **gerenciamento logístico mais escalável e organizado**.

---

## 🧠 Benefícios do Modelo

✅ Melhor integridade dos dados  
✅ Flexibilidade em meios de pagamento  
✅ Modularidade na gestão logística  
✅ Suporte a marketplace  
✅ Estrutura escalável e realista

---

## 📘 Tecnologias e Ferramentas Utilizadas

- **MySQL** para modelagem e implementação
- **MERMAID** para diagramação ER
- **SQL** padrão para criação das tabelas

---

**Autor:** Douglas Galhardo  
📧 [douglasgalhardo1994@gmail.com](mailto:douglasgalhardo1994@gmail.com)
