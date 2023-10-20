package com.kelsonthony.lojavirtual.security;

import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Service
public class JWTTokenAutenticacaoService {
	
	
	private static final long EXPIRATION_TIME = 259990000;
	
	private static final String SECRET = "ss/-*-*sdfsdfsdfsd-s/s-s*dadsdf";
	
	private static final String TOKEN_PREFIX = "Bearer";
	
	private static final String HEADER_STRING = "Authorization";
	
	/*
	 * GEra o token e da a reposta para o lciente com o JWT
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
		 * para clientes javascript
		 */
		response.addHeader(HEADER_STRING, token);
		
		/*
		 * para o postman
		 */
		response.getWriter().write("{\"Authorization\": \"" + token + "\"}");
	}
}
