package comment.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import comment.dao.CommentDao;
import comment.model.Comment;
import jdbc.connection.ConnectionProvider;

public class ListCommentService {

	private CommentDao commentDao = new CommentDao();
	private int size = 10;
	
	public CommentPage getCommentPage(int pageNum, int article_no){
		try(Connection conn = ConnectionProvider.getConnection()){
			int total = commentDao.commentCount(conn, article_no);
			List<Comment> content = commentDao.selectByArticle(conn, article_no, (pageNum-1)*size, size);
			return new CommentPage(total, pageNum, size, content);
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}
}
