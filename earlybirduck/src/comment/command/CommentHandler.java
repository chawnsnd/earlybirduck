package comment.command;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import auth.service.User;
import comment.model.Commenter;
import comment.service.CommentPage;
import comment.service.ListCommentService;
import comment.service.WriteCommentRequest;
import mvc.command.CommandHandler;

public class CommentHandler implements CommandHandler{

	private ListCommentService commentService = new ListCommentService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res)
		throws IOException{
		if(req.getMethod().equalsIgnoreCase("GET")){
			return processForm(req, res);
		}else if(req.getMethod().equalsIgnoreCase("POST")){
			String division = req.getParameter("division");
			if(division.equals("write")){
				return processWrite(req, res);
			}else if(division.equals("modify")){
				return "/WEB-INF/view/board/comment/listComment.jsp";
				//return processModify(req, res);
			}else if(division.equals("delete")){
				return "/WEB-INF/view/board/comment/listComment.jsp";
				//return processDelete(req, res);
			}else{
				return null;
			}
		}else{
			res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}
	}
	
	//리스트
	private String processForm(HttpServletRequest req, HttpServletResponse res)
		throws IOException{
			String articleNoVal = req.getParameter("article_no");
			String pageNoVal = req.getParameter("pageNo");
			int pageNo = 1;
			if(pageNoVal != null){
				pageNo = Integer.parseInt(pageNoVal);
			}
			int article_no = Integer.parseInt(articleNoVal);
			CommentPage commentPage = commentService.getCommentPage(pageNo, article_no);
			req.setAttribute("articlePage", commentPage);
			return "/WEB-INF/view/board/comment/listComment.jsp";
	}
	
	//작성
	private String processWrite(HttpServletRequest req, HttpServletResponse res)
		throws IOException{
		Map<String, Boolean> errors = new HashMap<>();
		req.setAttribute("errors", errors);
		
		User user = (User)req.getSession(false).getAttribute("authUser");
		WriteCommentRequest writeCommentRequest = new WriteCommentRequest(
				new Commenter(user.getId(), user.getName()), 
				req.getParameter("comment"), Integer.parseInt(req.getParameter("article_no")));
		
		return "/WEB-INF/view/board/comment/listComment.jsp";
	}
}
