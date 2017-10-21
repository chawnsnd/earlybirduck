package comment.service;

import comment.model.Commenter;

public class WriteCommentRequest {

	private Commenter commenter;
	private String comment;
	private int article_no;
	
	public WriteCommentRequest(Commenter commenter, String comment, int article_no){
		this.commenter = commenter;
		this.comment = comment;
		this.article_no = article_no;
	}

	public Commenter getCommenter() {
		return commenter;
	}

	public String getComment() {
		return comment;
	}
	
	public int getArticleNo(){
		return article_no;
	}
}
