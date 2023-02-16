package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BbsDao;
import dao.MemberDao;
import dto.BbsDto;
import dto.MemberDto;
import db.DBConnection;

@WebServlet("/bbs")
public class BbsController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}

	public void doProc(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		DBConnection.initConnection();
		
		req.setCharacterEncoding("utf-8");
		
		String param = req.getParameter("param");
		
		// 목록
		if(param.equals("bbslist")) {
			String choice = req.getParameter("choice");
			String search = req.getParameter("search");

			if(choice == null){
				choice = "";
			}
			if(search == null){
				search = "";
			}
			
			// model1에서는 list 불러오는 부분을 jsp에서 처리해줬지만, model2에서는 짐을 싸서 보내준다.
			BbsDao dao = BbsDao.getInstance();
			
			// 현재 페이지 설정
			String sPageNumber = req.getParameter("pageNumber");
			int pageNumber = 0;
			if(sPageNumber != null && !sPageNumber.equals("")){ // 첫번째 페이지가 아니면
				pageNumber = Integer.parseInt(sPageNumber);
			}
			
			List<BbsDto> list = dao.getBbsPageList(choice, search, pageNumber);
			
			// 글의 총 개수
			int count = dao.getAllBbs(choice, search);

			// 페이지의 총수
			int pageBbs = count / 10;	// 10개씩 페이지를 나눠 보여줌
			if((count % 10) > 0){		// 10개로 나눴을 때 페이지가 딱 떨어지지 않으면 페이지 수 +1
				pageBbs = pageBbs + 1;
			}
			
			req.setAttribute("choice", choice);
			req.setAttribute("search", search);
			req.setAttribute("pageNumber", pageNumber);
			req.setAttribute("pageBbs", pageBbs);
			req.setAttribute("bbslist", list);
			forward("bbslist.jsp", req, resp);
		}
		// 글쓰기
		else if(param.equals("bbsWrite")) {
			resp.sendRedirect("bbsWrite.jsp");
		}
		else if(param.equals("bbsWriteAf")) {
			// 파라미터 값
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			// db 저장
			BbsDao dao = BbsDao.getInstance();
			
			BbsDto dto = new BbsDto(id, title, content);

			boolean isSuccess = dao.addBbslist(dto);
			
			// jsp로 전송
			String bbs ="";
			if(isSuccess){
				bbs = "BBS_YES";
			} else {
				bbs = "BBS_NO";
			}
			req.setAttribute("bbs", bbs);
			forward("message.jsp", req, resp);
		}
		// 글 읽기
		else if(param.equals("bbsDetail")) {
			int seq = Integer.parseInt(req.getParameter("seq"));

			BbsDao dao = BbsDao.getInstance();

			MemberDto login = (MemberDto)req.getSession().getAttribute("login");
			
			//readcount 설정
			if(!dao.getBbsRead(login.getId(), seq)){ // 현재 계정으로 조회한 적이 없으면
				dao.updateReadCount(seq);			 // readcount 증가 + 기록저장
			}

			BbsDto dto = dao.getBbs(seq);
			
			req.setAttribute("bbsDto", dto);
			forward("bbsDetail.jsp", req, resp);
		}
		// 글 수정
		else if (param.equals("updateBbs")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			
			BbsDao dao = BbsDao.getInstance();

			BbsDto dto = dao.getBbs(seq);
			
			req.setAttribute("bbsDto", dto);
			forward("updateBbs.jsp", req, resp);
		}
		else if (param.equals("updateBbsAf")) {
			int seq = Integer.parseInt(req.getParameter("seq"));

			String title = req.getParameter("title");
			String content = req.getParameter("content");

			BbsDao dao = BbsDao.getInstance();
			boolean isSuccess = dao.updateBbs(seq, title, content);
			
			// jsp로 전송
			String bbs ="";
			if(isSuccess){
				bbs = "BBS_UP_YES";
			} else {
				bbs = "BBS_UP_NO";
			}
			req.setAttribute("seq", seq);
			req.setAttribute("bbs", bbs);
			forward("message.jsp", req, resp);
		}
		// 글 삭제
		else if (param.equals("deleteBbsAf")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			
			BbsDao dao = BbsDao.getInstance();
			boolean isSuccess = dao.deleteBbs(seq);

			// jsp로 전송
			String bbs ="";
			if(isSuccess){
				bbs = "BBS_DEL_YES";
			} else {
				bbs = "BBS_DEL_NO";
			}
			req.setAttribute("bbs", bbs);
			forward("message.jsp", req, resp);
		}
		// 답글 작성
		else if (param.equals("answer")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			
			BbsDao dao = BbsDao.getInstance();

			BbsDto dto = dao.getBbs(seq);
			
			req.setAttribute("bbsDto", dto);
			forward("answer.jsp", req, resp);
		}
		else if (param.equals("answerAf")) {
			int seq = Integer.parseInt(req.getParameter("seq"));

			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");

			BbsDao dao = BbsDao.getInstance();

			boolean isSuccess = dao.answer(seq, new BbsDto(id, title, content));
			
			// jsp로 전송
			String bbs ="";
			if(isSuccess){
				bbs = "BBS_COMMENT_YES";
			} else {
				bbs = "BBS_COMMENT_NO";
			}
			req.setAttribute("seq", seq);
			req.setAttribute("bbs", bbs);
			forward("message.jsp", req, resp);
		}
	}
	
	public void forward(String linkName, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher(linkName);
		dispatcher.forward(req, resp);
	}
}
