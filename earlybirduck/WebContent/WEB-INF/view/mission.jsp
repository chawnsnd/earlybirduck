<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>미션 수행하기</title>
</head>
<body>

<form action="mission.do" method="post">
<input type="hidden" name="order" value="1" />
첫번째 미션
<input type="submit" value="수행하기">
</form>

<br/>

<form action="mission.do" method="post">
<input type="hidden" name="order" value="2"/>
두번째 미션
<input type="submit" value="수행하기">
</form>

<br/>

<form action="mission.do" method="post">
<input type="hidden" name="order" value="3"/>
세번째 미션
<input type="submit" value="수행하기">
</form>

</body>
</html>