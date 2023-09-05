package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Out;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dao.MemberLoginDao;

import lombok.extern.slf4j.Slf4j;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;

@Controller
@RequestMapping("/login/*")
public class MemberLoginController
{

	@Autowired
	private MemberLoginDao memberLoginDao;

	@Autowired
	private JavaMailSender mailSender;

	// 아이디를 입력받은 회원의 정보를 map으로 반환하는 메소드
	public Map<String, Object> member(String member_id)
	{
		Map<String, Object> member = memberLoginDao.member(member_id);
		return member;
	}


	// 로그인
	@GetMapping("login")
	public String login(@RequestParam Map<String, Object> pMap, HttpSession session)
	{
		// 1을 반환하면 로그인 성공 0을 반환하면 로그인 실패
		int result = memberLoginDao.login(pMap);

		// 로그인한 아이디의 해당하는 칼럼값들을 가져옴
		Map<String, Object> member = member(pMap.get("member_id").toString());

		// 1을 반환하고 admin 계정일시 관리자페이지로 리다이렉트
		if (result == 1 && pMap.get("member_id").equals("admin"))
		{
			return "redirect:/adminPage.jsp";

		}

		// 아이디가 admin이 아니면 일반회원으로 간주
		else if (result == 1)
		{
			session.setAttribute("member", member);
			return "redirect:/board/boardList";
		}

		// 로그인실패시 틀렸다고 alert을 주고 로그인창으로 다시 리다이렉트
		else if (result == 0)
		{
			return "redirect:/memberSignin/loginError.jsp";
		}
		return null;

	}


	// 로그아웃
	@GetMapping("logout")
	public String logout(HttpSession session)
	{
		session.invalidate();
		return "redirect:/board/boardList";
	}


	// id찾기
	@GetMapping("findMyid")
	public String findMyid(@RequestParam Map<String, Object> pMap, Model model)
	{
		Map<String, Object> idMap = memberLoginDao.findMyid(pMap);
		model.addAttribute("idMap", idMap);
		return "forward:/memberSignin/checkfindMyid.jsp";

	}


	// 비밀번호찾기
	@GetMapping("findMypw")
	public String findMypw(String member_id)
	{
		// 해당 아이디의 회원정보를 통째로 가져옴
		Map<String, Object> pwMap = member(member_id);

		// 잘못된 아이디를 칠 경우
		if (pwMap == null)
		{
			return "redirect:/memberSignin/checkfindMypwError.jsp";
		}

		// 통째로 가져온거에서 이메일만 빼옴
		String email = pwMap.get("MEMBER_EMAIL").toString();

		// 임시 비밀번호
		String TempPassword = getTempPassword();

		// 이메일 전송 메소드
		sendTemporaryPasswordEmail(email, TempPassword);

		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("member_id", member_id);
		pMap.put("TempPassword", TempPassword);

		// 임시 비밀번호로 비밀번호 변경
		int result = memberLoginDao.memberpwUpdate(pMap);

		return "redirect:/memberSignin/checkfindMypw.jsp";
	}


	// 이메일을 보내는 메소드
	private void sendTemporaryPasswordEmail(String email, String temporaryPassword)
	{

		SimpleMailMessage message = new SimpleMailMessage();
		// 수신자의 이메일 주소 설정
		message.setTo(email);

		// 이메일 제목
		message.setSubject("임시 비밀번호 안내");
		
		// 이메일 내용
		message.setText("안녕하세요,\n임시 비밀번호는 " + temporaryPassword + "입니다.\n로그인 후 비밀번호를 변경해주세요.");
		try
		{
			// 생성한 메세지를 전송
			mailSender.send(message);
		}

		catch (MailException e)
		{
			e.printStackTrace();
		}
	}


	// 임시 비밀번호 생성
	public String getTempPassword()
	{
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

		String str = "";

		int idx = 0;
		for (int i = 0; i < 6; i++)
		{
			idx = (int) (charSet.length * Math.random());
			str += charSet[idx];
		}
		return str;
	}

}
