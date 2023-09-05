package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDao
{

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<Map<String, Object>> boardList()
	{
		List<Map<String, Object>> bList = sqlSessionTemplate.selectList("boardList");
		return bList;
	}


	public List<Map<String, Object>> boardSearch(Map<String, Object> pMap)
	{
		List<Map<String, Object>> bList = sqlSessionTemplate.selectList("boardSearch", pMap);
		return bList;
	}


	public List<Map<String, Object>> boardDetail(Map<String, Object> pMap)

	{
		// 그냥 메인화면에서 자세히보기를 눌렀을때
		if (pMap.get("board_count") == null)
		{
			sqlSessionTemplate.update("boardCountUp", Integer.parseInt(pMap.get("board_no").toString()));
			List<Map<String, Object>> bList = sqlSessionTemplate.selectList("boardDetail",
					Integer.parseInt(pMap.get("board_no").toString()));
			return bList;

		}

		// 자세히보기화면에서 댓글을 삽입하고 수정하고나서 자세히보기로 돌아올때 조회수가 올라가면 안됨
		else
		{
			List<Map<String, Object>> bList = sqlSessionTemplate.selectList("boardDetail",
					Integer.parseInt(pMap.get("board_no").toString()));
			return bList;
		}

	}


	public void boardCountUp(int board_no)
	{
		sqlSessionTemplate.update("boardCountUp", board_no);

	}


	public void boardInsert(Map<String, Object> pMap)
	{
		sqlSessionTemplate.insert("boardInsert", pMap);
	}


	public void boardDelete(int board_no)
	{
		sqlSessionTemplate.delete("boardDelete", board_no);
		sqlSessionTemplate.delete("boardReplyDelete", board_no);
	}


	public void boardUpdate(Map<String, Object> pMap)
	{
		sqlSessionTemplate.update("boardUpdate", pMap);
	}

	// 댓글기능--------------------------------------------------------------------------------------------------


	public void boardReplyInsert(Map<String, Object> pMap)
	{
		sqlSessionTemplate.insert("boardReplyInsert", pMap);
	}


	public void boardReplyDelete(Map<String, Object> pMap)
	{
		sqlSessionTemplate.delete("boardReplyDelete", pMap);
	}

}
