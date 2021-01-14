package org.board.domain;

import lombok.Data;

@Data
public class ReplyVO {
	
	private int replyIdx;
	private int boardIdx;
	private String r_writer;
	private String r_contents;
	private String regDate;
	private String modifyDate;
	
}
