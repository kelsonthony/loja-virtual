package com.kelsonthony.lojavirtual.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kelsonthony.lojavirtual.domain.model.Acesso;
import com.kelsonthony.lojavirtual.domain.repository.AcessoRepository;
import com.kelsonthony.lojavirtual.domain.service.AcessoService;

@RestController
public class AcessoController {

	@Autowired
	private AcessoService acessoService;
	
	@Autowired
	private AcessoRepository acessoRepository;
	
	@ResponseBody
	@PostMapping(value = "/salvarAcesso")
	public ResponseEntity<Acesso> salvarAcesso(@RequestBody Acesso acesso) {
		
		Acesso acessoSalvo = acessoService.save(acesso);
				
		return new ResponseEntity<Acesso>(acessoSalvo, HttpStatus.CREATED);
	}
	
	@ResponseBody
	@PostMapping(value = "/deleteAcesso")
	public ResponseEntity<Void> deleteAcesso(@RequestBody Acesso acesso) {
		
		acessoRepository.deleteById(acesso.getId());
				
		return new ResponseEntity("Acesso Removido com sucesso", HttpStatus.OK);
	}
}
