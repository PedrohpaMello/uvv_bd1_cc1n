-- COMANDO PARA REMOVER O BANCO DE DADOS SE ELE JÁ EXISTIR
DROP DATABASE IF EXISTS uvv;

-- COMANDO PARA REMOVER O USUÁRIO SE ELE JÁ EXISTIR
DROP USER IF EXISTS 'pedromello'@'localhost';

-- COMANDO PARA CRIAR O USUÁRIO
CREATE USER 'pedromello'@'localhost' IDENTIFIED BY 'senha';

-- COMANDO PARA CRIAR O BANCO DE DADOS
CREATE DATABASE uvv;

-- COMANDO PARA CONCEDER PRIVILÉGIOS AO USUÁRIO PARA O BANCO DE DADOS
GRANT ALL PRIVILEGES ON uvv.* TO 'pedromello'@'localhost';

-- COMANDO PARA SELECIONAR O BANCO DE DADOS
USE uvv;

-- COMANDO QUE CRIA O SCHEMA LOJAS
CREATE SCHEMA lojas;

-- COMANDO QUE DEFINE O SCHEMA PADRÃO PARA O USUÁRIO
ALTER USER 'pedromello'@'localhost' DEFAULT SCHEMA lojas;


--COMANDO QUE CRIA A TABELA PRODUTOS
CREATE TABLE produtos (
                produto_id                        NUMERIC(38)         NOT NULL,
                nome                              VARCHAR(255)        NOT NULL,
                preco_unitario                    NUMERIC(10,2),
                detalhes                          LONGBLOB,
                imagem                            LONGBLOB,
                imagem_mime_type                  VARCHAR(512),
                imagem_arquivo                    VARCHAR(512),
                imagem_charset                    VARCHAR(512),
                imagem_ultima_atualizacao         DATE,
          
                           PRIMARY KEY (produto_id)
);
--COMANDOS DE COMENTÁRIO DA TABELA PRODUTOS
ALTER TABLE produtos COMMENT 'tabela com informações sobre os produtos';
ALTER TABLE produtos MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'código único que identifica o produto e primary key da tabela produtos';
ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(255) COMMENT 'nome do produto';
ALTER TABLE produtos MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'preco unitário do produto';
ALTER TABLE produtos MODIFY COLUMN detalhes BLOB COMMENT 'detalhes do produto';
ALTER TABLE produtos MODIFY COLUMN imagem BLOB COMMENT 'imagem do produto';
ALTER TABLE produtos MODIFY COLUMN imagem_mime_type VARCHAR(512) COMMENT 'tipo de imagem do produto';
ALTER TABLE produtos MODIFY COLUMN imagem_arquivo VARCHAR(512) COMMENT 'caminho do arquivo da imagem do produto';
ALTER TABLE produtos MODIFY COLUMN imagem_charset VARCHAR(512) COMMENT 'conjunto de caracteres utilizado para compor a imagem';
ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizacao DATE COMMENT 'data da última atualização da imagem';

--COMANDO QUE CRIA A TABELA LOJAS
CREATE TABLE Lojas (
                loja_id                            NUMERIC(38)        NOT NULL,
                nome                               VARCHAR(255)       NOT NULL,
                endereco_web                       VARCHAR(100),
                endereco_fisico                    VARCHAR(512),
                latitude                           NUMERIC,
                longitude                          NUMERIC,
                logo                               LONGBLOB,
                logo_mime_type                     VARCHAR(512),
                logo_arquivo                       VARCHAR(512),
                logo_charset                       VARCHAR(512),
                logo_ultima_atualizacao            DATE,
          
                              PRIMARY KEY (loja_id)
);

--COMENTÁRIOS DA TABELA LOJAS
ALTER TABLE Lojas COMMENT 'Tabela com as informações referentes as lojas';
ALTER TABLE Lojas MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Código único de identificação da loja';
ALTER TABLE Lojas MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome da loja';
ALTER TABLE Lojas MODIFY COLUMN endereco_web VARCHAR(100) COMMENT 'Endereço web da loja';
ALTER TABLE Lojas MODIFY COLUMN endereco_fisico VARCHAR(512) COMMENT 'Endereço físico da loja';
ALTER TABLE Lojas MODIFY COLUMN latitude NUMERIC COMMENT 'latitude referente as cordenas da loja';
ALTER TABLE Lojas MODIFY COLUMN longitude NUMERIC COMMENT 'Latitude referente as cordenadas da loja';
ALTER TABLE Lojas MODIFY COLUMN logo BLOB COMMENT 'Arquivo de imagem do logo da loja';
ALTER TABLE Lojas MODIFY COLUMN logo_mime_type VARCHAR(512) COMMENT 'Identifica o tipo de arquivo da logo';
ALTER TABLE Lojas MODIFY COLUMN logo_arquivo VARCHAR(512) COMMENT 'Caminho para o arquivo da logo da loja';
ALTER TABLE Lojas MODIFY COLUMN logo_charset VARCHAR(512) COMMENT 'conjunto de caracteres utilizados na logo';
ALTER TABLE Lojas MODIFY COLUMN logo_ultima_atualizacao DATE COMMENT 'data da última atualização da logo';

