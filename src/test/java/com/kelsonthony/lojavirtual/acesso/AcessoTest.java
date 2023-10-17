package com.kelsonthony.lojavirtual.acesso;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.DefaultMockMvcBuilder;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
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
	
	@Autowired
	private WebApplicationContext wac;
	
	@Test
	void testRestApiCadastroAcesso() throws JsonProcessingException, Exception {
		DefaultMockMvcBuilder builder = MockMvcBuilders.webAppContextSetup(this.wac);
		MockMvc mockMvc = builder.build();
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_COMPRADOR");
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		ResultActions retornoApi = mockMvc
									.perform(MockMvcRequestBuilders.post("/salvarAcesso")
									.content(objectMapper.writeValueAsString(acesso))
									.accept(MediaType.APPLICATION_JSON)
									.contentType(MediaType.APPLICATION_JSON));
		/**
		 * Converter o retorn da API para um objeto de acesso
		 * 
		 */
		System.out.println("Retorno da API de Acesso"
		 +retornoApi.andReturn().getResponse().getContentAsString());
		
		Acesso objetoRetorno = objectMapper.readValue(
				retornoApi.andReturn().getResponse().getContentAsString(), 
				Acesso.class);
		
		assertEquals(acesso.getDescricao(), objetoRetorno.getDescricao());
	}
	
	@Test
	void testRestApiDeleteAcesso() throws JsonProcessingException, Exception {
		DefaultMockMvcBuilder builder = MockMvcBuilders.webAppContextSetup(this.wac);
		MockMvc mockMvc = builder.build();
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_TEST_DELETE");
		
		acesso = acessoRepository.save(acesso);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		ResultActions retornoApi = mockMvc
									.perform(MockMvcRequestBuilders.post("/deleteAcesso")
									.content(objectMapper.writeValueAsString(acesso))
									.accept(MediaType.APPLICATION_JSON)
									.contentType(MediaType.APPLICATION_JSON));
		/**
		 * Converter o retorn da API para um objeto de acesso
		 * 
		 */
		System.out.println("Retorno da API de Acesso: "
		 + retornoApi.andReturn().getResponse().getContentAsString());
		
		System.out.println("Status de retorno: "
				+ retornoApi.andReturn().getResponse().getStatus());
		

		assertEquals("Acesso Removido com sucesso", retornoApi.andReturn().getResponse().getContentAsString());
		assertEquals(200, retornoApi.andReturn().getResponse().getStatus());
	}
	
	@Test
	void testRestApiDeletePorIdAcesso() throws JsonProcessingException, Exception {
		DefaultMockMvcBuilder builder = MockMvcBuilders.webAppContextSetup(this.wac);
		MockMvc mockMvc = builder.build();
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_TEST_DELETE");
		
		acesso = acessoRepository.save(acesso);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		ResultActions retornoApi = mockMvc
									.perform(MockMvcRequestBuilders.delete("/deleteAcessoPorId/"
											+ acesso.getId())
									.content(objectMapper.writeValueAsString(acesso))
									.accept(MediaType.APPLICATION_JSON)
									.contentType(MediaType.APPLICATION_JSON));
		/**
		 * Converter o retorn da API para um objeto de acesso
		 * 
		 */
		System.out.println("Retorno da API de Acesso: "
		 + retornoApi.andReturn().getResponse().getContentAsString());
		
		System.out.println("Status de retorno: "
				+ retornoApi.andReturn().getResponse().getStatus());
		

		assertEquals("Acesso Removido com sucesso", retornoApi.andReturn().getResponse().getContentAsString());
		assertEquals(200, retornoApi.andReturn().getResponse().getStatus());
	}
	
	@Test
	void testRestApiObterAcessoId() throws JsonProcessingException, Exception {
		DefaultMockMvcBuilder builder = MockMvcBuilders.webAppContextSetup(this.wac);
		MockMvc mockMvc = builder.build();
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_TEST_OBTER_ID");
		
		acesso = acessoRepository.save(acesso);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		ResultActions retornoApi = mockMvc
									.perform(MockMvcRequestBuilders.get("/obterAcesso/"
											+ acesso.getId())
									.content(objectMapper.writeValueAsString(acesso))
									.accept(MediaType.APPLICATION_JSON)
									.contentType(MediaType.APPLICATION_JSON));
		/**
		 * Converter o retorn da API para um objeto de acesso
		 * 
		 */
		
		assertEquals(200, retornoApi.andReturn().getResponse().getStatus());
		
		Acesso acessoRetorno = 
				objectMapper.readValue(retornoApi.andReturn().getResponse().getContentAsString(), 
						Acesso.class);
		assertEquals(acesso.getDescricao(), acessoRetorno.getDescricao());
		assertEquals(acesso.getId(), acessoRetorno.getId());
	}
	
	@Test
	void testRestApiObterAcessoDesc() throws JsonProcessingException, Exception {
		DefaultMockMvcBuilder builder = MockMvcBuilders.webAppContextSetup(this.wac);
		MockMvc mockMvc = builder.build();
		
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_TEST_OBTER_LIST_ONE");
		
		acesso = acessoRepository.save(acesso);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		ResultActions retornoApi = mockMvc
									.perform(MockMvcRequestBuilders.get("/buscarPorDesc/OBTER_LIST_ONE")
									.content(objectMapper.writeValueAsString(acesso))
									.accept(MediaType.APPLICATION_JSON)
									.contentType(MediaType.APPLICATION_JSON));
		
		assertEquals(200, retornoApi.andReturn().getResponse().getStatus());
		
		List<Acesso> retornoApiList = objectMapper.readValue(
				retornoApi.andReturn().getResponse().getContentAsString(), 
				new TypeReference<List<Acesso>> () {});
		
		assertEquals(1, retornoApiList.size());
		assertEquals(acesso.getDescricao(), retornoApiList.get(0).getDescricao());
		
		acessoRepository.deleteById(acesso.getId());
	}

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
