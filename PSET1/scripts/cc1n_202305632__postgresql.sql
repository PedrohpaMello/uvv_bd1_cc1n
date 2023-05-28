-- PSET1 
-- ALUNO: PEDRO HENRIQUE PIMENTEL MELLO DE ALMEIDA
-- MATRÍCULA: 202305632

-- COMANDO PARA REMOVER O BANCO DE DADOS SE ELE JA EXISTIR
DROP DATABASE  IF EXISTS uvv;

-- COMANDO PARA REMOVER O USUÁRIO SE ELE JA EXISTIR
DROP USER IF EXISTS pedromello;

-- COMANDO PARA CRIAR O USUÁRIO
CREATE USER 
		pedromello WITH ENCRYPTED PASSWORD 'senha'
		CREATEDB
		CREATEROLE
		LOGIN;

--COMANDO PARA CRIAR O BANCO DE DADOS
CREATE DATABASE uvv WITH 

		OWNER 			= pedromello
		TEMPLATE 		= template0 
		ENCODING 		= 'UTF8'  
		LC_COLLATE 		= 'pt_BR.UTF-8' 
		LC_CTYPE 		= 'pt_BR.UTF-8'  
		ALLOW_CONNECTIONS	= TRUE; 
            
--COMANDO PARA SE CONECTAR AO BANCO DE DADOS
\c 'dbname=uvv user=pedromello password=senha'	
          
--COMANDO QUE CRIA O SCHEMA LOJAS 
CREATE SCHEMA lojas
AUTHORIZATION pedromello;

--COMANDO QUE DEFINE O SCHEMA PADRÁO PARA O USUÁRIO
ALTER USER pedromello
SET SEARCH_PATH TO lojas, "$user", public;
          

-- COMANDO PARA CRIAÇÃO DA TABELA PRODUTOS
CREATE TABLE produtos (

  	     produto_id				NUMERIC(38)	NOT NULL,
  	     nome				VARCHAR(255)	NOT NULL,
  	     preco_unitario			NUMERIC(10,2),
  	     detalhes				BYTEA,
  	     imagem				BYTEA,
             imagem_mime_type			VARCHAR(512),
  	     imagem_arquivo			VARCHAR(512),
  	     imagem_charset			VARCHAR(512),
  	     imagem_ultima_atualizacao		DATE,
  					
  	         CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);



-- COMENTÁRIOS DAS COLUNAS DA TABELA PRODUTOS
COMMENT ON TABLE produtos IS 'tabela com informações sobre os produtos';
COMMENT ON COLUMN produtos.produto_id IS 'código único que identifica o produto (primary key da tabela produtos)';
COMMENT ON COLUMN produtos.nome IS 'nome do produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'preco unitário do produto';
COMMENT ON COLUMN produtos.detalhes IS 'detalhes do produto';
COMMENT ON COLUMN produtos.imagem IS 'imagem do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'tipo de imagem do produto';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'caminho do arquivo da imagem do produto';
COMMENT ON COLUMN produtos.imagem_charset IS 'conjunto de caracteres utilizado para compor a imagem';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'data da última atualização da imagem';

