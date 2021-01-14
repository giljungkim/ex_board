package org.board.domain;

import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String id;
	private String password;
	private String name;
	private String phoneNo;
	private String email;
	private String sex;
	private String address;
	private String regDate;
	private String modifyDate;
	private String withdrawal;
	private boolean enabled;
	
	private List<MemberAuthVO> authList;
	
}
