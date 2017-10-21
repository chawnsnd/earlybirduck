package comment.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;

import comment.dao.CommentDao;
import comment.model.Comment;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;

public class WriteCommentService {

	private CommentDao commentDao = new CommentDao();
	
	public Integer write(WriteCommentRequest req){
		Connection conn = null;
		try{
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			Comment comment = toComment(req);
			Comment savedComment = commentDao.insert(conn, comment);
			if(savedComment == null){
				throw new RuntimeException("fail to insert comment");
			}
			
			conn.commit();
			
			return savedComment.getNumber();
		} catch(SQLException e){
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		} catch (RuntimeException e){
			JdbcUtil.rollback(conn);
			throw e;
		}finally{
			JdbcUtil.close(conn);
		}
	}
	
	private Comment toComment(WriteCommentRequest req){
		Date now = new Date();
		return new Comment(null, req.getCommenter(), req.getComment(), now, req.getArticleNo());
	}
}
