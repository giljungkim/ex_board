package org.board.service;

import java.util.List;

import org.board.domain.BoardVO;
import org.board.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper mapper;
	
	@Override
	public void registerBoard(BoardVO board) {
		
		mapper.registerBoard(board);
	}

	@Override
	public List<BoardVO> boardList() {
		
		return mapper.boardList();
	}

}
