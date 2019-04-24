--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7 (Ubuntu 10.7-0ubuntu0.18.10.1)
-- Dumped by pg_dump version 10.7 (Ubuntu 10.7-0ubuntu0.18.10.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: valortotal_pedido(integer, integer); Type: FUNCTION; Schema: public; Owner: renan
--

CREATE FUNCTION public.valortotal_pedido(id_cliente integer, num_pedido1 integer) RETURNS real
    LANGUAGE plpgsql
    AS $$																																																																																																																																																																																																																	
DECLARE
	precoTotal REAL;
	resultado REAL;
BEGIN 
	IF EXISTS (SELECT PTP.num_pedido FROM Pedidos_Tem_Produtos AS PTP WHERE PTP.num_pedido = num_pedido1) THEN
		SELECT SUM(PTP.preco*PTP.quantidade) INTO precoTotal FROM Pedidos_Tem_Produtos AS PTP
		WHERE PTP.num_cliente = id_cliente AND 
			PTP.num_pedido = num_pedido1;
		
		RETURN precoTotal;
	ELSE
		RETURN -1;
	END IF;

	/*Solução do prof. André*/
	/*SELECT SUM(PTP.preco) INTO precoTotal FROM Pedidos_Tem_Produtos AS PTP
	WHERE PTP.num_cliente = id_cliente AND 
	      PTP.num_pedido = num_pedido1;																																			

	IF precoTotal > 0 THEN
		RETURN precoTotal;
	ELSE
		RETURN -1;
	END IF;*/
END;
$$;


ALTER FUNCTION public.valortotal_pedido(id_cliente integer, num_pedido1 integer) OWNER TO renan;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alunos; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.alunos (
    ra character varying(100) NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.alunos OWNER TO renan;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.cliente (
    num_cliente integer NOT NULL,
    nome character varying(100) NOT NULL,
    endereco character varying(100),
    num_telefone character varying(100),
    pais character varying(100)
);


ALTER TABLE public.cliente OWNER TO renan;

--
-- Name: fornecedor; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.fornecedor (
    num_fornecedor integer NOT NULL,
    nome character varying(100),
    endereco character varying(100),
    num_telefone character varying(100),
    pais character varying(100)
);


ALTER TABLE public.fornecedor OWNER TO renan;

--
-- Name: fornecedor_produto; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.fornecedor_produto (
    num_fornecedor integer NOT NULL,
    id_produto integer NOT NULL
);


ALTER TABLE public.fornecedor_produto OWNER TO renan;

--
-- Name: inscreve; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.inscreve (
    ra character varying(100) NOT NULL,
    titulo character varying(100) NOT NULL
);


ALTER TABLE public.inscreve OWNER TO renan;

--
-- Name: nalunos; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.nalunos (
    nome character varying(100) NOT NULL,
    rg character varying(100) NOT NULL,
    orgaoexp character varying(100) NOT NULL
);


ALTER TABLE public.nalunos OWNER TO renan;

--
-- Name: no_inscreve; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.no_inscreve (
    rg character varying(100) NOT NULL,
    orgaoexp character varying(100) NOT NULL,
    titulo character varying(100) NOT NULL
);


ALTER TABLE public.no_inscreve OWNER TO renan;

--
-- Name: listagens; Type: VIEW; Schema: public; Owner: renan
--

CREATE VIEW public.listagens AS
 SELECT concat(a.nome, ' ', a.ra) AS documento,
    inscreve.titulo AS palestra
   FROM (public.alunos a
     JOIN public.inscreve USING (ra))
UNION
 SELECT concat(na.nome, ' ', na.rg, '/', na.orgaoexp) AS documento,
    no_inscreve.titulo AS palestra
   FROM (public.nalunos na
     JOIN public.no_inscreve USING (rg, orgaoexp))
  ORDER BY 1;


ALTER TABLE public.listagens OWNER TO renan;

--
-- Name: palestra; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.palestra (
    dadospalestrante character varying(100),
    titulo character varying(100) NOT NULL,
    resumo character varying(500),
    nome character varying(100),
    tempoduracao time without time zone
);


ALTER TABLE public.palestra OWNER TO renan;

--
-- Name: palestrante; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.palestrante (
    nome character varying(100) NOT NULL,
    dados character varying(100)
);


ALTER TABLE public.palestrante OWNER TO renan;

--
-- Name: pedido; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.pedido (
    num_pedido integer NOT NULL,
    num_cliente integer NOT NULL
);


ALTER TABLE public.pedido OWNER TO renan;

--
-- Name: pedidos_tem_produtos; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.pedidos_tem_produtos (
    num_pedido integer NOT NULL,
    num_cliente integer NOT NULL,
    num_fornecedor integer NOT NULL,
    id_produto integer NOT NULL,
    data_pedido character varying(100),
    quantidade integer,
    preco real
);


ALTER TABLE public.pedidos_tem_produtos OWNER TO renan;

--
-- Name: produto; Type: TABLE; Schema: public; Owner: renan
--

CREATE TABLE public.produto (
    id_produto integer NOT NULL,
    marca character varying(100),
    tamanho character varying(100)
);


ALTER TABLE public.produto OWNER TO renan;

--
-- Data for Name: alunos; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.alunos (ra, nome) FROM stdin;
1602098	Renan Kodama Rodrigues
1602099	Jesus Jeová Messias
1602100	Lucifer Luz Baphomet
\.


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.cliente (num_cliente, nome, endereco, num_telefone, pais) FROM stdin;
1602098	Renan Kodama Rodrigues	Campo Mourão	3322-7630	Brasil
\.


--
-- Data for Name: fornecedor; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.fornecedor (num_fornecedor, nome, endereco, num_telefone, pais) FROM stdin;
7777	Jesus Cristo	Heaven	777-777	Depois Da Morte
6666	Lucifer StarLight	Hell	666-666	Depois Da Morte
\.


--
-- Data for Name: fornecedor_produto; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.fornecedor_produto (num_fornecedor, id_produto) FROM stdin;
7777	77
7777	66
6666	66
\.


--
-- Data for Name: inscreve; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.inscreve (ra, titulo) FROM stdin;
1602098	Como Dominar o Mundo
1602099	Como Dominar o Mundo
1602100	Como Dominar o Mundo
1602098	Paz
1602098	Algum Titulo Legal
\.


--
-- Data for Name: nalunos; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.nalunos (nome, rg, orgaoexp) FROM stdin;
Lilith Old Eva	66666666	SHELL
Gabriel Arcanjo	66666667	SHEAV
Mortal Burro	66666668	STERR
\.


--
-- Data for Name: no_inscreve; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.no_inscreve (rg, orgaoexp, titulo) FROM stdin;
66666666	SHELL	Como Dominar o Mundo
66666667	SHEAV	Como Dominar o Mundo
66666668	STERR	Paz
66666668	STERR	Algum Titulo Ruim
\.


--
-- Data for Name: palestra; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.palestra (dadospalestrante, titulo, resumo, nome, tempoduracao) FROM stdin;
nada a declarar	Como Dominar o Mundo	Começo meio e Fim	Palestrante02	01:30:00
nada a declarar	Algum Titulo Legal	Começo meio e Fim	Palestrante03	02:30:00
nada a declarar	Algum Titulo Ruim	Começo meio e Fim	Palestrante01	03:30:00
nada a declarar	Paz	Começo meio e Fim	Palestrante02	01:30:00
\.


--
-- Data for Name: palestrante; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.palestrante (nome, dados) FROM stdin;
Palestrante01	nada a declarar
Palestrante02	nada a declarar
Palestrante03	nada a declarar
\.


--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.pedido (num_pedido, num_cliente) FROM stdin;
2098	1602098
\.


--
-- Data for Name: pedidos_tem_produtos; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.pedidos_tem_produtos (num_pedido, num_cliente, num_fornecedor, id_produto, data_pedido, quantidade, preco) FROM stdin;
2098	1602098	7777	77	10-04-2019	7	2
2098	1602098	6666	66	10-04-2019	6	2
\.


--
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: renan
--

COPY public.produto (id_produto, marca, tamanho) FROM stdin;
77	Pão Centeio	7
66	Cachaça	6
\.


--
-- Name: alunos alunos_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.alunos
    ADD CONSTRAINT alunos_pkey PRIMARY KEY (ra);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (num_cliente);


--
-- Name: fornecedor fornecedor_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (num_fornecedor);


--
-- Name: fornecedor_produto fornecedor_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.fornecedor_produto
    ADD CONSTRAINT fornecedor_produto_pkey PRIMARY KEY (num_fornecedor, id_produto);


--
-- Name: inscreve inscreve_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.inscreve
    ADD CONSTRAINT inscreve_pkey PRIMARY KEY (ra, titulo);


--
-- Name: nalunos nalunos_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.nalunos
    ADD CONSTRAINT nalunos_pkey PRIMARY KEY (rg, orgaoexp);


--
-- Name: no_inscreve no_inscreve_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.no_inscreve
    ADD CONSTRAINT no_inscreve_pkey PRIMARY KEY (rg, orgaoexp, titulo);


--
-- Name: palestra palestra_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.palestra
    ADD CONSTRAINT palestra_pkey PRIMARY KEY (titulo);


--
-- Name: palestrante palestrante_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.palestrante
    ADD CONSTRAINT palestrante_pkey PRIMARY KEY (nome);


--
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (num_pedido, num_cliente);


--
-- Name: pedidos_tem_produtos pedidos_tem_produtos_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.pedidos_tem_produtos
    ADD CONSTRAINT pedidos_tem_produtos_pkey PRIMARY KEY (num_pedido, num_fornecedor, id_produto, num_cliente);


--
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id_produto);


--
-- Name: fornecedor_produto fornecedor_produto_id_produto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.fornecedor_produto
    ADD CONSTRAINT fornecedor_produto_id_produto_fkey FOREIGN KEY (id_produto) REFERENCES public.produto(id_produto) ON DELETE CASCADE;


--
-- Name: fornecedor_produto fornecedor_produto_num_fornecedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.fornecedor_produto
    ADD CONSTRAINT fornecedor_produto_num_fornecedor_fkey FOREIGN KEY (num_fornecedor) REFERENCES public.fornecedor(num_fornecedor) ON DELETE CASCADE;


--
-- Name: inscreve inscreve_ra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.inscreve
    ADD CONSTRAINT inscreve_ra_fkey FOREIGN KEY (ra) REFERENCES public.alunos(ra) ON DELETE CASCADE;


--
-- Name: inscreve inscreve_titulo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.inscreve
    ADD CONSTRAINT inscreve_titulo_fkey FOREIGN KEY (titulo) REFERENCES public.palestra(titulo) ON DELETE CASCADE;


--
-- Name: no_inscreve no_inscreve_rg_fkey; Type: FK CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.no_inscreve
    ADD CONSTRAINT no_inscreve_rg_fkey FOREIGN KEY (rg, orgaoexp) REFERENCES public.nalunos(rg, orgaoexp) ON DELETE CASCADE;


--
-- Name: no_inscreve no_inscreve_titulo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.no_inscreve
    ADD CONSTRAINT no_inscreve_titulo_fkey FOREIGN KEY (titulo) REFERENCES public.palestra(titulo) ON DELETE CASCADE;


--
-- Name: palestra palestra_nome_fkey; Type: FK CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.palestra
    ADD CONSTRAINT palestra_nome_fkey FOREIGN KEY (nome) REFERENCES public.palestrante(nome);


--
-- Name: pedido pedido_num_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_num_cliente_fkey FOREIGN KEY (num_cliente) REFERENCES public.cliente(num_cliente) ON DELETE CASCADE;


--
-- Name: pedidos_tem_produtos pedidos_tem_produtos_num_fornecedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.pedidos_tem_produtos
    ADD CONSTRAINT pedidos_tem_produtos_num_fornecedor_fkey FOREIGN KEY (num_fornecedor, id_produto) REFERENCES public.fornecedor_produto(num_fornecedor, id_produto);


--
-- Name: pedidos_tem_produtos pedidos_tem_produtos_num_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: renan
--

ALTER TABLE ONLY public.pedidos_tem_produtos
    ADD CONSTRAINT pedidos_tem_produtos_num_pedido_fkey FOREIGN KEY (num_pedido, num_cliente) REFERENCES public.pedido(num_pedido, num_cliente);


--
-- PostgreSQL database dump complete
--

