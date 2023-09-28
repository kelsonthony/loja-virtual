package com.kelsonthony.lojavirtual.acesso;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kelsonthony.lojavirtual.LojaVirtualApplication;
import com.kelsonthony.lojavirtual.api.controller.AcessoController;
import com.kelsonthony.lojavirtual.domain.model.Acesso;
import com.kelsonthony.lojavirtual.domain.repository.AcessoRepository;
import com.kelsonthony.lojavirtual.domain.service.AcessoService;

import junit.framework.TestCase;

@SpringBootTest(classes =  LojaVirtualApplication.class)
class AcessoTest extends TestCase {
	
	@Autowired
	private AcessoService acessoService;
	
	@Autowired
	private AcessoRepository acessoRepository;
	
	@Autowired
	private AcessoController acessoController;

	@Test
	void cadastroAcessoRepositoryTest() {
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_ADMIN");
		acessoRepository.save(acesso);
		
		/**
		 * Teste de carregamento
		 */
		Acesso acesso2 = acessoRepository.findById(acesso.getId()).get();
		
		assertEquals(acesso.getId(), acesso2.getId());
		
		/**
		 * Teste de delete
		 */
		acessoRepository.deleteById(acesso2.getId());
		acessoRepository.flush();
		
		Acesso acesso3 = acessoRepository.findById(acesso2.getId()).orElse(null);
		
		assertEquals(true, acesso3 == null);
		
		/**
		 * Teste de query
		 */
		acesso = new Acesso();
		
		acesso.setDescricao("ROLE_ALUNO");
		
		acesso = acessoController.salvarAcesso(acesso).getBody();
		
		List<Acesso> acessos = acessoRepository.buscarAcessDesc("ALUNO".trim().toUpperCase());
		
		assertEquals(1, acessos.size());
		
		acessoRepository.deleteById(acesso.getId());
		
	}
	
	@Test
	void cadastroAcessoServiceTest() {
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_ADMIN");
		acessoService.save(acesso);
		
	}
	
	@Test
	void cadastroAcessoControllerTest() {
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_ADMIN2");
		acesso = acessoController.salvarAcesso(acesso).getBody();
		
		assertEquals(true, acesso.getId() > 0);
		assertEquals("ROLE_ADMIN2", acesso.getDescricao());
		
	}

}
