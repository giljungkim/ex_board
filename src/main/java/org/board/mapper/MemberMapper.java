package org.board.mapper;

import org.board.domain.MemberAuthVO;
import org.board.domain.MemberVO;

public interface MemberMapper {
	
	public void registerMember(MemberVO member);
	
	public void registerAuth(MemberAuthVO auth);
	
	public MemberVO read(String userid);
	
}
