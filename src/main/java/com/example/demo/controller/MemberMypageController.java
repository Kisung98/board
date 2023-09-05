package com.example.demo.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dao.MemberMypageDao;

@Controller
@RequestMapping("/mypage/*")
public class MemberMypageController
{
	@Autowired
	private MemberMypageDao memberMypageDao;

	@GetMapping("information")
	public String infromation(@RequestParam Map<String, Object> pMap)
	{
		memberMypageDao.information(pMap);
		return null;
	}

}
