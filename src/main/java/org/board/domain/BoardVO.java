package org.board.domain;

import lombok.Data;

@Data
public class BoardVO {
	
	private int boardIdx;
	private String title;
	private String writer;
	private String contents;
	private String picture;
	private String regDate;
	private String modifyDate;
	private int hitCount;
	
}
