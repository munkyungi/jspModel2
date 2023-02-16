<%@page import="util.Utility"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=

UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberDto login = (MemberDto)session.getAttribute("login");
	if(login == null){	// 세션이 만료되거나 로그인이 안 된 상태로 접속했을 때
		%>
			<script type="text/javascript">
				alert("로그인 해주십시오.");
				location.href = "login.jsp";
			</script>
		<%
	}
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

<%

String choice = (String)request.getAttribute("choice");
String search = (String)request.getAttribute("search");
int pageBbs = (Integer)request.getAttribute("pageBbs");			// 10개씩 나눴을 때 보여줄 페이지 개수
int pageNumber = (Integer)request.getAttribute("pageNumber");	// 현재 페이지
List<BbsDto> list = (List<BbsDto>)request.getAttribute("bbslist");

%>

<h1>List</h1>

<a href="member?param=logoutAf">log-out</a>

<div align="center">
	<table>
		<colgroup>
			<col width="70">
			<col width="600">
			<col width="100">
			<col width="150">
		</colgroup>
		
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>조회수</th>
				<th>작성자</th>
			</tr>
		</thead>
		
		<tbody>
			<%
			if(list == null || list.size() == 0){
			%>
				<tr>
					<td colspan="4">작성된 글이 없습니다.</td>
				</tr>
			<%
			} else {
				for(int i=0; i<list.size(); i++)
				{
					BbsDto dto = list.get(i);
					%>
					<tr>
						<th><%=i + 1 %></th>
						<td>
							<%=Utility.arrow(dto.getDepth()) %> <%-- Utility static 함수 호출 --%>
							
							<% if(dto.getDel() == 0) { %>
								<a href="bbs?param=bbsDetail&seq=<%=dto.getSeq() %>">
								<%=dto.getTitle() %>
								</a>
							<%} else if(dto.getDel() == 1) {%>
								삭제된 게시글 입니다.
							<%} %>
						</td>
						<td><%=dto.getReadcount() %></td>
						<td><%=dto.getId() %></td>
					</tr>
					<%
				}
			}
			%>
		</tbody>
	</table>
	<br>
	
	<%
	for(int i=0; i<pageBbs; i++){
		if(pageNumber == i){	// 현재 페이지일 때
			%>
			<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
				<%=i+1 %>
			</span>
			<%
		} else {
			%>
			<a href="#none" title="<%=i+1%>페이지" onclick="goPage(<%=i %>)" style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none;">
				[<%=i+1 %>]
			</a>
			<%
		}
	}
	%>
	<br><br>
	
	<select id="choice">
		<option value="">검색</option>
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="writer">작성자</option>
	</select>
	
	<input type="text" id="search" value="<%=search %>">
	
	<button type="button" onclick="searchBtn()">검색</button>
	<br><br>
	
	<a href="bbs?param=bbsWrite">글쓰기</a>
</div>

<script type="text/javascript">

let search = "<%=search %>";

//검색어가 있을 시, 처리
if(search != ""){
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");

	// 한줄로 요약 가능
	// document.getElementById("choice").value = "<%=choice %>";
}

function searchBtn() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	/*
	if(choice == ""){
		alert("카테고리를 선택해 주십시오.");
		return;
	}
	if(search.trim() == ""){
		alert("검색어를 입력해 주십시오.");
		return;
	}
	*/
	
	location.href = "bbs?param=bbslist&choice=" + choice + "&search=" + search;
}

function goPage(pageNumber) {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;

	location.href = "bbs?param=bbslist&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNumber;
}
</script>

</body>

</html>