--COMANDOS QUE CRIA A TABELA ESTOQUES
CREATE TABLE estoques (
                estoque_id                        NUMERIC(38)         NOT NULL,
                loja_id                           NUMERIC(38)         NOT NULL,
                produto_id                        NUMERIC(38)         NOT NULL,
                quantidade                        NUMERIC(38)         NOT NULL,
          
                              PRIMARY KEY (estoque_id)
);

--COMENTARIOS DA TABELA ESTOQUES
ALTER TABLE estoques COMMENT 'tabela com informações referentes ao estoque dos produtos';
ALTER TABLE estoques MODIFY COLUMN estoque_id NUMERIC(38) COMMENT 'código único de identificação do estoque';
ALTER TABLE estoques MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Número único de identificação da loja na qual se localiza o estoque e foreign key vinda da tabela lojas';
ALTER TABLE estoques MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'código único de identificação de produto e foreign key vinda da tabela produtos';
ALTER TABLE estoques MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'quantidade de determiando produto no estoque';

-- COMANDO QUE CRIA A TABELA CLIENTES
CREATE TABLE clientes (
                cliente_id                        NUMERIC(38)         NOT NULL,
                nome                              VARCHAR(255)        NOT NULL,
                email                             VARCHAR(255)        NOT NULL,
                telefone1                         VARCHAR(20),
                telefone2                         VARCHAR(20),
                telefone3                         VARCHAR(20),
          
                              PRIMARY KEY (cliente_id)
);
--COMENTARIOS DA TABELA CLIENTES
ALTER TABLE clientes COMMENT 'tabela com as informações dos clientes';
ALTER TABLE clientes MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Código único que identifica cada cliente e Primary Key da tabela clientes';
ALTER TABLE clientes MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome do cliente';
ALTER TABLE clientes MODIFY COLUMN email VARCHAR(255) COMMENT 'Email de contato dos clientes';
ALTER TABLE clientes MODIFY COLUMN telefone1 VARCHAR(20) COMMENT 'Telefone de contato do cliente';
ALTER TABLE clientes MODIFY COLUMN telefone2 VARCHAR(20) COMMENT 'Segundo telefone de contato do cliente';
ALTER TABLE clientes MODIFY COLUMN telefone3 VARCHAR(20) COMMENT 'Terceiro telefone de contato do cliente';

--COMANDO QUE CRIA A TABELA PEDIDOS
CREATE TABLE pedidos (
                pedido_id                         NUMERIC(38)         NOT NULL,
                data_hora                         DATETIME            NOT NULL,
                cliente_id                        NUMERIC(38)         NOT NULL,
                status                            VARCHAR(15)         NOT NULL,
                loja_id                           NUMERIC(38)         NOT NULL,
          
                              PRIMARY KEY (pedido_id)
);
-- COMENTARIOS DA TABELA PEDIDOS
ALTER TABLE pedidos COMMENT 'tabela com as informaçóes referentes aos pedidos';
ALTER TABLE pedidos MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'Código único de identificação do pedido e Primary Key da tabela pedidos';
ALTER TABLE pedidos MODIFY COLUMN data_hora TIMESTAMP COMMENT 'Hora na qual o pedido foi realizado';
ALTER TABLE pedidos MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Código único que identifica cada cliente e foreign key vinda da tabela clientes ';
ALTER TABLE pedidos MODIFY COLUMN status VARCHAR(15) COMMENT 'Mostra o status atual do pedido';
ALTER TABLE pedidos MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Número único de identificação da loja na qual foi realizado o pedido e foreign key vinda da tabela lojas ';

