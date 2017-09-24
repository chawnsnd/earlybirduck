<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>얼리버DUCK</title>
</head>
<body>
<h1>얼리버DUCK</h1>

<u:isLogin>
	${authUser.name}님, 안녕하세요.
	<a href="logout.do">[로그아웃하기]</a>
	<a href="inquiry.jsp">[개인실적조회]</a>
</u:isLogin>
<u:notLogin>
	<a href="join.do">[회원가입하기]</a>
	<a href="login.do">[로그인하기]</a>
</u:notLogin>
<br/>
<hr/>

<jsp:include page="/WEB-INF/view/mission.jsp"></jsp:include>
</body>
</html>