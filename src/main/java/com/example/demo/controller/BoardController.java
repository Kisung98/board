package com.example.demo.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import javax.mail.Folder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.BoardDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/*")
public class BoardController
{
	@Autowired
	private BoardDao boardDao;

	@GetMapping("boardList")
	public String boardList(Model model)
	{
		List<Map<String, Object>> bList = boardDao.boardList();
		model.addAttribute("bList", bList);
		return "forward:/board/boardList.jsp";
	}


	@GetMapping("boardSearch")
	public String boardSearch(Model model, @RequestParam Map<String, Object> pMap)
	{
		List<Map<String, Object>> bList = boardDao.boardSearch(pMap);
		model.addAttribute("bList", bList);
		return "forward:/board/boardList.jsp";
	}


	@GetMapping("boardDetail")
	public String boardDetail(Model model, @RequestParam Map<String, Object> pMap)
	{
		List<Map<String, Object>> bList = boardDao.boardDetail(pMap);
		model.addAttribute("bList", bList);
		return "forward:/board/boardDetail.jsp";
	}


	@PostMapping("boardInsert")
	public String boardInsert(@RequestParam Map<String, Object> pMap,
			@RequestParam("board_content_file") MultipartFile file)
	{

		// 올린 파일 이름 파일명.jpg
		String fileName = StringUtils.cleanPath(file.getOriginalFilename());

		// 자기 컴퓨터 프로젝트 경로
		String rootPath = System.getProperty("user.dir"); // C:\\Users\\godbu\\Desktop\\workspace\\board
		
		// 프로젝트에 있는 다운로드 폴더 경로
		String projectPath = "\\src\\main\\webapp\\board_file"; // projectPath를 현재 디렉토리를 기준으로 계산한 상대 경로로 변경

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

		// db에 보낼 경로값
		String filePath = "/board_file/" + fileName;

		// db에 저장될 이미지 경로값을 map파라미터에 담겨서 쿼리문으로 넘긴다.
		pMap.put("board_content_file", filePath);

		boardDao.boardInsert(pMap);

		return "redirect:/board/boardList";

	}


	@GetMapping("boardFileDownload")
	public ResponseEntity<Resource> downloadFile(String board_content_file)
	{
		// 자기 컴퓨터 프로젝트 경로
		String rootPath = System.getProperty("user.dir"); // C:\\Users\\godbu\\Desktop\\workspace\\board
		
		// 프로젝트에 있는 다운로드 폴더 경로 이미 받아오는 board_content_file에 다붙어있음
		String projectPath = "\\src\\main\\webapp"; // projectPath를 현재 디렉토리를 기준으로 계산한 상대 경로로 변경
		
		// 두개합쳐서 완벽한 폴더경로 생성
		String folerpath = rootPath + projectPath;

		// 파일의 전체 경로 생성
		String filePath = folerpath + board_content_file; // /board_file/파일명.jpg

		// Resource 객체 생성
		Resource resource = new FileSystemResource(filePath);

		// 다운로드 받을 파일명을 정리함
		String fileName = board_content_file.substring(board_content_file.lastIndexOf("/") + 1);

		// Content-Disposition 헤더 설정
		HttpHeaders headers = new HttpHeaders();

		// 한국어가 들어간 파일명을 처리하기 위해 이렇게 한다.
		try
		{
			headers.setContentDispositionFormData("attachment",
					URLEncoder.encode(fileName, StandardCharsets.UTF_8.toString()));
		}

		catch (UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}

		return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_OCTET_STREAM).body(resource);

	}


	@GetMapping("boardDelete")
	public String boardDelete(int board_no)
	{
		boardDao.boardDelete(board_no);
		return "redirect:/board/boardList";
	}


	@GetMapping("boardUpdate")
	public String boardUpdate(@RequestParam Map<String, Object> pMap)
	{
		boardDao.boardUpdate(pMap);
		return "redirect:/board/boardList";
	}

	// 댓글기능--------------------------------------------------------------------------------------------------


	@GetMapping("boardReplyInsert")
	public String boardReplyInsert(@RequestParam Map<String, Object> pMap)
	{
		boardDao.boardReplyInsert(pMap);
		return "redirect:/board/boardDetail?board_no=" + pMap.get("board_no") + "&board_count="
				+ pMap.get("board_count");
	}


	@GetMapping("boardReplyDelete")
	public String boardReplyDelete(@RequestParam Map<String, Object> pMap)
	{
		boardDao.boardReplyDelete(pMap);
		return "redirect:/board/boardDetail?board_no=" + pMap.get("board_no") + "&board_count="
				+ pMap.get("board_count");
	}

}
