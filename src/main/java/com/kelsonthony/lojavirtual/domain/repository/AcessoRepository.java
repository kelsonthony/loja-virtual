package com.kelsonthony.lojavirtual.domain.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kelsonthony.lojavirtual.domain.model.Acesso;



@Repository
@Transactional
public interface AcessoRepository extends JpaRepository<Acesso, Long> {

	@Query("select a from Acesso a where upper(trim(a.descricao)) like %?1%")
	List<Acesso> buscarAcessDesc(String desc);
}
