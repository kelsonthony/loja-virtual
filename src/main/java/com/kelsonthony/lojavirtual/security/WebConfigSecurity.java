package com.kelsonthony.lojavirtual.security;

import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.kelsonthony.lojavirtual.domain.service.ImplementacaoUserDetailService;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class WebConfigSecurity extends WebSecurityConfigurerAdapter implements HttpSessionListener {

	@Autowired
	private ImplementacaoUserDetailService implementacaoUserDetailService;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
		.disable().authorizeRequests().antMatchers("/").permitAll()
		.antMatchers("/index").permitAll()
		.antMatchers(HttpMethod.OPTIONS, "/**").permitAll()
		/*
		 * redireciona ou da um retorno para index quando desloga
		 */
		.anyRequest().authenticated().and().logout().logoutSuccessUrl("/index")
		/*
		 * Mapeia o logout do sistema
		 */
		.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
		/*
		 * Filtra as requisições para loing de JWT
		 */
		.and().addFilterAfter(new JWTLoginFilter("/login", authenticationManager()), 
				UsernamePasswordAuthenticationFilter.class)
		.addFilterBefore(new JWTApiAutenticacaoFilter(), UsernamePasswordAuthenticationFilter.class);
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(implementacaoUserDetailService)
			.passwordEncoder(new BCryptPasswordEncoder());
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		//web.ignoring().antMatchers(HttpMethod.GET, "/salvarAcesso")
			//.antMatchers(HttpMethod.POST, "/salvarAcesso", "/deleteAcesso");
	}
}
