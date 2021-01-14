package org.board.service;

import org.board.domain.MemberAuthVO;
import org.board.domain.MemberVO;
import org.board.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper mapper;

	@Override
	public void registerMember(MemberVO member, MemberAuthVO auth) {
		mapper.registerMember(member);
		mapper.registerAuth(auth);
		
	}
	
	
	
}
