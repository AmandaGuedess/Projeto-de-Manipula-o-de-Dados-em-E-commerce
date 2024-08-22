-- Inserção de Dados

SHOW TABLES;

INSERT INTO TipoCliente (Descricao) VALUES
('Regular'),
('Premium'),
('VIP');

INSERT INTO Cliente (Pnome, NomeDoMeio, Sobrenome, CPF, Endereco, DataDeNascimento, idTipoCliente) VALUES
('Maria', 'M', 'Silva', '12345678901', 'Rua Silva de Prata, 29, Carangola - Cidade das Flores', '1985-03-12', 1),
('Matheus', 'O', 'Pimentel', '98765432100', 'Rua Alameda, 289, Centro - Cidade das Flores', '1990-06-25', 2),
('Ricardo', 'F', 'Silva', '45678912345', 'Avenida Alameda, Vinha 1009, Centro - Cidade das Flores', '1982-11-05', 1),
('Julia', 'S', 'França', '78912345678', 'Rua Lareijras, 861, Centro - Cidade das Flores', '1992-08-15', 2),
('Roberta', 'G', 'Assis', '98745612300', 'Avenida Koller, 19, Centro - Cidade das Flores', '1987-12-09', 3),
('Isabela', 'M', 'Cruz', '65478912301', 'Rua Alameda das Flores, 28, Centro - Cidade das Flores', '1995-04-17', 1);

SELECT * FROM Cliente;
desc cliente;

INSERT INTO Produto (Categoria, DescricaoProduto, Valor) VALUES
('Eletrônico', 'Fone de ouvido', 50.00),
('Brinquedos', 'Barbie Elsa', 300.00),
('Vestimenta', 'Body Carters', 500.00),
('Eletrônico', 'Microfone Vedo - Youtuber', 400.00),
('Móveis', 'Sofá retrátil', 3000.00),
('Alimentos', 'Farinha de arroz', 20.00),
('Eletrônico', 'Fire Stick Amazon', 356.00);

INSERT INTO Pedido (Status, Descricao, Frete, Cliente_idCliente) VALUES
('Pendente', 'Pedido aguardando confirmação', 15.00, 1),
('Em Processamento', 'Pedido em separação no estoque', 20.00, 2),
('Enviado', 'Pedido em trânsito', 25.00, 3),
('Entregue', 'Pedido entregue com sucesso', 10.00, 4),
('Cancelado', 'Pedido cancelado pelo cliente', 0.00, 5);

INSERT INTO RelacaoDePedidoProduto (Pedido_idPedido, Produto_idProduto, Quantidade, Status) VALUES
(1, 1, 2, 'Confirmado'),
(1, 3, 1, 'Confirmado'),
(2, 2, 1, 'Pendente'),
(3, 5, 1, 'Confirmado'),
(4, 4, 2, 'Confirmado'),
(5, 6, 3, 'Cancelado');

INSERT INTO Pagamento (DescricaoFormaPagamento, Pedido_idPedido) VALUES
('Cartão de Crédito', 1),
('Boleto Bancário', 2),
('Pix', 3),
('Cartão de Débito', 4),
('Cartão de Crédito', 5);

INSERT INTO Entrega (Status, CodigoRastreio, Pedido_idPedido) VALUES
('Pendente', 'TR123456789BR', 1),
('Em Rota', 'TR987654321BR', 2),
('Entregue', 'TR456789123BR', 3),
('Entregue', 'TR654789321BR', 4),
('Cancelado', NULL, 5);

INSERT INTO Fornecedor (RazaoSocial, Local, NomeFantasia, Endereco) VALUES
('Fornecedor Eletrônicos Ltda', 'São Paulo', 'Eletrônicos SP', 'Rua do Comércio, 100'),
('Brinquedos e Cia', 'Rio de Janeiro', 'Brinquedos RJ', 'Avenida das Crianças, 200'),
('Móveis Conforto', 'Curitiba', 'Conforto Móveis', 'Rua das Palmeiras, 300');

