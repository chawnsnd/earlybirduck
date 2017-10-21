package comment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import comment.model.Comment;
import comment.model.Commenter;
import jdbc.JdbcUtil;

public class CommentDao {

	//comment insert
	public Comment insert(Connection conn, Comment comment) throws SQLException{
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement("insert into comment "
					+ "(comment_no, commenter_id, commenter_name, comment, redate, article_no)"
					+ "value (?,?,?,?,?,?)");
			pstmt.setInt(1, comment.getNumber());
			pstmt.setString(2, comment.getCommenter().getId());
			pstmt.setString(3, comment.getCommenter().getName());
			pstmt.setString(4, comment.getComment());
			pstmt.setTimestamp(5, toTimestamp(comment.getRegDate()));
			pstmt.setInt(6, comment.getArticleNumber());
			int insertedCount = pstmt.executeUpdate();
			
			if (insertedCount>0){
				stmt = conn.createStatement();
				rs = stmt.executeQuery("select last_insert_id() from comment");
				if(rs.next()){
					Integer newNo = rs.getInt(1);
					return new Comment(newNo,
							comment.getCommenter(),
							comment.getComment(),
							comment.getRegDate(),
							comment.getArticleNumber());
				}
			}
			return null;
		}finally{
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
			JdbcUtil.close(pstmt);
		}
	}
	
	private Timestamp toTimestamp(Date date) {
		return new Timestamp(date.getTime());
	}
	//comment selectByArticle
	public List<Comment> selectByArticle(Connection conn, int article_no, int startRow, int size) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			pstmt=conn.prepareStatement("select * from comment "+
					"where article_no =?"+
					"order by comment_no asc limit ?, ?");
			pstmt.setInt(1, article_no);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, size);
			rs = pstmt.executeQuery();
			List<Comment> result = new ArrayList<>();
			while(rs.next()){
				result.add(convertComment(rs));
			}
			return result;
		}finally{
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	private Comment convertComment(ResultSet rs) throws SQLException{
		return new Comment(rs.getInt("comment_no"),
				new Commenter(
						rs.getString("commenter_id"),
						rs.getString("commenter_name")),
				rs.getString("comment"),
				toDate(rs.getTimestamp("regdate")),
				rs.getInt("article_no"));
	}
	
	private Date toDate(Timestamp timestamp) {
		return new Date(timestamp.getTime());
	}
	
	//commentCount
	public int commentCount(Connection conn, int article_no) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement("select count(*) as count from comment"+
					"group by article_no = ?");
			pstmt.setInt(1, article_no);
			rs = pstmt.executeQuery();
			int count = rs.getInt("count");
			return count;
		}finally{
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	//comment modify
	public int update(Connection conn, int no, String comment) throws SQLException{
		try(PreparedStatement pstmt = conn.prepareStatement("update comment set comment = ?"+
					"where comment_no=?")){
			pstmt.setString(1, comment);
			pstmt.setInt(2, no);
			return pstmt.executeUpdate();
		}
	}
	//comment delete
	
}
