-- Excluir o Banco de Dados inteiro do sistema 

DROP DATABASE IF EXISTS Ecommerce;

-- Recriar o Banco de Dados

CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Tabela: TipoCliente
CREATE TABLE TipoCliente (
    idTipoCliente INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(50) NOT NULL
);

-- Tabela: Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Pnome VARCHAR(50) NOT NULL,
    NomeDoMeio CHAR(3),
    Sobrenome VARCHAR(50) NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    Endereco VARCHAR(255),
    DataDeNascimento DATE,
    idTipoCliente INT,
    FOREIGN KEY (idTipoCliente) REFERENCES TipoCliente(idTipoCliente)
);

-- Tabela: Produto
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    Categoria VARCHAR(50) NOT NULL,
    DescricaoProduto TEXT,
    Valor DECIMAL(10, 2) NOT NULL
);

-- Tabela: Pedido
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    Status ENUM('Pendente', 'Em Processamento', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
    Descricao TEXT,
    Frete DECIMAL(10, 2) NOT NULL,
    Cliente_idCliente INT NOT NULL,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);

-- Tabela: RelacaoDePedidoProduto
CREATE TABLE RelacaoDePedidoProduto (
    Pedido_idPedido INT,
    Produto_idProduto INT,
    Quantidade INT NOT NULL,
    Status ENUM('Pendente', 'Confirmado', 'Cancelado') NOT NULL,
    PRIMARY KEY (Pedido_idPedido, Produto_idProduto),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido) ON DELETE CASCADE,
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto) ON DELETE CASCADE
);

-- Tabela: Pagamento
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    DescricaoFormaPagamento VARCHAR(50) NOT NULL,
    Pedido_idPedido INT,
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido) ON DELETE CASCADE
);

-- Tabela: Entrega
CREATE TABLE Entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    Status ENUM('Pendente', 'Em Rota', 'Entregue') NOT NULL,
    CodigoRastreio VARCHAR(50),
    Pedido_idPedido INT,
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido) ON DELETE CASCADE
);

-- Tabela: Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(50) NOT NULL,
    Local VARCHAR(50),
    NomeFantasia VARCHAR(50),
    Endereco VARCHAR(255)
);

-- Tabela: Estoque
CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Local VARCHAR(50) NOT NULL
);

-- Tabela: ProdutoEmEstoque
CREATE TABLE ProdutoEmEstoque (
    Produto_idProduto INT,
    Estoque_idEstoque INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (Produto_idProduto, Estoque_idEstoque),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto) ON DELETE CASCADE,
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque) ON DELETE CASCADE
);

-- Tabela: ForneceuProduto
CREATE TABLE ForneceuProduto (
    Fornecedor_idFornecedor INT,
    Produto_idProduto INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor) ON DELETE CASCADE,
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto) ON DELETE CASCADE
);

-- Tabela: TerceiroVendedor
CREATE TABLE TerceiroVendedor (
    idTerceiroVendedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(50) NOT NULL,
    CNPJ CHAR(14) UNIQUE NOT NULL,
    Local VARCHAR(50),
    NomeFantasia VARCHAR(50),
    Endereco VARCHAR(255)
);

-- Tabela: TerceiroVendedorProduto
CREATE TABLE TerceiroVendedorProduto (
    TerceiroVendedor_idTerceiroVendedor INT,
    Produto_idProduto INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (TerceiroVendedor_idTerceiroVendedor, Produto_idProduto),
    FOREIGN KEY (TerceiroVendedor_idTerceiroVendedor) REFERENCES TerceiroVendedor(idTerceiroVendedor) ON DELETE CASCADE,
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto) ON DELETE CASCADE
);

