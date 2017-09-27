package mission.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import jdbc.JdbcUtil;
import mission.model.Mission;
import mission.service.MissionReq;

public class MissionDao {

	//아이디로 DB에서 미션객체를 받을 수 있는 메서드
	public Mission selectById(Connection conn, String id, int year, int month, int day) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement(
					"select * from mission where memberid =? and year=? and month=? and day=?");
			pstmt.setString(1, id);
			pstmt.setInt(2, year);
			pstmt.setInt(3, month);
			pstmt.setInt(4, day);
			rs = pstmt.executeQuery();
			Mission mission = null;
			if(rs.next()){
				mission = new Mission(rs.getString("memberid"),
						rs.getInt("year"),
						rs.getInt("month"),
						rs.getInt("day"),
						rs.getString("week"));
			}
			return mission;
		}finally{
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	
	//미션객체로 DB에 저장할 수 있는 메서드
	public void insert(Connection conn, Mission mission) throws SQLException{
		try(PreparedStatement pstmt =
				conn.prepareStatement("insert into mission (memberid, year, month, day, week) values(?,?,?,?,?)")){
			pstmt.setString(1, mission.getId());
			pstmt.setInt(2, mission.getYear());
			pstmt.setInt(3, mission.getMonth());
			pstmt.setInt(4, mission.getDay());
			pstmt.setString(5, mission.getWeek());
			pstmt.executeUpdate();
		}
	}
	
	//1차미션 수행 시
	public void firstUpdate(Connection conn, Mission mission) throws SQLException{
		try(PreparedStatement pstmt =
				conn.prepareStatement("update mission set firstmission = curtime() where memberid=? and year=? and month=? and day=?")){
			pstmt.setString(1, mission.getId());
			pstmt.setInt(2, mission.getYear());
			pstmt.setInt(3, mission.getMonth());
			pstmt.setInt(4, mission.getDay());
			int result = pstmt.executeUpdate();
			System.out.println(result);
		}
	}

	//2차미션 수행 시
	public void secondUpdate(Connection conn, Mission mission) throws SQLException{
		try(PreparedStatement pstmt =
				conn.prepareStatement("update mission set secondmission=curtime() where memberid=? and year=? and month=? and day=?")){
			pstmt.setString(1, mission.getId());
			pstmt.setInt(2, mission.getYear());
			pstmt.setInt(3, mission.getMonth());
			pstmt.setInt(4, mission.getDay());
			int result = pstmt.executeUpdate();
			System.out.println(result);
		}
	}
	
	//3차미션 수행 시
	public void thirdUpdate(Connection conn, Mission mission) throws SQLException{
		try(PreparedStatement pstmt =
				conn.prepareStatement("update mission set thirdmission=curtime() where memberid=? and year=? and month=? and day=?")){
			pstmt.setString(1, mission.getId());
			pstmt.setInt(2, mission.getYear());
			pstmt.setInt(3, mission.getMonth());
			pstmt.setInt(4, mission.getDay());
			int result = pstmt.executeUpdate();
			System.out.println(result);
		}
	}
}
