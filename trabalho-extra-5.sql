-- ============================================
-- TABELA: categoria
-- ============================================
CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- ============================================
-- TABELA: produto
-- ============================================
CREATE TABLE produto (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    categoria_id INT,
    CONSTRAINT fk_produto_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categoria(id)
);

-- ============================================
-- TABELA: cliente
-- ============================================
CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL
);

-- ============================================
-- TABELA: pedido
-- ============================================
CREATE TABLE pedido (
    id SERIAL PRIMARY KEY,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) NOT NULL,
    cliente_id INT,
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES cliente(id)
);

INSERT INTO categoria (nome) VALUES
('Informática'),
('Periféricos'),
('Games'),
('Escritório');

INSERT INTO produto (nome, preco, estoque, categoria_id) VALUES
('Notebook Dell Inspiron', 3500.00, 8, 1),
('Mouse Gamer Redragon', 120.00, 25, 2),
('Teclado Mecânico RGB', 280.00, 12, 2),
('Monitor LG 24', 899.90, 7, 1),
('Headset HyperX', 310.00, 10, 3),
('Cadeira de Escritório', 650.00, 5, 4),
('Controle Xbox', 399.90, 9, 3),
('Webcam Full HD', 220.00, 14, 1),
('Mousepad Speed', 59.90, 30, 3),
('Impressora Multifuncional', 780.00, 4, 4);


INSERT INTO cliente (nome, email, cidade) VALUES
('Ana Souza', 'ana@email.com', 'Porto Alegre'),
('Bruno Lima', 'bruno@email.com', 'São Leopoldo'),
('Carla Mendes', 'carla@email.com', 'Novo Hamburgo'),
('Diego Alves', 'diego@email.com', 'Canoas'),
('Eduarda Silva', 'eduarda@email.com', 'Porto Alegre'),
('Felipe Costa', 'felipe@email.com', 'Gravataí'),
('Gabriela Rocha', 'gabriela@email.com', 'São Leopoldo'),
('Henrique Martins', 'henrique@email.com', 'Cachoeirinha');

INSERT INTO pedido (data_pedido, valor_total, status, cliente_id) VALUES
('2026-06-01', 3500.00, 'Pendente', 1),
('2026-06-02', 179.90, 'Pago', 2),
('2026-06-03', 899.90, 'Enviado', 3),
('2026-06-05', 650.00, 'Pendente', 4),
('2026-06-07', 399.90, 'Pago', 5),
('2026-06-08', 220.00, 'Cancelado', 6),
('2026-06-10', 310.00, 'Enviado', 7),
('2026-06-11', 780.00, 'Pago', 8);

SELECT * FROM categoria
SELECT * FROM produto
SELECT * FROM cliente
SELECT * FROM pedido


--Exercício 1 – Atualizando Produtos
--Faça as seguintes alterações na tabela produto:

--1.Atualize o preço do Notebook Dell Inspiron para 3699.90.

UPDATE produto
SET preco = 3699.90
WHERE id = 1;

--2.Atualize o preço e o estoque do Mouse Gamer Redragon para 129.90 e 20, respectivamente.

UPDATE produto
SET preco = 129.90, 
    estoque = 20
WHERE id = 9;

--3.Altere a categoria do produto Webcam Full HD para a categoria Periféricos.

UPDATE produto
SET categoria_id = 1, 
    nome = 'Periféricos'
WHERE id = 2;

--Exercício 2 – Atualizando Clientes e Pedidos

--1.Atualize a cidade da cliente Ana Souza para Sapucaia do Sul.

UPDATE cliente
SET cidade = 'Sapucaia do Sul'
WHERE id = 1;

--2.Atualize o e-mail de Bruno Lima para bruno.lima@email.com.

UPDATE cliente
SET email = 'bruno.lima@email.com'
WHERE id = 2;

--3.Atualize o status do pedido de id = 4 para Enviado.

UPDATE pedido
SET status = 'Enviado'
WHERE id = 4;

--Exercício 3 – Removendo Registros

--1.Remova o produto Mousepad Speed.