--COMANDO QUE CRIA A TABELA ENVIOS
CREATE TABLE envios (
                envio_id                          NUMERIC(38)          NOT NULL,
                cliente_id                        NUMERIC(38)          NOT NULL,
                loja_id                           NUMERIC(38)          NOT NULL,
                endereco_entrega                  VARCHAR(512)         NOT NULL,
                status                            VARCHAR(15)          NOT NULL,
          
                              PRIMARY KEY (envio_id)
);
--COMENTÁRIOS DA TABELA ENVIOS
ALTER TABLE envios COMMENT 'Tabela com informações referentes aos envios';
ALTER TABLE envios MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'Código único de identificação do envio e Primary Key da tabela envios';
ALTER TABLE envios MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Código único que identifica cada cliente e foreign key vinda da tabela clientes';
ALTER TABLE envios MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Número único de identificação da loja na qual foi realizado o pedido e foreign key vinda da tabela lojas';
ALTER TABLE envios MODIFY COLUMN endereco_entrega VARCHAR(512) COMMENT 'Endereço no qual será entregue os envios';
ALTER TABLE envios MODIFY COLUMN status VARCHAR(15) COMMENT 'Mostra o status atual do envio';

--COMANDO QUE CRIA A TABELA PEDIDOS_ITENS
CREATE TABLE pedidos_itens (
                pedido_id                       NUMERIC(38)   NOT NULL,
                produto_id                      NUMERIC(38) NOT NULL,
                numero_da_linha                 NUMERIC(38) NOT NULL,
                preco_unitario                  NUMERIC(10,2) NOT NULL,
                quantidade                      NUMERIC(38) NOT NULL,
                envio_id                        NUMERIC(38) NOT NULL,
          
                          PRIMARY KEY (pedido_id, produto_id)
);

--COMENTARIOS DA TABELA PEDIDOS_ITENS
ALTER TABLE pedidos_itens COMMENT 'tabela com as informações de pedidos dos produtos';
ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'código de identificação do pedido e foreign key vinda da tabela pedidos e primary key composta da tabela pedidos_itens';
ALTER TABLE pedidos_itens MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'código de identificação do produto e foreign key vinda da tabela produtos e primary key composta da tabela pedidos_itens';
ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha NUMERIC(38) COMMENT 'número da linha do produto';
ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'preço do produto por unidade';
ALTER TABLE pedidos_itens MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'quantidade de produtos no pedido';
ALTER TABLE pedidos_itens MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'código único que identifica o envio e foreign key da tabela envios ';

--COMANDO QUE CRIA RELACIONAMENTO ENTRE PREODUTOS E ESTOQUES
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
--COMANDO QUE CRIA RELACIONAMENTO ENTRE PRODUTOS E PEDIDOS_ITENS
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
--COMANDO QUE CRIA RELACIONAMENTO ENTRE LOJAS E PEDIDOS
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
--COMANDO QUE CRIA RELACIONAMENTO ENTRE LOJAS E ENVIOS
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
--COMANDO QUE CRIA RELACIONAMENTO ENTRE LOJAS E ESTOQUES
ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
--COMANDO QUE CRIA RELACIONAMENTO ENTRE CLIENTES E ENVIOS
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
--COMANDO QUE CRIA RELACIONAMENTO ENTRE CLIENTES E PEDIDOS
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
--COMANDO QUE CRIA RELACIONAMENTO ENTRE PEDIDOS E PEDIDOS_ITENS
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
--COMANDO QUE CRIA RELACIONAMENTO ENTRE ENVIOS E PEDIDOS_ITENS
ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- CONSTRAINTS DE CHECAGEM PREÇO UNITARIO POSITIVO
ALTER TABLE produtos ADD CONSTRAINT check_preco_unitario_produtos
CHECK (preco_unitario > 0);

ALTER TABLE pedidos_itens ADD CONSTRAINT check_preco_unitario_pedidos_itens
CHECK (preco_unitario > 0);

-- CONSTRAINTS DE CHECAGEM DE STATUS DOS PEDIDOS E ENVIOS
ALTER TABLE pedidos ADD CONSTRAINT check_status_pedidos
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

ALTER TABLE envios ADD CONSTRAINT check_status_envios
CHECK (status IN ( 'CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));


-- CONSTRAINT DE CHECAGEM PARA ALTERNATIVA DE PREENCHIMENTO ENTRE ENDEREÇOS WEB E FĨSICO
ALTER TABLE lojas ADD CONSTRAINT check_endereco_lojas
CHECK ((endereco_web IS NOT NULL) OR (endereco_fisico IS NOT NULL));

-- CONSTRAINT DE QUANTIDADES POSITIVAS 
ALTER TABLE estoques ADD CONSTRAINT check_quantidade_estoques
CHECK (quantidade >= 0);

ALTER TABLE pedidos_itens ADD CONSTRAINT check_quantidade_pedidos_itens
CHECK (quantidade >= 0);

-- CONSTRAINT DE FORMATO DE EMAIL
ALTER TABLE clientes ADD CONSTRAINT check_email_clientes
CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');


