INSERT INTO Estoque (Local) VALUES
('Armazém Central'),
('Depósito Sul'),
('Centro de Distribuição Norte');

INSERT INTO ProdutoEmEstoque (Produto_idProduto, Estoque_idEstoque, Quantidade) VALUES
(1, 1, 50),
(2, 2, 30),
(3, 1, 20),
(4, 3, 10),
(5, 2, 15),
(6, 3, 100),
(7, 1, 25);

INSERT INTO ForneceuProduto (Fornecedor_idFornecedor, Produto_idProduto, Quantidade) VALUES
(1, 1, 100),
(1, 4, 50),
(1, 7, 60),
(2, 2, 200),
(3, 5, 30);

INSERT INTO TerceiroVendedor (RazaoSocial, CNPJ, Local, NomeFantasia, Endereco) VALUES
('Vendedor XYZ', '12345678000199', 'Belo Horizonte', 'XYZ Comercio', 'Rua Vendas, 400'),
('Vendedor ABC', '98765432000188', 'Porto Alegre', 'ABC E-commerce', 'Avenida Digital, 500');

INSERT INTO TerceiroVendedorProduto (TerceiroVendedor_idTerceiroVendedor, Produto_idProduto, Quantidade) VALUES
(1, 1, 30),
(1, 5, 10),
(2, 2, 50),
(2, 6, 20);

-- Consultas para verificar a criação e os dados

SELECT * FROM Produto;
SELECT * FROM Pedido;
SELECT * FROM RelacaoDePedidoProduto;
SELECT * FROM Pagamento;
SELECT * FROM Entrega;
SELECT * FROM Fornecedor;
SELECT * FROM Estoque;
SELECT * FROM ProdutoEmEstoque;
SELECT * FROM ForneceuProduto;
SELECT * FROM TerceiroVendedor;
SELECT * FROM TerceiroVendedorProduto;

-- Recuperar números de clientes:
SELECT COUNT(*) FROM cliente;

-- Recuperação de pedido com produto associado
SELECT c.idCliente, c.Pnome, c.Sobrenome, p.idPedido, pr.DescricaoProduto, rp.Quantidade
FROM Cliente c
INNER JOIN Pedido p ON c.idCliente = p.Cliente_idCliente
INNER JOIN RelacaoDePedidoProduto rp ON p.idPedido = rp.Pedido_idPedido
INNER JOIN Produto pr ON rp.Produto_idProduto = pr.idProduto
GROUP BY c.idCliente, p.idPedido, pr.idProduto;

-- Recuperar quantos pedidos foram realizados pelos clientes
SELECT c.idCliente, c.Pnome, c.Sobrenome, COUNT(*) AS Numero_de_pedidos
FROM Cliente c
INNER JOIN Pedido p ON c.idCliente = p.Cliente_idCliente
GROUP BY c.idCliente;

-- 1. Quantos pedidos foram feitos por cada cliente?
SELECT c.idCliente, CONCAT(c.Pnome, ' ', c.Sobrenome) AS NomeCliente, COUNT(p.idPedido) AS TotalPedidos
FROM Cliente c
INNER JOIN Pedido p ON c.idCliente = p.Cliente_idCliente
GROUP BY c.idCliente
HAVING COUNT(p.idPedido) > 1 -- Filtro para clientes com mais de um pedido
ORDER BY TotalPedidos DESC;

-- 2. Algum vendedor também é fornecedor?
SELECT tv.idTerceiroVendedor, tv.RazaoSocial AS Vendedor, f.idFornecedor, f.RazaoSocial AS Fornecedor
FROM TerceiroVendedor tv
LEFT JOIN Fornecedor f ON tv.RazaoSocial = f.RazaoSocial
WHERE f.idFornecedor IS NOT NULL;

