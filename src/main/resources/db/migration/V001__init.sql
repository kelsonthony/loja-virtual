--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.1

-- Started on 2023-09-10 17:21:01

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 255 (class 1255 OID 49509)
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: user
--

CREATE FUNCTION public.validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare existe integer;

	BEGIN 

		 existe = (SELECT count(1) from pessoa_fisica WHERE id = NEW.pessoa_id);
		if (existe <= 0) then
			existe = (SELECT count(1) from pessoa_juridica WHERE id = NEW.pessoa_id);
		if (existe <= 0) then
			RAISE EXCEPTION 'Não foi encontrado o ID e PK da pessoa para realizar a associação do cadastro';
		  end if;
		end if;
	 RETURN new;
	END;
	$$;


ALTER FUNCTION public.validachavepessoa() OWNER TO "user";

--
-- TOC entry 256 (class 1255 OID 49514)
-- Name: validachavepessoa2(); Type: FUNCTION; Schema: public; Owner: user
--

CREATE FUNCTION public.validachavepessoa2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare existe integer;

	BEGIN 

		 existe = (SELECT count(1) from pessoa_fisica WHERE id = NEW.pessoa_forn_id);
		if (existe <= 0) then
			existe = (SELECT count(1) from pessoa_juridica WHERE id = NEW.pessoa_forn_id);
		if (existe <= 0) then
			RAISE EXCEPTION 'Não foi encontrado o ID e PK da pessoa para realizar a associação do cadastro';
		  end if;
		end if;
	 RETURN new;
	END;
	$$;


