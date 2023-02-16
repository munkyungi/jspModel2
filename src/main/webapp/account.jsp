<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link rel="stylesheet" href="style.css" type="text/css">

<title>Account Page</title>

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

<h2>Account Page</h2>

<p>환영합니다!</p>

<div class="center">

<form action="member?param=accountAf" method="post">

	<table align="center">
		<tr>
			<td>ID</td>
			<td>
				<input type="text" id="id" name="id" size="20"><br>
				<p id="idcheck" style="font-size: 8px"></p>
				<input type="button" id="idChkBtn" value="id확인">
			</td>
		</tr>
		<tr>
			<td>PASSWORD</td>
			<td>
				<input type="text" id="pwd" name="pwd" size="20"><br>
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input type="text" name="name" size="20">
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<input type="email" name="email" size="20">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="회원가입">
			</td>
		</tr>
	</table>

</form>
</div>


<script type="text/javascript">
$(document).ready(function() {
	$("#idChkBtn").click(function() {
		
		// id 빈칸 조사 필요!
		
		$.ajax({
			type: "post",
			url: "member?param=idcheck",
			data: { "id": $("#id").val() },
			success:function(msg){
				//alert(JSON.stringify(msg)); // {"str":"YES"}
				
				if(msg.str.trim() == "YES"){
					$("#idcheck").css("color", "#0000ff");
					$("#idcheck").text("사용 할 수 있는 아이디입니다");
				} else {
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").text("사용 중인 아이디입니다");
					$("#id").val("");
				}
			},
			error:function(){
				alert('error');
			}
		});
	});
});
</script>


</body>

</html>