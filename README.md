# Projeto Loja Virtual

INSERT INTO public.pessoa_fisica(
	id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id)
	VALUES (1, 'k.thony@gmail.com', 'kelson', '61996945878', '02304849130', '1986-06-13', 'pessoa fisica', 1);
	
INSERT INTO public.usuario(
	id, data_atual_senha, login, senha, pessoa_id, empresa_id)
	VALUES (1, '2023-11-09', 'kelson', '$2a$12$dix8BBStv5l9ewUuPRUivO9RCHgcaLnvXQGfFAFx0akcOkfsogcVm', 1, 1);