CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- TABELA CLIENTE (GENERALIZAÇÃO)
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    TipoCliente ENUM('PF', 'PJ') NOT NULL COMMENT 'Discriminador para Pessoa Física ou Jurídica',
    Endereco VARCHAR(255)
);

-- TABELA CLIENTE PESSOA FÍSICA 
CREATE TABLE ClientePF (
    idCliente INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    CONSTRAINT fk_clientepf_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- TABELA CLIENTE PESSOA JURÍDICA
CREATE TABLE ClientePJ (
    idCliente INT PRIMARY KEY,
    RazaoSocial VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    CONSTRAINT fk_clientepj_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- TABELA PRODUTO
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    Categoria VARCHAR(45) NOT NULL,
    Descricao VARCHAR(255),
    Valor FLOAT NOT NULL
);

-- TABELA FORNECEDOR
CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE
);

-- TABELA DE RELACIONAMENTO PRODUTO-FORNECEDOR (M:N)
CREATE TABLE Produto_Fornecedor (
    idProduto INT,
    idFornecedor INT,
    PRIMARY KEY (idProduto, idFornecedor),
    CONSTRAINT fk_prod_forn_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT fk_prod_forn_fornecedor FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor)
);

-- TABELA ESTOQUE
CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Local VARCHAR(255) NOT NULL
);

-- TABELA DE RELACIONAMENTO PRODUTO-ESTOQUE (M:N)
CREATE TABLE Produto_em_Estoque (
    idProduto INT,
    idEstoque INT,
    Quantidade INT NOT NULL DEFAULT 0,
    PRIMARY KEY (idProduto, idEstoque),
    CONSTRAINT fk_prod_est_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT fk_prod_est_estoque FOREIGN KEY (idEstoque) REFERENCES Estoque(idEstoque)
);

-- TABELA PEDIDO
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    StatusPedido ENUM('Em processamento', 'Enviado', 'Entregue', 'Cancelado') NOT NULL DEFAULT 'Em processamento',
    Descricao VARCHAR(255),
    Frete FLOAT,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- TABELA DE RELACIONAMENTO PRODUTO-PEDIDO (M:N)
CREATE TABLE Produto_Pedido (
    idProduto INT,
    idPedido INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (idProduto, idPedido),
    CONSTRAINT fk_prod_ped_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT fk_prod_ped_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- TABELA PAGAMENTO
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    TipoPagamento ENUM('Boleto', 'Cartão de Crédito', 'Pix') NOT NULL,
    Valor FLOAT NOT NULL,
    Status ENUM('Pendente', 'Confirmado', 'Recusado') NOT NULL DEFAULT 'Pendente',
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- TABELA ENTREGA
CREATE TABLE Entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT UNIQUE, 
    StatusEntrega ENUM('Preparando', 'Em trânsito', 'Entregue', 'Falha na entrega') NOT NULL DEFAULT 'Preparando',
    CodigoRastreio VARCHAR(50),
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- TABELA VENDEDOR TERCEIRO (MARKETPLACE)
CREATE TABLE VendedorTerceiro (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(255) NOT NULL,
    Local VARCHAR(255)
);

-- TABELA DE RELACIONAMENTO PRODUTO-VENDEDOR (M:N)
CREATE TABLE Produto_Vendedor (
    idVendedor INT,
    idProduto INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (idVendedor, idProduto),
    CONSTRAINT fk_prod_vend_vendedor FOREIGN KEY (idVendedor) REFERENCES VendedorTerceiro(idVendedor),
    CONSTRAINT fk_prod_vend_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);
