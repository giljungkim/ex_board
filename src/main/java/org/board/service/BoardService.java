package org.board.service;

import java.util.List;

import org.board.domain.BoardVO;

public interface BoardService {
	
	public void registerBoard(BoardVO board);
	
	public List<BoardVO> boardList();
	
}