ALTER FUNCTION public.validachavepessoa2() OWNER TO "user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 32801)
-- Name: acesso; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.acesso (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.acesso OWNER TO "user";

--
-- TOC entry 240 (class 1259 OID 49277)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.avaliacao_produto (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    nota integer NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.avaliacao_produto OWNER TO "user";

--
-- TOC entry 215 (class 1259 OID 24602)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.categoria_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.categoria_produto OWNER TO "user";

--
-- TOC entry 227 (class 1259 OID 41004)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.conta_pagar (
    id bigint NOT NULL,
    dt_vencimento date,
    pessoa_id bigint NOT NULL,
    pessoa_forn_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    status character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_total numeric(19,2) NOT NULL
);


ALTER TABLE public.conta_pagar OWNER TO "user";

--
-- TOC entry 224 (class 1259 OID 40990)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.conta_receber (
    id bigint NOT NULL,
    pessoa_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_total numeric(19,2) NOT NULL
);


ALTER TABLE public.conta_receber OWNER TO "user";

--
-- TOC entry 244 (class 1259 OID 49326)
-- Name: cup_desc; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.cup_desc (
    id bigint NOT NULL,
    cod_desc character varying(255) NOT NULL,
    data_validade_cupom date NOT NULL,
    valor_porcent_desc numeric(19,2),
    valor_real_desc numeric(19,2)
);


ALTER TABLE public.cup_desc OWNER TO "user";

--
-- TOC entry 241 (class 1259 OID 49287)
-- Name: endereco; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rua_logra character varying(255) NOT NULL,
    tipo_endereco character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.endereco OWNER TO "user";

--
-- TOC entry 242 (class 1259 OID 49304)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.forma_pagamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.forma_pagamento OWNER TO "user";

--
-- TOC entry 243 (class 1259 OID 49314)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.imagem_produto (
    id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.imagem_produto OWNER TO "user";

--
-- TOC entry 237 (class 1259 OID 49240)
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.item_venda_loja (
    id bigint NOT NULL,
    produto_id bigint NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL,
    quantidade double precision NOT NULL
);


ALTER TABLE public.item_venda_loja OWNER TO "user";

--
-- TOC entry 245 (class 1259 OID 49337)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.marca_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.marca_produto OWNER TO "user";

--
-- TOC entry 246 (class 1259 OID 49342)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.nota_fiscal_compra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_obs character varying(255),
    numero_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_icms numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    conta_pagar_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_compra OWNER TO "user";

--
-- TOC entry 247 (class 1259 OID 49359)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.nota_fiscal_venda (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_venda OWNER TO "user";

--
-- TOC entry 248 (class 1259 OID 49376)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.nota_item_produto (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    nota_fiscal_compra_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.nota_item_produto OWNER TO "user";

--
-- TOC entry 220 (class 1259 OID 24642)
-- Name: pessoa_enderecos; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.pessoa_enderecos (
    pessoa_id bigint NOT NULL,
    enderecos_id bigint NOT NULL
);


ALTER TABLE public.pessoa_enderecos OWNER TO "user";

--
-- TOC entry 249 (class 1259 OID 49403)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.pessoa_fisica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date
);


ALTER TABLE public.pessoa_fisica OWNER TO "user";

--
-- TOC entry 250 (class 1259 OID 49410)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.pessoa_juridica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    categoria character varying(255),
    cnpj character varying(255) NOT NULL,
    insc_estadual character varying(255) NOT NULL,
    insc_municipal character varying(255),
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_juridica OWNER TO "user";

--
-- TOC entry 251 (class 1259 OID 49417)
-- Name: produto; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.produto (
    id bigint NOT NULL,
    qtd_alerta_estoque integer,
    qtd_estoque integer NOT NULL,
    alerta_qtd_estoque boolean,
    altura double precision NOT NULL,
    ativo boolean,
    descricao text NOT NULL,
    largura double precision NOT NULL,
    link_youtube character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    qtd_clique integer,
    tipo_unidade character varying(255) NOT NULL,
    valor_venda numeric(19,2) NOT NULL
);


ALTER TABLE public.produto OWNER TO "user";

--
-- TOC entry 217 (class 1259 OID 24613)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_acesso OWNER TO "user";

--
-- TOC entry 239 (class 1259 OID 49261)
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_avaliacao_produto OWNER TO "user";

--
-- TOC entry 216 (class 1259 OID 24607)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_categoria_produto OWNER TO "user";

--
-- TOC entry 228 (class 1259 OID 41011)
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_pagar OWNER TO "user";

--
-- TOC entry 225 (class 1259 OID 40997)
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_receber OWNER TO "user";

--
-- TOC entry 229 (class 1259 OID 41017)
-- Name: seq_cup_desc; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_cup_desc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cup_desc OWNER TO "user";

--
-- TOC entry 219 (class 1259 OID 24641)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_endereco OWNER TO "user";

--
-- TOC entry 226 (class 1259 OID 41003)
-- Name: seq_forma_pagamento; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_forma_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_forma_pagamento OWNER TO "user";

--
-- TOC entry 231 (class 1259 OID 41033)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_imagem_produto OWNER TO "user";

--
-- TOC entry 238 (class 1259 OID 49245)
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_item_venda_loja OWNER TO "user";

--
-- TOC entry 214 (class 1259 OID 16416)
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_marca_produto OWNER TO "user";

--
-- TOC entry 232 (class 1259 OID 41046)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_compra OWNER TO "user";

--
-- TOC entry 235 (class 1259 OID 49193)
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_nota_fiscal_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_venda OWNER TO "user";

--
-- TOC entry 233 (class 1259 OID 41057)
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_item_produto OWNER TO "user";

--
-- TOC entry 218 (class 1259 OID 24633)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_pessoa OWNER TO "user";

--
-- TOC entry 230 (class 1259 OID 41023)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_produto OWNER TO "user";

--
-- TOC entry 234 (class 1259 OID 49185)
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_status_rastreio OWNER TO "user";

--
-- TOC entry 223 (class 1259 OID 32813)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario OWNER TO "user";

--
-- TOC entry 236 (class 1259 OID 49199)
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seq_vd_cp_loja_virt
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_vd_cp_loja_virt OWNER TO "user";

--
-- TOC entry 253 (class 1259 OID 49451)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.status_rastreio (
    id bigint NOT NULL,
    centro_distribuicao character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.status_rastreio OWNER TO "user";

--
-- TOC entry 252 (class 1259 OID 49444)
-- Name: usuario; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    data_atual_senha date NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.usuario OWNER TO "user";

--
-- TOC entry 222 (class 1259 OID 32806)
-- Name: usuario_acesso; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.usuario_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


ALTER TABLE public.usuario_acesso OWNER TO "user";

--
-- TOC entry 254 (class 1259 OID 49458)
-- Name: vd_cp_loja_virt; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.vd_cp_loja_virt (
    id bigint NOT NULL,
    data_entrega date NOT NULL,
    data_venda date NOT NULL,
    dia_entrega integer NOT NULL,
    valor_desconto numeric(19,2),
    valor_frete numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    cupom_desconto_id bigint,
    endereco_cobranca_id bigint NOT NULL,
    endereco_entrega_id bigint NOT NULL,
    forma_pagamento_id bigint NOT NULL,
    nota_fiscal_venda_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.vd_cp_loja_virt OWNER TO "user";

--
-- TOC entry 3507 (class 0 OID 32801)
-- Dependencies: 221
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3526 (class 0 OID 49277)
-- Dependencies: 240
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: user
--






--
-- TOC entry 3501 (class 0 OID 24602)
-- Dependencies: 215
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3513 (class 0 OID 41004)
-- Dependencies: 227
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3510 (class 0 OID 40990)
-- Dependencies: 224
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3530 (class 0 OID 49326)
-- Dependencies: 244
-- Data for Name: cup_desc; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3527 (class 0 OID 49287)
-- Dependencies: 241
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3528 (class 0 OID 49304)
-- Dependencies: 242
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3529 (class 0 OID 49314)
-- Dependencies: 243
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3523 (class 0 OID 49240)
-- Dependencies: 237
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3531 (class 0 OID 49337)
-- Dependencies: 245
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3532 (class 0 OID 49342)
-- Dependencies: 246
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3533 (class 0 OID 49359)
-- Dependencies: 247
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3534 (class 0 OID 49376)
-- Dependencies: 248
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3506 (class 0 OID 24642)
-- Dependencies: 220
-- Data for Name: pessoa_enderecos; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3535 (class 0 OID 49403)
-- Dependencies: 249
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: user
--






--
-- TOC entry 3536 (class 0 OID 49410)
-- Dependencies: 250
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3537 (class 0 OID 49417)
-- Dependencies: 251
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: user
--






--
-- TOC entry 3539 (class 0 OID 49451)
-- Dependencies: 253
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3538 (class 0 OID 49444)
-- Dependencies: 252
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3508 (class 0 OID 32806)
-- Dependencies: 222
-- Data for Name: usuario_acesso; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3540 (class 0 OID 49458)
-- Dependencies: 254
-- Data for Name: vd_cp_loja_virt; Type: TABLE DATA; Schema: public; Owner: user
--





--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 217
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_acesso', 1, false);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 239
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_avaliacao_produto', 1, false);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 216
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_categoria_produto', 1, false);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 228
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_conta_pagar', 1, false);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 225
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_conta_receber', 1, false);


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 229
-- Name: seq_cup_desc; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_cup_desc', 1, false);


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 219
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_endereco', 1, false);


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 226
-- Name: seq_forma_pagamento; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_forma_pagamento', 1, false);


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 231
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_imagem_produto', 1, false);


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 238
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_item_venda_loja', 1, false);


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 214
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_marca_produto', 1, false);


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 232
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_compra', 1, false);


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 235
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_venda', 1, false);


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 233
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_nota_item_produto', 1, false);


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 218
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_pessoa', 1, false);


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 230
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_produto', 1, false);


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 234
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_status_rastreio', 1, false);


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 223
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_usuario', 1, false);


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 236
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seq_vd_cp_loja_virt', 1, false);


--
-- TOC entry 3285 (class 2606 OID 32805)
-- Name: acesso acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 3297 (class 2606 OID 49281)
-- Name: avaliacao_produto avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3281 (class 2606 OID 24606)
-- Name: categoria_produto categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3293 (class 2606 OID 41010)
-- Name: conta_pagar conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 3291 (class 2606 OID 40996)
-- Name: conta_receber conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 3305 (class 2606 OID 49330)
-- Name: cup_desc cup_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.cup_desc
    ADD CONSTRAINT cup_desc_pkey PRIMARY KEY (id);


--
-- TOC entry 3299 (class 2606 OID 49293)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 3301 (class 2606 OID 49308)
-- Name: forma_pagamento forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 3303 (class 2606 OID 49320)
-- Name: imagem_produto imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3295 (class 2606 OID 49244)
-- Name: item_venda_loja item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 3307 (class 2606 OID 49341)
-- Name: marca_produto marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3309 (class 2606 OID 49348)
-- Name: nota_fiscal_compra nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 3311 (class 2606 OID 49365)
-- Name: nota_fiscal_venda nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 3313 (class 2606 OID 49380)
-- Name: nota_item_produto nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3315 (class 2606 OID 49409)
-- Name: pessoa_fisica pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 3317 (class 2606 OID 49416)
-- Name: pessoa_juridica pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 3319 (class 2606 OID 49423)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 49457)
-- Name: status_rastreio status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 3283 (class 2606 OID 24646)
-- Name: pessoa_enderecos uk_dohhhen9o647b0me6tfitmxg4; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.pessoa_enderecos
    ADD CONSTRAINT uk_dohhhen9o647b0me6tfitmxg4 UNIQUE (enderecos_id);


--
-- TOC entry 3287 (class 2606 OID 40989)
-- Name: usuario_acesso uk_fhwpg5wu1u5p306q8gycxn9ky; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT uk_fhwpg5wu1u5p306q8gycxn9ky UNIQUE (acesso_id);


--
-- TOC entry 3289 (class 2606 OID 32812)
-- Name: usuario_acesso unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 3321 (class 2606 OID 49450)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 3325 (class 2606 OID 49462)
-- Name: vd_cp_loja_virt vd_cp_loja_virt_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT vd_cp_loja_virt_pkey PRIMARY KEY (id);


--
-- TOC entry 3350 (class 2620 OID 49522)
-- Name: endereco validachavepessoa; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3352 (class 2620 OID 49524)
-- Name: nota_fiscal_compra validachavepessoa; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3354 (class 2620 OID 49526)
-- Name: usuario validachavepessoa; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3356 (class 2620 OID 49528)
-- Name: vd_cp_loja_virt validachavepessoa; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.vd_cp_loja_virt FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3351 (class 2620 OID 49523)
-- Name: endereco validachavepessoa2; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3353 (class 2620 OID 49525)
-- Name: nota_fiscal_compra validachavepessoa2; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3355 (class 2620 OID 49527)
-- Name: usuario validachavepessoa2; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3357 (class 2620 OID 49529)
-- Name: vd_cp_loja_virt validachavepessoa2; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.vd_cp_loja_virt FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3348 (class 2620 OID 49510)
-- Name: avaliacao_produto validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3349 (class 2620 OID 49511)
-- Name: avaliacao_produto validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3344 (class 2620 OID 49512)
-- Name: conta_pagar validachavepessoacontarpagar; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoacontarpagar BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3342 (class 2620 OID 49517)
-- Name: conta_receber validachavepessoacontarpagar; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoacontarpagar BEFORE UPDATE ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3345 (class 2620 OID 49513)
-- Name: conta_pagar validachavepessoacontarpagar2; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoacontarpagar2 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3343 (class 2620 OID 49518)
-- Name: conta_receber validachavepessoacontarpagar2; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoacontarpagar2 BEFORE INSERT ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3346 (class 2620 OID 49515)
-- Name: conta_pagar validachavepessoacontarpagar3; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoacontarpagar3 BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa2();


--
-- TOC entry 3347 (class 2620 OID 49516)
-- Name: conta_pagar validachavepessoacontarpagar4; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER validachavepessoacontarpagar4 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa2();


--
-- TOC entry 3326 (class 2606 OID 32814)
-- Name: usuario_acesso acesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT acesso_fk FOREIGN KEY (acesso_id) REFERENCES public.acesso(id);


--
-- TOC entry 3332 (class 2606 OID 49349)
-- Name: nota_fiscal_compra conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES public.conta_pagar(id);


--
-- TOC entry 3337 (class 2606 OID 49483)
-- Name: vd_cp_loja_virt cupom_desconto_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT cupom_desconto_fk FOREIGN KEY (cupom_desconto_id) REFERENCES public.cup_desc(id);


--
-- TOC entry 3338 (class 2606 OID 49488)
-- Name: vd_cp_loja_virt endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES public.endereco(id);


--
-- TOC entry 3339 (class 2606 OID 49493)
-- Name: vd_cp_loja_virt endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES public.endereco(id);


--
-- TOC entry 3340 (class 2606 OID 49498)
-- Name: vd_cp_loja_virt forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES public.forma_pagamento(id);


--
-- TOC entry 3334 (class 2606 OID 49381)
-- Name: nota_item_produto nota_fiscal_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_fiscal_compra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES public.nota_fiscal_compra(id);


--
-- TOC entry 3341 (class 2606 OID 49503)
-- Name: vd_cp_loja_virt nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES public.nota_fiscal_venda(id);


--
-- TOC entry 3330 (class 2606 OID 49424)
-- Name: avaliacao_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3331 (class 2606 OID 49429)
-- Name: imagem_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3328 (class 2606 OID 49434)
-- Name: item_venda_loja produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3335 (class 2606 OID 49439)
-- Name: nota_item_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3327 (class 2606 OID 49478)
-- Name: usuario_acesso usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 3329 (class 2606 OID 49463)
-- Name: item_venda_loja venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


--
-- TOC entry 3333 (class 2606 OID 49468)
-- Name: nota_fiscal_venda venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


--
-- TOC entry 3336 (class 2606 OID 49473)
-- Name: status_rastreio venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


-- Completed on 2023-09-10 17:21:01

--
-- PostgreSQL database dump complete
--

