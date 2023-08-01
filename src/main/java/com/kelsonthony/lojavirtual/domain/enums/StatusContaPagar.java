package com.kelsonthony.lojavirtual.domain.enums;

public enum StatusContaPagar {

	COBRANCA("Pagar"),
	VENCIDA("Vencida"),
	ABERTA("Aberta"),
	QUITADA("Quitada"),
	ALUGUEL("Aluguel"),
	FUNCIONARIO("Funcionário"),
	NEGOCIADA("Renegociada");
	
	private String descricao;

	private StatusContaPagar(String descricao) {
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	
	@Override
	public String toString() {
		return this.descricao;
	}

	
	
}
