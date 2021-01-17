package org.board.mapper;

import java.util.List;

import org.board.domain.BoardVO;

public interface BoardMapper {
	
	public void registerBoard(BoardVO board);
	
	public List<BoardVO> boardList();
	
	public BoardVO detailBoard(int boardIdx);
	
}