-- 3. Relação de produtos com fornecedores e estoques:
SELECT pr.DescricaoProduto, f.RazaoSocial AS Fornecedor, e.Local AS LocalEstoque, pe.Quantidade
FROM Produto pr
INNER JOIN ForneceuProduto fp ON pr.idProduto = fp.Produto_idProduto
INNER JOIN Fornecedor f ON fp.Fornecedor_idFornecedor = f.idFornecedor
INNER JOIN ProdutoEmEstoque pe ON pr.idProduto = pe.Produto_idProduto
INNER JOIN Estoque e ON pe.Estoque_idEstoque = e.idEstoque
ORDER BY pr.DescricaoProduto, f.RazaoSocial;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos:
SELECT f.RazaoSocial AS NomeFornecedor, pr.DescricaoProduto AS NomeProduto
FROM Fornecedor f
INNER JOIN ForneceuProduto fp ON f.idFornecedor = fp.Fornecedor_idFornecedor
INNER JOIN Produto pr ON fp.Produto_idProduto = pr.idProduto
ORDER BY f.RazaoSocial, pr.DescricaoProduto;

-- 5. Produtos com a maior quantidade em estoque por categoria:
SELECT pr.Categoria, pr.DescricaoProduto, MAX(pe.Quantidade) AS QuantidadeMaxima
FROM Produto pr
INNER JOIN ProdutoEmEstoque pe ON pr.idProduto = pe.Produto_idProduto
GROUP BY pr.Categoria, pr.DescricaoProduto
ORDER BY pr.Categoria, QuantidadeMaxima DESC;

-- 6. Total de vendas por tipo de pagamento e status do pedido:
SELECT p.DescricaoFormaPagamento, pd.Status, SUM(pd.Frete) AS TotalVendas
FROM Pagamento p
INNER JOIN Pedido pd ON p.Pedido_idPedido = pd.idPedido
GROUP BY p.DescricaoFormaPagamento, pd.Status
HAVING SUM(pd.Frete) > 10 -- Filtra para mostrar apenas formas de pagamento com total de vendas maior que 1000
ORDER BY TotalVendas DESC;

USE company;

DELIMITER $$

CREATE PROCEDURE ManipularCliente(
    IN acao INT,
    IN p_idCliente INT,
    IN p_Pnome VARCHAR(50),
    IN p_NomeDoMeio VARCHAR(50),
    IN p_Sobrenome VARCHAR(50),
    IN p_CPF VARCHAR(11),
    IN p_Endereco VARCHAR(255),
    IN p_DataDeNascimento DATE,
    IN p_idTipoCliente INT
)
BEGIN
    CASE acao
        WHEN 1 THEN
            -- Inserção de um novo cliente
            INSERT INTO Cliente (Pnome, NomeDoMeio, Sobrenome, CPF, Endereco, DataDeNascimento, idTipoCliente)
            VALUES (p_Pnome, p_NomeDoMeio, p_Sobrenome, p_CPF, p_Endereco, p_DataDeNascimento, p_idTipoCliente);
        
        WHEN 2 THEN
            -- Atualização de um cliente existente
            UPDATE Cliente
            SET Pnome = p_Pnome, NomeDoMeio = p_NomeDoMeio, Sobrenome = p_Sobrenome, CPF = p_CPF,
                Endereco = p_Endereco, DataDeNascimento = p_DataDeNascimento, idTipoCliente = p_idTipoCliente
            WHERE idCliente = p_idCliente;
        
        WHEN 3 THEN
            -- Remoção de um cliente
            DELETE FROM Cliente
            WHERE idCliente = p_idCliente;
        
        WHEN 4 THEN
            -- Seleção de clientes
            SELECT * FROM Cliente
            WHERE idCliente = p_idCliente;
        
        ELSE
            -- Operação inválida
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Operação inválida. Escolha 1 para INSERT, 2 para UPDATE, 3 para DELETE, 4 para SELECT.';
    END CASE;
END$$

DELIMITER ;


