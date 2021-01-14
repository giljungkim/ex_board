package org.board.controller;

import java.security.Principal;

import org.board.domain.MemberAuthVO;
import org.board.domain.MemberVO;
import org.board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private PasswordEncoder pwencoder;
	
	@GetMapping("login")
	public void login(){
		
	}
	
	@RequestMapping("logout")
	public String logout(){
		log.info("logout!!!!!!!!!");
		
		return "member/login";
	}
	
	@GetMapping("registerMemberForm")
	public String registerMemberForm(){
		
		return "member/registerMemberForm";
	}
	
	@PostMapping("registerMember")
	public String registerMember(@ModelAttribute MemberVO member){
		
		log.info(member);
		
		MemberAuthVO auth = new MemberAuthVO();
		auth.setId(member.getId());
		
		member.setPassword(pwencoder.encode(member.getPassword()));
		
		service.registerMember(member, auth);
		
		return "redirect:/member/login";
		
	}
	
	
	
}