DELETE FROM produto
WHERE id = 9

--2.Remova o cliente com id = 8.

DELETE FROM pedido
WHERE cliente_id = 8;

DELETE FROM cliente
WHERE id = 8;

--3.Remova todos os pedidos com status Cancelado.

SELECT * FROM pedido

DELETE FROM pedido
WHERE id = 6;

--Warning
--Antes de usar DELETE, faça um SELECT para conferir quais registros serão afetados.

--Exercício 4 – Consultas com WHERE
--Crie consultas para listar:

--1.Todos os produtos com estoque menor que 10.

SELECT *
FROM produto
WHERE estoque < 10;

--2.Todos os produtos com preço maior que 500.

SELECT *
FROM produto
WHERE preco > 500;

--3.Todos os clientes da cidade Porto Alegre.

SELECT *
FROM cliente
WHERE cidade = 'Porto Alegre'

--4.Todos os pedidos com status Pago.

SELECT *
FROM pedido
WHERE status = 'Pago'

--Exercício 5 – Consultas com ORDER BY
--Crie consultas para exibir:

--1.Todos os produtos em ordem alfabética pelo nome.

SELECT *
FROM produto
ORDER BY nome ASC;

--2.Todos os produtos do mais caro para o mais barato.

SELECT *
FROM produto
ORDER BY preco DESC;

--3.Todos os clientes em ordem alfabética decrescente.

SELECT *
FROM cliente
ORDER BY nome DESC;

--4.Todos os pedidos ordenados pela data do mais antigo para o mais recente.

SELECT *
FROM pedido
ORDER BY data_pedido DESC;

--Exercício 6 – Consultas com LIMIT
--Crie consultas para mostrar:

--1.Os 3 primeiros produtos cadastrados.

SELECT *
FROM produto
LIMIT 3;

--2.Os 5 primeiros clientes cadastrados.

SELECT *
FROM cliente
LIMIT 5;

--3.Os 2 pedidos de maior valor.

SELECT *
FROM pedido
ORDER BY valor_total DESC
LIMIT 2;

--Exercício 7 – WHERE + ORDER BY
--Crie consultas para listar:

--1.Os produtos com estoque menor que 15, ordenados por estoque em ordem crescente.

SELECT *
FROM produto
WHERE estoque < 15
ORDER BY estoque ASC;

--2.Os pedidos com valor maior que 300, do maior para o menor valor.

SELECT *
FROM pedido
WHERE valor_total > 300
ORDER BY valor_total DESC;

--3.Os produtos da categoria 1, ordenados pelo nome.

SELECT *
FROM produto
WHERE categoria_id = 1
ORDER BY nome;

--Desafio
--A loja identificou alguns problemas no sistema e precisa que você corrija e consulte os dados.

--Situação

--1.O preço do Headset HyperX deve ser atualizado para 289.90.

UPDATE produto
SET preco = 289.90
WHERE id = 5;

--2.O estoque da Impressora Multifuncional deve passar para 6 unidades.

UPDATE produto
SET estoque = 6
WHERE id = 10;

--3.O cliente Felipe Costa mudou de cidade para São Leopoldo.

UPDATE cliente
SET cidade = 'São Leopoldo'
WHERE id = 6;


--4.O pedido de id = 6 foi cancelado por engano e deve ter o status alterado para Pago.

INSERT INTO pedido (data_pedido, valor_total, status, cliente_id)
VALUES
    ('2026-06-08', 220.00, 'Cancelado', 6);

UPDATE pedido
SET status = 'Pago'
WHERE cliente_id = 6;

--5.O produto Controle Xbox não será mais vendido e deve ser removido do sistema.

DELETE FROM produto
WHERE id = 7;

--6.Após as alterações, exiba:

--todos os produtos em ordem decrescente de preço;

SELECT *
FROM produto
ORDER BY preco DESC;

--os pedidos com valor maior que 300;

SELECT *
FROM pedido
WHERE valor_total > 300;

--os 5 primeiros clientes em ordem alfabética.

SELECT *
FROM cliente
ORDER BY nome ASC
LIMIT 5;
