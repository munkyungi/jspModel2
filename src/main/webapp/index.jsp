<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- login page로 이동 (java) --%>
<% 
response.sendRedirect("member?param=login");
%>

<%-- javascript를 이용하여 이동
<script type="text/javascript">
location.href = "member?param=login";
</script>
--%>