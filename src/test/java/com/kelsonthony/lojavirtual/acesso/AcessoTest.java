package com.kelsonthony.lojavirtual.acesso;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kelsonthony.lojavirtual.LojaVirtualApplication;
import com.kelsonthony.lojavirtual.api.controller.AcessoController;
import com.kelsonthony.lojavirtual.domain.model.Acesso;
import com.kelsonthony.lojavirtual.domain.repository.AcessoRepository;
import com.kelsonthony.lojavirtual.domain.service.AcessoService;

@SpringBootTest(classes =  LojaVirtualApplication.class)
public class AcessoTest {
	
	@Autowired
	private AcessoService acessoService;
	
	@Autowired
	private AcessoRepository acessoRepository;
	
	@Autowired
	private AcessoController acessoController;

	@Test
	public void cadastroAcessoRepositoryTest() {
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_ADMIN");
		acessoRepository.save(acesso);
		
	}
	
	@Test
	public void cadastroAcessoServiceTest() {
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_ADMIN");
		acessoService.save(acesso);
		
	}
	
	@Test
	public void cadastroAcessoControllerTest() {
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_ADMIN2");
		acessoController.salvarAcesso(acesso);
		
	}

}
