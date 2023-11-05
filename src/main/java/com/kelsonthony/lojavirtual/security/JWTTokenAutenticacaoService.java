package com.kelsonthony.lojavirtual.security;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.kelsonthony.lojavirtual.config.context.ApplicationContextLoad;
import com.kelsonthony.lojavirtual.domain.model.Usuario;
import com.kelsonthony.lojavirtual.domain.repository.UsuarioRepository;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;

@Service
@Component
public class JWTTokenAutenticacaoService {
	
	
	private static final long EXPIRATION_TIME = 259990000; // valor para 11 dias em miliseconds
	
	private static final String SECRET = "ss/-*-*sdfsdfsdfsd-s/d-s*dadsdf";
	
	private static final String TOKEN_PREFIX = "Bearer";
	
	private static final String HEADER_STRING = "Authorization";
	
	/*
	 * Gera o token e da a reposta para o lciente com o JWT
	 */
	public void addAuthentication(HttpServletResponse response, String username) throws Exception {
		/*
		 * Montagem do Token
		 */
		String JWT = Jwts.builder()
				.setSubject(username)
				.setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
				.signWith(SignatureAlgorithm.HS512, SECRET)
				.compact();
		
		String token = TOKEN_PREFIX + " " + JWT;
		
		/*
		 * Para clientes javascript
		 */
		response.addHeader(HEADER_STRING, token);
		
		liberacaoCors(response);
		
		/*
		 * Para o postman
		 */
		response.getWriter().write("{\"Authorization\": \"" + token + "\"}");
	}
	
	/*
	 * Retorna o usuário validado com token ou caso não seja valido, retorna null
	 */
	public Authentication getAuthentication(HttpServletRequest request, HttpServletResponse response) throws IOException  {
		
		String token = request.getHeader(HEADER_STRING);
		
		try {
		
		if (token != null) {
			
			String tokenLimpo = token.replace(TOKEN_PREFIX, "").trim();
			
			/*
			 * Faz a validacao do token do usuário na requisicao e obter o USER
			 */
			String user = Jwts.parser()
					.setSigningKey(SECRET)
					.parseClaimsJws(tokenLimpo)
					.getBody().getSubject();
			
			if (user != null) {
				Usuario usuario = ApplicationContextLoad
						.getApplicationContext()
						.getBean(UsuarioRepository.class)
						.findUserByLogin(user);
				
				if (usuario != null) {
					return new UsernamePasswordAuthenticationToken(
							usuario.getLogin(), 
							usuario.getSenha(), 
							usuario.getAuthorities());
				}
			}
		}
		
		} catch (SignatureException e) {
			response.getWriter().write("Token está inválido");
			
		} catch (ExpiredJwtException e) {
			response.getWriter().write("Token está expirado, efetuar o login novamente");
			
		}
		catch (IllegalStateException e) {
			response.getWriter().write("Token está expirado, efetuar o login novamente, illegal");
			
		}
		finally {
			liberacaoCors(response);
		}
		
		return null;
	}
	
	/**
	 * Liberação de erros de CORS no browser
	 */
	private void liberacaoCors(HttpServletResponse response) {
		if (response.getHeader("Access-Control-Allow-Origin") == null) {
			response.addHeader("Access-Control-Allow-Origin", "*");
		}
		
		if (response.getHeader("Access-Control-Allow-Headers") == null) {
			response.addHeader("Access-Control-Allow-Headers", "*");
		}
		
		if (response.getHeader("Access-Control-Request-Headers") == null) {
			response.addHeader("Access-Control-Request-Headers", "*");
		}
		
		if (response.getHeader("Access-Control-Allow-Methods") == null) {
			response.addHeader("Access-Control-Allow-Methods", "*");
		}
	}
}
