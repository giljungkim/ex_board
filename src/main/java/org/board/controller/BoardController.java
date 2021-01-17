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
import org.springframework.web.bind.annotation.PathVariable;
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
	
	//클라이언트로 데이터 넘길때 produces 설정하여 json 객체로 넘기는거 설정해줘야함
	@GetMapping(value = "list.run", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public List<BoardVO> listRun(){
		List<BoardVO> list = service.boardList();
		
		return list;
	}
	
	@GetMapping(value = "detailBoard/{boardIdx}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public BoardVO detailBoard(@PathVariable int boardIdx){
		BoardVO board = service.detailBoard(boardIdx);
		
		return board;
	}
	
	@GetMapping("forms")
	public String forms(){
		
		return "board/forms";
	}
	
	
}
