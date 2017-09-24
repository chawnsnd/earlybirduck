<!-- 귀찮아서 일단은 모델1으로 구성합니다 나중에 MVC로 바꾸겠습니다 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="auth.service.User" %>
<%@ page import="jdbc.JdbcUtil" %>
<%@ page import="jdbc.connection.ConnectionProvider" %>

<%
	User user = (User)request.getSession(false).getAttribute("authUser");
	String id = user.getId();
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String query = "select year, month, day, week, firstmission, secondmission, thirdmission from mission where memberid=?";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인실적조회</title>
</head>
<body>

<div id="record">
	<table border="1">
		<caption><%= id %>님의 개인실적입니다.</caption>
		<tr>
			<td>년</td>
			<td>월</td>
			<td>일</td>
			<td>첫번째 미션</td>
			<td>두번째 미션</td>
			<td>세번째 미션</td>
		</tr>
<%
	try{
		conn = ConnectionProvider.getConnection();
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		System.out.print(rs);
		while(rs.next()){
			String fm = "";
			String sm = "";
			String tm = "";
			if(rs.getTime("firstmission")==null){
				fm = "미션실패";
			}else{
				fm = rs.getTime("firstmission").toString();
			}
			if(rs.getTime("secondmission")==null){
				sm = "미션실패";
			}else{
				sm = rs.getTime("secondmission").toString();
			}
			if(rs.getTime("thirdmission")==null){
				tm = "미션실패";
			}else{
				tm = rs.getTime("thirdmission").toString();
			}
%>
		<tr>
			<td><%= rs.getInt("year") %></td>
			<td><%= rs.getInt("month") %></td>
			<td><%= rs.getInt("day") %></td>
			<td><%= fm %></td>
			<td><%= sm %></td>
			<td><%= tm %></td>
		</tr>
<%
		}
	} catch(Exception ex){
		ex.printStackTrace();
	} finally{
		JdbcUtil.close(rs);
		JdbcUtil.close(pstmt);
		JdbcUtil.close(conn);
	}
%>
	</table>

</div>
<br/>
<a href="index.jsp">메인화면으로</a>

</body>
</html>