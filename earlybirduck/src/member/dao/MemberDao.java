package member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import jdbc.JdbcUtil;
import member.model.Member;

public class MemberDao {
	
	//아이디로 DB에서 멤버객체를 받을 수 있는 메서드
	public Member selectById(Connection conn, String id) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement(
					"select * from member where memberid =?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			Member member = null;
			if(rs.next()){
				member = new Member(rs.getString("memberid"),
						rs.getString("name"),
						rs.getString("password"), 
						toDate(rs.getTimestamp("regdate")));
			}
			return member;
		}finally{
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	//Timestamp 타입을 Date 타입으로 바꿔주는 메서드
	private Date toDate(Timestamp date){
		return date == null ? null : new Date(date.getTime());
	}
	
	
	//맴버객체로 DB에 저장할 수 있는 메서드
	public void insert(Connection conn, Member mem) throws SQLException{
		try(PreparedStatement pstmt =
				conn.prepareStatement("insert into member values(?,?,?,?)")){
			pstmt.setString(1, mem.getId());
			pstmt.setString(2, mem.getName());
			pstmt.setString(3, mem.getPassword());
			pstmt.setTimestamp(4, new Timestamp(mem.getRegDate().getTime()));
			pstmt.executeUpdate();
		}
	}
}
