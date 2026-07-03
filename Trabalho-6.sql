TABELA: clientes
-- =========================================================

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT,
    cidade VARCHAR(100) NOT NULL
);

-- =========================================================
-- TABELA: produtos
-- =========================================================

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    preco NUMERIC(10,2) NOT NULL
);

-- =========================================================
-- TABELA: compras
-- =========================================================

CREATE TABLE compras (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0), -- Este código gera verifica se a quantidade é acima de 0
    data_compra DATE NOT NULL,

    CONSTRAINT fk_compras_clientes
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(id),

    CONSTRAINT fk_compras_produtos
        FOREIGN KEY (produto_id)
        REFERENCES produtos(id)
);

-- =========================================================
-- DADOS DE EXEMPLO
-- =========================================================

INSERT INTO clientes (nome, idade, cidade) VALUES
('Ana Fernandes', 28, 'São Paulo'),
('Bruno Lima', 35, 'Canoas'),
('Carla Souza', 22, 'Porto Alegre'),
('Diego Martins', 40, 'Salvador'),
('Eduarda Alves', 31, 'Canoas'),
('Felipe Rocha', 27, 'São Paulo'),
('Gabriela Costa', 45, 'Salvador'),
('Henrique Dias', 19, 'Porto Alegre');

INSERT INTO produtos (nome, categoria, preco) VALUES
('Notebook Gamer Nitro', 'Informática', 4500.00),
('Notebook Ultra Slim', 'Informática', 3200.00),
('Mouse Gamer RGB', 'Eletrônicos', 180.00),
('Teclado Mecânico', 'Eletrônicos', 350.00),
('Monitor 24 Polegadas', 'Eletrônicos', 1200.00),
('Gamepad 54', 'Games', 250.00),
('Camiseta Star Wars', 'Vestuário', 89.90),
('Camiseta Naruto', 'Vestuário', 79.90),
('SSD 1TB', 'Informática', 550.00),
('Headset Gamer', 'Eletrônicos', 420.00);

INSERT INTO compras (cliente_id, produto_id, quantidade, data_compra) VALUES
(1, 1, 1, '2025-01-10'), -- Ana -> Notebook Gamer Nitro
(1, 7, 2, '2025-02-15'), -- Ana -> Camiseta Star Wars
(1, 6, 1, '2025-02-20'), -- Ana -> Gamepad 54

(2, 3, 2, '2025-01-12'), -- Bruno -> Mouse Gamer RGB
(2, 5, 1, '2025-02-03'), -- Bruno -> Monitor
(2, 8, 3, '2025-02-25'), -- Bruno -> Camiseta Naruto

(3, 2, 1, '2025-01-22'), -- Carla -> Notebook Ultra Slim
(3, 6, 1, '2025-02-11'), -- Carla -> Gamepad 54

(4, 9, 1, '2025-02-08'), -- Diego -> SSD
(4, 10, 1, '2025-03-01'), -- Diego -> Headset

(5, 4, 1, '2025-02-14'), -- Eduarda -> Teclado
(5, 3, 2, '2025-03-02'), -- Eduarda -> Mouse

(6, 1, 1, '2025-02-05'), -- Felipe -> Notebook Gamer Nitro
(6, 6, 2, '2025-02-18'), -- Felipe -> Gamepad 54

(7, 2, 1, '2025-01-30'), -- Gabriela -> Notebook Ultra Slim
(7, 9, 1, '2025-02-28'), -- Gabriela -> SSD

(8, 7, 1, '2025-02-07'); -- Henrique -> Camiseta Star Wars

--🏋️ Exercícios
--1.Liste o nome dos clientes e os produtos que eles compraram.

SELECT clientes.nome AS clientes, produtos.nome AS produtos
FROM clientes, produtos, compras
WHERE compras.cliente_id = clientes.id
AND compras.produto_id = produtos.id;

--2.Mostre os clientes que compraram mais de 1 unidade de qualquer produto.

SELECT clientes.nome AS clientes, produtos.nome AS produtos, compras.quantidade AS compras
FROM clientes, produtos, compras
WHERE compras.cliente_id = clientes.id
AND compras.produto_id = produtos.id
AND quantidade > 1;

--3.Liste os produtos da categoria "Eletrônicos" comprados por clientes de Canoas.

