package com.kelsonthony.lojavirtual.api.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kelsonthony.lojavirtual.domain.model.Acesso;
import com.kelsonthony.lojavirtual.domain.repository.AcessoRepository;
import com.kelsonthony.lojavirtual.domain.service.AcessoService;

//@CrossOrigin(value = "myhost")
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
	
	//@Secured({"ROLE_GERENTE", "ROLE_ADMIN"})
	@ResponseBody
	@DeleteMapping(value = "/deleteAcessoPorId/{id}")
	public ResponseEntity<Void> deleteAcessoPorId(@PathVariable("id") Long id) {
		
		acessoRepository.deleteById(id);
				
		//return new ResponseEntity("Acesso Removido com sucesso", HttpStatus.OK);
		return new ResponseEntity("Acesso Removido com sucesso", HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = "/obterAcesso/{id}")
	public ResponseEntity<Acesso> obterAcesso(@PathVariable("id") Long id) {
		
		Acesso acesso = acessoRepository.findById(id).get();
				
		return new ResponseEntity<Acesso>(acesso, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = "/buscarPorDesc/{desc}")
	public ResponseEntity<List<Acesso>> buscarPorDesc(@PathVariable("desc") String desc) {
		
		List<Acesso> acesso = acessoRepository.buscarAcessDesc(desc);
				
		return new ResponseEntity<List<Acesso>>(acesso, HttpStatus.OK);
	}
}
