<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<title>Insert title here</title>

<style type="text/css">
.center{
	margin: auto;
	width: 50%;
	border: 3px solid tomato;
	padding: 10px;
}
</style>

</head>

<body>

<h1>글쓰기 페이지</h1>

<div class="center">
	<form action="bbs?param=bbsWriteAf" id="frm" method="post">
		<table align="center">
		<tr>
			<td>ID</td>
			<td>
				<!-- <input type="text" name="id" size="28" value="<%=login.getId() %>" readonly="readonly"> -->
				<%=login.getId() %>
				<input type="hidden" name="id" value="<%=login.getId() %>">
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" id="title" name="title" size="28"><br>
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<textarea id="content" name="content" rows="10" cols="30"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<!-- <input type="submit" value="등록"> -->
				<!-- <button type="submit">등록</button> -->
				<button type="button">등록</button>
			</td>
		</tr>
		</table>
	</form>
</div>


<script type="text/javascript">
$(document).ready(function() {
	
	$("button").click(function() {
		if($("#title").val().trim() == "" ){
			alert("제목을 기입해 주십시오.");
			return;
		}else if($("#content").val().trim() == "" ){
			alert("내용을 기입해 주십시오.");
			return;
		}else{
			$("#frm").submit();
		}		
	});	
});
</script>

</body>

</html>