-- COMANDO PARA A CRIAÇÃO DA TABELA LOJAS
CREATE TABLE Lojas (

             loja_id      			NUMERIC(38) 	NOT NULL,
             nome 	     			VARCHAR(255) 	NOT NULL,
             endereco_web 			VARCHAR(100),
             endereco_fisico 			VARCHAR(512),
             latitude 				NUMERIC,
             longitude 				NUMERIC,
             logo 				BYTEA,
             logo_mime_type  			VARCHAR(512),
             logo_arquivo   			VARCHAR,
             logo_charset    			VARCHAR(512),
             logo_ultima_atualizacao 		DATE,

                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

-- COMENTÁRIOS DAS COLUNAS DA TABELA LOJAS
COMMENT ON TABLE Lojas IS 'Tabela com as informações referentes as lojas ';
COMMENT ON COLUMN Lojas.loja_id IS 'Código único de identificação da loja';
COMMENT ON COLUMN Lojas.nome IS 'Nome da loja';
COMMENT ON COLUMN Lojas.endereco_web IS 'Endereço web da loja';
COMMENT ON COLUMN Lojas.endereco_fisico IS 'Endereço físico da loja';
COMMENT ON COLUMN Lojas.latitude IS 'latitude referente as cordenas da loja';
COMMENT ON COLUMN Lojas.longitude IS 'Latitude referente as cordenadas da loja';
COMMENT ON COLUMN Lojas.logo IS 'Arquivo de imagem do logo da loja';
COMMENT ON COLUMN Lojas.logo_mime_type IS 'Identifica o tipo de arquivo da logo';
COMMENT ON COLUMN Lojas.logo_arquivo IS 'Caminho para o arquivo da logo da loja';
COMMENT ON COLUMN Lojas.logo_charset IS 'conjunto de caracteres utilizados na logo';
COMMENT ON COLUMN Lojas.logo_ultima_atualizacao IS 'data da última atualização da logo';

-- COMANDO DE CRIAÇÃO DA TABELA ESTOQUES
CREATE TABLE estoques (
             estoque_id 			NUMERIC(38) NOT NULL,
             loja_id 				NUMERIC(38) NOT NULL,
             produto_id 			NUMERIC(38) NOT NULL,
             quantidade 			NUMERIC(38) NOT NULL,
                
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
                
--COMENTARIOS DA TABELA ESTOQUES
);
COMMENT ON TABLE estoques IS 'tabela com informações referentes ao estoque dos produtos';
COMMENT ON COLUMN estoques.estoque_id IS 'código único de identificação do estoque';
COMMENT ON COLUMN estoques.loja_id IS 'Número único de identificação da loja na qual se localiza o estoque(foreign key vinda da tabela lojas)';
COMMENT ON COLUMN estoques.produto_id IS 'código único de identificação de produto (foreign key vinda da tabela produtos)';
COMMENT ON COLUMN estoques.quantidade IS 'quantidade de determiando produto no estoque';

--COMANDO DE CRIAÇÃO DA TABELA CLIENTES

CREATE TABLE clientes (

             cliente_id 			NUMERIC(38) 	 NOT NULL,
             nome 				VARCHAR(255)	 NOT NULL,
             email 				VARCHAR(255) 	 NOT NULL,
             telefone1 				VARCHAR(20),
             telefone2 				VARCHAR(20),
             telefone3 				VARCHAR(20),


                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
-- COMENTÁRIOS DA TABELA CLIENTES
COMMENT ON TABLE clientes IS 'tabela com as informações dos clientes ';
COMMENT ON COLUMN clientes.cliente_id IS 'Código único que identifica cada cliente (Primary Key da tabela clientes)';
COMMENT ON COLUMN clientes.nome IS 'Nome do cliente';
COMMENT ON COLUMN clientes.email IS 'Email de contato dos clientes';
COMMENT ON COLUMN clientes.telefone1 IS 'Telefone de contato do cliente';
COMMENT ON COLUMN clientes.telefone2 IS 'Segundo telefone de contato do cliente';
COMMENT ON COLUMN clientes.telefone3 IS 'Terceiro telefone de contato do cliente';

--COMANDO DE CRIAÇÃO DA TABELA PEDIDOS
CREATE TABLE pedidos (

             pedido_id 			  NUMERIC(38) 	NOT NULL,
             data_hora 			  TIMESTAMP 	NOT NULL,
             cliente_id 		  NUMERIC(38) 	NOT NULL,
             status			  VARCHAR(15) 	NOT NULL,
             loja_id 			  NUMERIC(38) 	NOT NULL,

                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
--COMENTÁRIOS DAS COLUNAS DA TABELA PEDIDOS
COMMENT ON TABLE pedidos IS 'tabela com as informaçóes referentes aos pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 'Código único de identificação do pedido (Primary Key da tabela pedidos)';
COMMENT ON COLUMN pedidos.data_hora IS 'Hora na qual o pedido foi realizado';
COMMENT ON COLUMN pedidos.cliente_id IS 'Código único que identifica cada cliente (foreign key vinda da tabela clientes)';
COMMENT ON COLUMN pedidos.status IS 'Mostra o status atual do pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'Número único de identificação da loja na qual foi realizado o pedido (foreign key vinda da tabela lojas)';

--COMANDO DE CRIAÇÃO DA TABELA ENVIOS
CREATE TABLE envios (
             envio_id 			  NUMERIC(38)  NOT NULL,
             cliente_id 		  NUMERIC(38)  NOT NULL,
             loja_id 			  NUMERIC(38)  NOT NULL,
             endereco_entrega 		  VARCHAR(512) NOT NULL,
             status 			  VARCHAR(15)  NOT NULL,
                
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
--COMENTARIOS DAS COLUNAS DA TABELA ENVIOS
);
COMMENT ON TABLE envios IS 'Tabela com informações referentes aos envios';
COMMENT ON COLUMN envios.envio_id IS 'Código único de identificação do envio (Primary Key da tabela envios)';
COMMENT ON COLUMN envios.cliente_id IS 'Código único que identifica cada cliente (foreign key vinda da tabela clientes)';
COMMENT ON COLUMN envios.loja_id IS 'Número único de identificação da loja na qual foi realizado o pedido (foreign key vinda da tabela lojas)';
COMMENT ON COLUMN envios.endereco_entrega IS 'Endereço no qual será entregue os envios';
COMMENT ON COLUMN envios.status IS 'Mostra o status atual do envio';

--COMANDO DE CRIÇÃO DA TABELA PEDIDOS_ITENS
CREATE TABLE pedidos_itens (

             pedido_id 			NUMERIC(38)	NOT NULL,
             produto_id 		NUMERIC(38) 	NOT NULL,
             numero_da_linha 		NUMERIC(38) 	NOT NULL,
             preco_unitario 		NUMERIC(10,2)   NOT NULL,
             quantidade 		NUMERIC(38) 	NOT NULL,
             envio_id 			NUMERIC(38) 	NOT NULL,

                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);
--COMENTÁRIOS DA TABELA 
COMMENT ON TABLE pedidos_itens IS ' tabela com as informações de pedidos dos produtos ';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'código de identificação do pedido (foreign key vinda da tabela pedidos e primary key composta da tabela pedidos_itens)';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'código de identificação do produto (foreign key vinda da tabela produtos e primary key composta da tabela pedidos_itens)';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'número da linha do produto';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'preço do produto por unidade';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'quantidade de produtos no pedido';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'código único que identifica o envio (foreign key da tabela envios)';

-- CONSTRAINT QUE DEFINE A FOREIGN KEY ENTRE AS TABELAS PRODUTOS E ESTOQUES
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CONSTRAINT QUE DEFINE A FOREIGN KEY ENTRE AS TABELAS PRODUTOS E PEDIDOS_ITENS
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CONSTRAINT QUE DEFINE A FOREIGN KEY ENTRE AS TABELAS LOJAS E PEDIDOS
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CONSTRAINT QUE DEFINE A FOREIGN KEY ENTRE AS TABELAS LOJAS E ENVIOS
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CONSTRAINT QUE DEFINE A FOREIGN KEY ENTRE AS TABELAS LOJAS E ESTOQUES
ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CONSTRAINT QUE DEFINE A FOREIGN KEY ENTRE AS TABELAS CLIENTES E ENVIOS
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CONSTRAINT QUE DEFINE A FOREIGN KEY ENTRE AS TABELAS CLIENTES E PEDIDOS
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CONSTRAINT QUE DEFINE A FOREIGN KEY ENTRE AS TABELAS PEDIDOS E PEDIDOS_ITENS
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CONSTRAINT QUE DEFINE A FOREIGN KEY ENTRE AS TABELAS ENVIOS E PEDIDOS_ITENS
ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

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



























