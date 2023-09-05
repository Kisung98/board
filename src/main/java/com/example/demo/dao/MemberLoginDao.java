package com.example.demo.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberLoginDao
{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public Map<String, Object> member(String member_id)
	{
		Map<String, Object> member = sqlSessionTemplate.selectOne("member", member_id);
		return member;
	}


	public int login(Map<String, Object> pMap)
	{
		int result = sqlSessionTemplate.selectOne("login", pMap);
		return result;
	}


	public Map<String, Object> findMyid(Map<String, Object> pMap)
	{
		Map<String, Object> idMap = sqlSessionTemplate.selectOne("findMyid", pMap);
		return idMap;
	}


	public Map<String, Object> findMypw(String member_id)
	{
		Map<String, Object> pwMap = sqlSessionTemplate.selectOne("findMypw_email", member_id);
		return pwMap;
	}


	public int memberpwUpdate(Map<String, Object> pMap)
	{
		int result = sqlSessionTemplate.update("memberpwUpdate", pMap);
		return result;
	}

}
