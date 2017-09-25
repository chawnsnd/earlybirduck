<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="user-scalable=no, width=device-width"/>
<title>EARLYBIRDUCK</title>
</head>
<body>
<h1>EARLYBIRDUCK</h1>

<u:isLogin>
	${authUser.name}님, 안녕하세요.
	<a href="logout.do">[로그아웃하기]</a>
	<a href="inquiry.jsp">[개인실적조회]</a>
	<br/>
	<a href="article/list.do">[게시판가기]</a>
</u:isLogin>
<u:notLogin>
	<a href="join.do">[회원가입하기]</a>
	<a href="login.do">[로그인하기]</a>
	<br/>
	<a href="article/list.do">[게시판가기]</a>
</u:notLogin>
<br/>
<hr/>

<jsp:include page="/WEB-INF/view/mission.jsp"></jsp:include>
</body>
</html>