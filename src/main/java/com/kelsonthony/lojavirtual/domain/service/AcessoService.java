package com.kelsonthony.lojavirtual.domain.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kelsonthony.lojavirtual.domain.model.Acesso;
import com.kelsonthony.lojavirtual.domain.repository.AcessoRepository;

@Service
public class AcessoService {

	@Autowired
	private AcessoRepository acessoRepository;
	
	public Acesso save(Acesso acesso) {
		return acessoRepository.save(acesso);
	}
}
