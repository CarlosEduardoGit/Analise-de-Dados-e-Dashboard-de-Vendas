-- 1. Criar o banco de dados 'gestao'
-- (Execute este comando fora de um bloco de transação/conexão ativa no banco 'gestao')
CREATE DATABASE gestao;

-- Conecte-se ao banco 'gestao' antes de executar os comandos abaixo.

-- 2. Criar a tabela 'relatorio_vendas'
CREATE TABLE relatorio_vendas (
    id SERIAL PRIMARY KEY,
    data_venda DATE NOT NULL,
    ano INT NOT NULL,
    mes VARCHAR(4) NOT NULL,
    produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco_unitario NUMERIC(10, 2) NOT NULL,
    custo_unitario NUMERIC(10, 2) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    qtd_vendida INT NOT NULL,
    nome_comp_cliente VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    continente VARCHAR(50) NOT NULL,
    faturamento NUMERIC(10, 2) GENERATED ALWAYS AS (qtd_vendida * preco_unitario) STORED
);

-- 3. Inserir dados de exemplo (Substitua ou adicione os dados reais aqui)
INSERT INTO relatorio_vendas (data_venda, ano, mes, produto, categoria, preco_unitario, custo_unitario, marca, qtd_vendida, nome_comp_cliente, pais, continente) VALUES
('2017-06-01', 2017, 'JUN', 'Sistema de Som 7.1 Channel X711 Prata', 'Sistema de Som', 1109.00, 367.43, 'Litware', 1, 'Vicente Pinheiro', 'França', 'Europa'),
('2017-06-01', 2017, 'JUN', '180 CFM Ventilador de Coluna X450 Preto', 'Ventiladores', 215.62, 71.44, 'Litware', 1, 'Marlon Lopez', 'Estados Unidos', 'América do Norte'),
('2017-06-01', 2017, 'JUN', '180 CFM Ventilador de Coluna X450 Preto', 'Ventiladores', 215.62, 71.44, 'Litware', 1, 'Martin Gonzalez', 'Chile', 'América do Sul'),
('2017-06-01', 2017, 'JUN', '180 CFM Ventilador de Coluna X450 Preto', 'Ventiladores', 215.62, 71.44, 'Litware', 1, 'Martin Gonzalez', 'Chile', 'América do Sul'),
('2017-06-01', 2017, 'JUN', '180 CFM Ventilador de Coluna X450 Preto', 'Ventiladores', 215.62, 71.44, 'Litware', 1, 'Martin Gonzalez', 'Chile', 'América do Sul'),
('2017-06-01', 2017, 'JUN', '180 CFM Ventilador de Coluna X450 Preto', 'Ventiladores', 215.62, 71.44, 'Litware', 1, 'Martin Gonzalez', 'Chile', 'América do Sul');




-- ==============================================================================
-- CONSULTAS (SELECTS) SOLICITADAS
-- ==============================================================================

-- a) Total do Faturamento Geral
SELECT 
    SUM(faturamento) AS faturamento_total
FROM relatorio_vendas;


-- b) Produto Mais Vendido (por quantidade de unidades vendidas)
SELECT 
    produto, 
    SUM(qtd_vendida) AS total_quantidade_vendida,
    SUM(faturamento) AS faturamento_total_produto
FROM relatorio_vendas
GROUP BY produto
ORDER BY total_quantidade_vendida DESC
LIMIT 1;


-- c) Faturamento e Quantidade Vendida por Ano e Mês
SELECT 
    EXTRACT(YEAR FROM ano) AS ano,
    EXTRACT(MONTH FROM mes) AS mes,
    SUM(qtd_vendida) AS quantidade_vendida,
    SUM(faturamento) AS faturamento
FROM relatorio_vendas
GROUP BY 
    EXTRACT(YEAR FROM ano),
    EXTRACT(MONTH FROM mes)
ORDER BY ano, mes;


-- d) Faturamento por Marca
SELECT 
    marca,
    SUM(faturamento) AS faturamento
FROM relatorio_vendas
GROUP BY marca
ORDER BY faturamento DESC;


-- e) Faturamento por Continente
SELECT 
    continente,
    SUM(faturamento) AS faturamento
FROM relatorio_vendas
GROUP BY continente
ORDER BY faturamento DESC;


-- Altere o tipo da coluna na tabela (exemplo PostgreSQL):
ALTER TABLE relatorio_vendas 
ALTER COLUMN ano TYPE INT 
USING EXTRACT(YEAR FROM ano)::INT;

ALTER TABLE relatorio_vendas 
ALTER COLUMN mes TYPE VARCHAR 
USING EXTRACT(MONTH FROM mes)::VARCHAR;