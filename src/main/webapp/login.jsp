<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
<link rel="stylesheet" href="style.css" type="text/css">

<title>Login Page</title>

</head>

<body>


<div class="center">

	<div class="left">
		<div class="content">
			<!-- <form action="member?param=loginAf" method="post"> 아래처럼 input hidden 값으로 보내기도 가능 -->
			<form action="member" method="post">
			<input type="hidden" name="param" value="loginAf">
				<table class="tb">
				<tr>
					<td height="150px">
						<h1>Login Page</h1>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" id="id" name="id" class="input" value="ID" size="20">
					</td>
				</tr>
				<tr>
					<td>
						<input type="password" id="pwd" name="pwd" class="input" value="PASSWORD" size="20">
					</td>
				</tr>
				<tr>
					<td align="right" height="30px">
						<input type="checkbox" id="chk_save_id"><span class="input_id"></span>
						<label for="chk_save_id">Save ID</label>
					</td>
				</tr>
				<tr>
					<td height="80px">
						<input type="submit" value="log-in" class="btn">
						<a href="member?param=account" class="btn">account</a>
					</td>
				</tr>
				</table>
			</form>
		</div>
	</div>
	
	<div class="right">
	
	</div>

</div>

<script type="text/javascript">
/*cookie*/

let user_id = $.cookie("user_id");

if(user_id != null){	// 저장한 id가 있으면
	$("#id").val(user_id);
	$("#chk_save_id").prop("checked", true);
}

$("#chk_save_id").click(function() {
	if($("#chk_save_id").is(":checked") == true){

		if($("#id").val().trim() == ""){	// id가 비어있으면
			alert("id를 입력해 주십시오.");
			$("#chk_save_id").prop("checked", false);
		} else {
			// cookie를 저장								// expires, path 없이도 가능
			$.cookie("user_id", $("#id").val().trim(), { expires:7, path:'./' });
		}
		
	} else {	// check를 풀면 cookie 삭제
		$.removeCookie("user_id", { path:'./' });
	}
});

</script>


</body>

</html>