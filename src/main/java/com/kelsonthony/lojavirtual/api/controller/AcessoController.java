package com.kelsonthony.lojavirtual.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kelsonthony.lojavirtual.domain.model.Acesso;
import com.kelsonthony.lojavirtual.domain.service.AcessoService;

@RestController
public class AcessoController {

	@Autowired
	private AcessoService acessoService;
	
	@PostMapping("/salvarAcesso")
	public Acesso salvarAcesso(Acesso acesso) {
		return acessoService.save(acesso);
	}
}