SELECT clientes.nome AS clientes, produtos.nome AS produtos, produtos.categoria 
FROM clientes, produtos, compras
WHERE compras.cliente_id = clientes.id
AND compras.produto_id = produtos.id
AND clientes.cidade = 'Canoas'
AND produtos.categoria = 'Eletrônicos';

--4.Mostre os clientes que compraram "Gamepad 54".

SELECT clientes.nome AS clientes, produtos.nome AS produtos
FROM clientes, produtos, compras
WHERE compras.cliente_id = clientes.id
AND compras.produto_id = produtos.id
AND produtos.nome = 'Gamepad 54';

--5.Liste todos os clientes que já compraram "Notebook".

SELECT c.nome AS cliente, p.nome AS produto
FROM clientes c, compras co, produtos p
WHERE c.id = co.cliente_id
  AND p.id = co.produto_id
  AND p.nome LIKE '%Notebook%';

--6.Mostre os nomes dos clientes e os preços dos produtos comprados acima de R$ 1500.

SELECT c.nome AS cliente, p.nome AS produto, p.preco
FROM clientes c, compras co, produtos p
WHERE c.id = co.cliente_id
  AND p.id = co.produto_id
  AND p.preco > 1500;

--7.Liste clientes de Salvador que compraram produtos da categoria "Informática".

SELECT clientes.nome AS clientes, produtos.nome AS produtos, produtos.categoria, clientes.cidade AS cidade
FROM clientes, produtos, compras
WHERE compras.cliente_id = clientes.id
AND compras.produto_id = produtos.id
AND clientes.cidade = 'Salvador'
AND produtos.categoria = 'Informática';

--8.Mostre todos os produtos que a cliente "Ana Fernandes" já comprou.

SELECT clientes.nome AS clientes, produtos.nome AS produtos
FROM clientes, produtos, compras
WHERE compras.cliente_id = clientes.id
AND compras.produto_id = produtos.id
AND clientes.nome = 'Ana Fernandes'

--9.Liste todos os clientes que compraram produtos cujo nome começa com "Camiseta".

SELECT clientes.nome AS clientes, produtos.nome AS produtos
FROM clientes, produtos, compras
WHERE compras.cliente_id = clientes.id
AND compras.produto_id = produtos.id
AND produtos.nome LIKE '%Camiseta%';
 
--10.Mostre todos os clientes e produtos comprados em fevereiro de 2025.

--Exemplo.1
SELECT c.nome, p.nome, co.data_compra
FROM clientes c, compras co, produtos p
WHERE c.id = co.cliente_id
AND p.id = co.produto_id
AND co.data_compra BETWEEN '2025-02-01' AND '2025-02-28';

--Exemplo.2
SELECT c.nome AS clientes, p.nome AS produtos, co.data_compra AS compras
FROM clientes c, compras co, produtos p
WHERE c.id = co.cliente_id
  AND p.id = co.produto_id
  AND EXTRACT(MONTH FROM co.data_compra) = 2
  AND EXTRACT(YEAR FROM co.data_compra) = 2025;

--💡 Desafio Extra
--Monte uma consulta que mostre:

--1.nome do cliente

SELECT c.nome AS clientes
FROM clientes c, compras co, produtos p
WHERE c.id = co.cliente_id
AND p.id = co.produto_id

--2.nome do produto

SELECT p.nome AS produtos
FROM clientes c, compras co, produtos p
WHERE c.id = co.cliente_id
AND p.id = co.produto_id

--3.quantidade comprada

SELECT produtos.nome AS produtos, compras.quantidade AS compras
FROM clientes, produtos, compras
WHERE compras.cliente_id = clientes.id
AND compras.produto_id = produtos.id;

--4.preço do produto

SELECT produtos.preco AS produtos
FROM clientes, produtos, compras
WHERE compras.cliente_id = clientes.id
AND compras.produto_id = produtos.id;

--5.valor total da compra (quantidade * preco)

SELECT  produtos.preco AS produtos, compras.quantidade AS compras
FROM clientes, produtos, compras
WHERE compras.cliente_id = clientes.id
AND compras.produto_id = produtos.id;

--Ordene do maior valor total para o menor.

SELECT c.nome AS cliente, p.nome AS produto, p.preco, co.quantidade AS quantidade, (co.quantidade * p.preco) AS valor_total
FROM clientes c, compras co, produtos p
WHERE c.id = co.cliente_id
AND p.id = co.produto_id
ORDER BY c.nome ASC, p.preco DESC;

