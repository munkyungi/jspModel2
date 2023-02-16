package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;
import db.DBConnection;
import dto.MemberDto;
import net.sf.json.JSONObject;

@WebServlet("/member")
public class MemberController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}

	public void doProc(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// jsp에서 ajax로 param 값 넘겨줬을 때 아래와 같이 처리
		DBConnection.initConnection();
		
		req.setCharacterEncoding("utf-8");
		
		String param = req.getParameter("param");
		
		if(param.equals("login")) {
			resp.sendRedirect("login.jsp");
		}
		else if(param.equals("account")) {
			resp.sendRedirect("account.jsp");
		}
		// 아이디 체크
		else if(param.equals("idcheck")) {
			String id = req.getParameter("id");
			
			// db로 접근
			MemberDao dao = MemberDao.getInstance();
			boolean b = dao.getId(id);
			
			String str = "NO";
			if(b == false) { // id가 없으면 생성
				str = "YES";
			}
			
			JSONObject obj = new JSONObject();
			obj.put("str", str);
			
			resp.setContentType("application/x-json;charset=utf-8");
			resp.getWriter().print(obj);
		}
		// 회원가입
		else if(param.equals("accountAf")) {
			
			// 파라미터 값
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			
			// db 저장
			MemberDao dao = MemberDao.getInstance();
			
			MemberDto dto = new MemberDto(id, pwd, name, email, 0);
			boolean isSuccess = dao.addMember(dto);
			
			// jsp로 전송
			String message ="";
			if(isSuccess){
				message = "MEMBER_YES";
				//resp.sendRedirect("member?param=login");
			} else {
				message = "MEMBER_NO";
				//resp.sendRedirect("member?param=account");
			}
			req.setAttribute("message", message);
			forward("message.jsp", req, resp);
		}
		// 로그인
		else if(param.equals("loginAf")) {
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			
			MemberDao dao = MemberDao.getInstance();
			MemberDto login = dao.login(id, pwd);
			
			String message ="";
			if(login != null) {	// 회원정보가 있으면
				// session 저장
				req.getSession().setAttribute("login", login);
				message = "LOGIN_YES";
			} else {			// 회원정보가 없으면
				message = "LOGIN_NO";
			}
			req.setAttribute("message", message);
			forward("message.jsp", req, resp);
		}
		// 로그아웃
		else if(param.equals("logoutAf")) {
			// 세션 삭제
			req.getSession().invalidate();
			
			resp.sendRedirect("member?param=login");
		}
	}
	
	public void forward(String linkName, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher(linkName);
		dispatcher.forward(req, resp);
	}
}
