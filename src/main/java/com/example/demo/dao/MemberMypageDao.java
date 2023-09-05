package com.example.demo.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberMypageDao
{
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public void information(Map<String, Object> pMap)
	{
		sqlSessionTemplate.update("infromation", pMap);
	}

}
