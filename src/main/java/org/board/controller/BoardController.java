package org.board.controller;

import java.security.Principal;
import java.util.List;

import org.board.domain.BoardVO;
import org.board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@PostMapping("register")
	@ResponseBody
	public void register(BoardVO board, Principal principal){
		
		board.setWriter(principal.getName());
		log.info(board);
		
		service.registerBoard(board);
		
	}
	
	@GetMapping("list")
	public String list(){
		
		return "board/list";
	}
	
	@GetMapping("list.run")
	public List<BoardVO> listRun(){
		List<BoardVO> list = service.boardList();
		
		return list;
	}
	
	@GetMapping("forms")
	public String forms(){
		
		return "board/forms";
	}
	
}
