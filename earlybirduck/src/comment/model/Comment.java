package comment.model;

import java.util.Date;

public class Comment {
	private Integer number;
	private int articleNumber;
	private Commenter commenter;
	private String comment;
	private Date regDate;
	
	public Comment(Integer number, Commenter commenter, String comment, Date regDate, int articleNumber) {
		this.number = number;
		this.commenter = commenter;
		this.comment = comment;
		this.regDate = regDate;
		this.articleNumber = articleNumber;
	}

	public int getNumber() {
		return number;
	}

	public Commenter getCommenter() {
		return commenter;
	}

	public String getComment() {
		return comment;
	}

	public Date getRegDate() {
		return regDate;
	}
	
	public int getArticleNumber(){
		return articleNumber;
	}
}
