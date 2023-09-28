CREATE OR REPLACE FUNCTION validaChavePessoa()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
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
	$$

CREATE OR REPLACE FUNCTION validaChavePessoa2()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
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
	$$

CREATE TRIGGER validaChavePessoaAvaliacaoProduto
	BEFORE UPDATE
	ON avaliacao_produto
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();

CREATE TRIGGER validaChavePessoaAvaliacaoProduto2
	BEFORE INSERT
	ON avaliacao_produto
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();

CREATE TRIGGER validaChavePessoaContarPagar
	BEFORE UPDATE
	ON conta_pagar
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();

CREATE TRIGGER validaChavePessoaContarPagar2
	BEFORE INSERT
	ON conta_pagar
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();

CREATE TRIGGER validaChavePessoaContarPagar3
	BEFORE UPDATE
	ON conta_pagar
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa2();

CREATE TRIGGER validaChavePessoaContarPagar4
	BEFORE INSERT
	ON conta_pagar
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa2();
	
CREATE TRIGGER validaChavePessoa
	BEFORE UPDATE
	ON conta_receber
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();

CREATE TRIGGER validaChavePessoa
	BEFORE INSERT
	ON conta_receber
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();
	
CREATE TRIGGER validaChavePessoa
	BEFORE UPDATE
	ON endereco
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();

CREATE TRIGGER validaChavePessoa2
	BEFORE INSERT
	ON endereco
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();
	
CREATE TRIGGER validaChavePessoa
	BEFORE UPDATE
	ON nota_fiscal_compra
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();

CREATE TRIGGER validaChavePessoa2
	BEFORE INSERT
	ON nota_fiscal_compra
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();
	
CREATE TRIGGER validaChavePessoa
	BEFORE UPDATE
	ON usuario
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();

CREATE TRIGGER validaChavePessoa2
	BEFORE INSERT
	ON usuario
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();
	
	
CREATE TRIGGER validaChavePessoa
	BEFORE UPDATE
	ON vd_cp_loja_virt
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();

CREATE TRIGGER validaChavePessoa2
	BEFORE INSERT
	ON vd_cp_loja_virt
	FOR EACH ROW
	EXECUTE PROCEDURE validaChavePessoa();
