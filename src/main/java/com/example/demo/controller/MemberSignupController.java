package com.example.demo.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.MemberSignupDao;

@Controller
@RequestMapping("/signup/*")
public class MemberSignupController
{

	@Autowired
	private MemberSignupDao memberSignupDao;

	// 회원가입정보가 db에 입력되게함
	@PostMapping("signupInsert")
	public String signupInsert(@RequestParam Map<String, Object> pMap,
			@RequestParam("member_profileimage") MultipartFile file)
	{

		// 올린 파일 이름 파일명.jpg
		String fileName = StringUtils.cleanPath(file.getOriginalFilename());

		// 자기 컴퓨터 프로젝트 경로
		String rootPath = System.getProperty("user.dir"); // C:\\Users\\godbu\\Desktop\\workspace\\board

		// 프로젝트에 있는 다운로드 폴더 경로
		String projectPath = "\\src\\main\\webapp\\profile_images"; // projectPath를 현재 디렉토리를 기준으로 계산한 상대 경로로 변경

		// 두개합쳐서 완벽한 폴더경로 생성
		String folerpath = rootPath + projectPath;

		// 저장할 파일객체의 생성자를 통해 정보를 넣어준다 (저장폴더경로, 저장할 파일이름)
		File dest = new File(folerpath, fileName);

		// 폴더에 파일을 저장하는 메소드
		try
		{
			file.transferTo(dest);
		}

		catch (IllegalStateException | IOException e)
		{
			e.printStackTrace();
		}

		String filePath;

		// db에 보낼 경로값
		if (fileName.isEmpty())
		{
			filePath = "/profile_images/basicProfile.jpg";
		}

		else
		{
			filePath = "/profile_images/" + fileName;
		}

		// db에 저장될 이미지 경로값을 map파라미터에 담겨서 쿼리문으로 넘긴다.
		pMap.put("member_profileimage", filePath);

		int result = memberSignupDao.signupInsert(pMap);

		if (result > 0)
		{
			return "redirect:/memberSignup/MemberSignUPsuccess.jsp";

		}

		else
		{
			return "redirect:/memberSignup/MemberSignUPfail.jsp";
		}

	}


	// 아이디 중복검사 컨트롤러
	@PostMapping("member_idCheck")
	@ResponseBody
	public int member_idCheck(String member_id)
	{
		int result = memberSignupDao.member_idCheck(member_id);
		return result;

	}


	// 이메일 중복검사 ajax 반환 컨트롤러
	@PostMapping("member_emailCheck")
	@ResponseBody
	public int member_emailCheck(String member_email)
	{
		int result = memberSignupDao.member_emailCheck(member_email);
		return result;
	}

}
