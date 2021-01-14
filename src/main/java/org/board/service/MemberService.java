package org.board.service;

import org.board.domain.MemberAuthVO;
import org.board.domain.MemberVO;

public interface MemberService {
	
	public void registerMember(MemberVO member, MemberAuthVO auth);
	
}
