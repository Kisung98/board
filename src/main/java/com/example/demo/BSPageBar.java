package com.example.demo;

//import org.apache.log4j.Logger;

public class BSPageBar
{
	// Logger logger = Logger.getLogger(BSPageBar.class);
	// 전체레코드 갯수
	private int totalRecord;// list.size():47row
	// 페이지당 레코드 수
	private int numPerPage;// 10개씩이다
	// 블럭당 디폴트 페이지 수 - 여기서는 일단 2개로 정함.
	private int pagePerBlock = 2;
	// 총페이지 수
	private int totalPage;
	// 총블럭 수
	private int totalBlock;
	// 현재 내가 바라보는 페이지 수
	private int nowPage;
	// 현재 내가 바라보는 블럭 수
	private int nowBlock;
	// 적용할 페이지 이름
	private String pagePath;
	// 페이지 번호를 출력하는 태그들을 문자열로 담아주는 변수임
	private String pagination;

	// 디폴트 생성자 선언해보기 - 생략 가능함
	public BSPageBar()
	{
	}


	public BSPageBar(int numPerPage, int totalRecord, int nowPage, String pagePath)
	{
		this.numPerPage = numPerPage;// 한 페이지에 몇 개를 뿌릴거야?
		this.totalRecord = totalRecord;// 조회된 전체 레코드 수
		this.nowPage = nowPage;
		this.pagePath = pagePath;
		this.totalPage = (int) Math.ceil((double) this.totalRecord / this.numPerPage);// 47.0/10=> 4.7 4.1->5page 4.2->5page
		this.totalBlock = (int) Math.ceil((double) this.totalPage / this.pagePerBlock);// 5.0/2=> 2.5-> 3장
		this.nowBlock = (int) ((double) this.nowPage / this.pagePerBlock);
	}


	public void setPageBar()
	{
		StringBuilder pageLink = new StringBuilder();// 싱글스레드 여도 괜찮아
		if (totalRecord > 0)
		{
			if (nowBlock > 0)
			{ // (1-1)*2+(2-1)=1
				pageLink.append("<li class='page-item'>");
				pageLink.append("<a class='page-link' href='" + pagePath + "?nowPage="
						+ ((nowBlock - 1) * pagePerBlock + (pagePerBlock - 1)) + "'>");
				pageLink.append("<span aria-hidden='true'>&laquo;</span>");// >>
				pageLink.append("</a>");
				pageLink.append("</li>");
			}
			// 전체 레코드 수가 65개이고 그중에서 내가 45번 글을 보고 있을 때 라고 가정한다
			for (int i = 0; i < pagePerBlock; i++)
			{// 전체 페이지 블록 수는 3개이다 1 2 3 >> << 4 5 6 >> << 7
				if (nowBlock * pagePerBlock + i == nowPage)
				{
					// 현재 내가보고있는 2번째 페이지블록에서 5번 페이지를 보고 있다면 5번 숫자에 대해서는 링크가 필요없다
					pageLink.append("<a class='page-link'>" + (nowBlock * pagePerBlock + i + 1) + "</a>");// 5번숫자에 대한 코드이다
				} else
				{
					pageLink.append("<a class='page-link' href='" + pagePath + "?nowPage="
							+ ((nowBlock * pagePerBlock) + i) + "'>" + ((nowBlock * pagePerBlock) + i + 1) + "</a>");

				}
				if ((nowBlock * pagePerBlock) + i + 1 == totalPage)
					break;// 더 갈데가 없어요 2*3+0+1=7, 2*3+1+1=8, 2*3+2+1=9
			} // end of for문 - 3바퀴를 반복해서 돈다
			if (totalBlock > nowBlock + 1)
			{
				pageLink.append("<li class='page-item'>");
				pageLink.append("<a class='page-link' aria-label='Next' href='" + pagePath + "?nowPage="
						+ ((nowBlock + 1) * pagePerBlock) + "'>");
				pageLink.append("<span aria-hidden=\"true\">&raquo;</span>");// <<
				pageLink.append("</a>");
				pageLink.append("</li>");
			}
		}
		pagination = pageLink.toString();// toString()을 붙인 이유는 pageLink가 StringBuilder타입이니까 ... 그래서
	}


	public String getPageBar()
	{// getPageBar()의 리턴타입이 String이니까 print메소드 안에서 호출이 가능하였다
		this.setPageBar();
		return pagination;// 1 2 3 >> << 4 5 6 >> << 7
	}
}