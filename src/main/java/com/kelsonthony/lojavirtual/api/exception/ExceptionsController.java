package com.kelsonthony.lojavirtual.api.exception;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.exception.ConstraintViolationException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import com.kelsonthony.lojavirtual.api.dto.ObjetoErroDTO;

@RestControllerAdvice
@ControllerAdvice
public class ExceptionsController extends ResponseEntityExceptionHandler {

	@ExceptionHandler(LojaVirtualException.class)
	public ResponseEntity<Object> handleCustomException(LojaVirtualException ex) {
		ObjetoErroDTO objetoErroDTO = new ObjetoErroDTO();
		
		objetoErroDTO.setError(ex.getMessage());
		objetoErroDTO.setCode(HttpStatus.OK.toString());
		
		return new ResponseEntity<Object>(objetoErroDTO, HttpStatus.OK);
	}
	/**
	 * Captura exceções do projeto
	 */
	@ExceptionHandler({Exception.class, RuntimeException.class, Throwable.class})
	@Override
	protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body, HttpHeaders headers,
			HttpStatus status, WebRequest request) {
		
		ObjetoErroDTO objetoErroDTO = new ObjetoErroDTO();
		
		String msg = "";
		
		if (ex instanceof MethodArgumentNotValidException) {
			List<ObjectError> list = ((MethodArgumentNotValidException) ex).getBindingResult().getAllErrors();
			
			for(ObjectError objectError : list) {
				msg += objectError.getDefaultMessage() + "\n";
			}
		} else {
			msg = ex.getMessage();
		}
		
		objetoErroDTO.setError(msg);
		objetoErroDTO.setCode(status.value() + " ===> " + status.getReasonPhrase());
		
		return new ResponseEntity<>(objetoErroDTO, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	/**
	 * Capitura erro do banco de dados
	 * @return
	 */
	@ExceptionHandler({DataIntegrityViolationException.class, ConstraintViolationException.class,
		SQLException.class})
	protected ResponseEntity<Object> handleExceptionIntegrityDatabase(Exception ex) {
		
		ObjetoErroDTO objetoErroDTO = new ObjetoErroDTO();
		
		String msg = "";
		
		if(ex instanceof DataIntegrityViolationException) {
			msg = "Erro de Integridade do banco" + ((DataIntegrityViolationException) ex).getCause().getCause().getMessage();
		}
		if(ex instanceof ConstraintViolationException) {
			msg = "Erro de Chave estrangeira: " + ((ConstraintViolationException) ex).getCause().getCause().getMessage();
		}
		if(ex instanceof SQLException) {
			msg = "Erro de SQL do Banco: " + ((SQLException) ex).getCause().getCause().getMessage();
		} else {
			msg = ex.getMessage();
		}
		
		objetoErroDTO.setError(msg);
		objetoErroDTO.setCode(HttpStatus.INTERNAL_SERVER_ERROR.toString());
		
		ex.printStackTrace();
		
		return new ResponseEntity<>(objetoErroDTO, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
