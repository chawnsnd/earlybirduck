package record.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class RecordHandler implements CommandHandler{
	
	private static final String FORM_VIEW = "/WEB-INF/view/record/recordForm.jsp";

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res){
		return FORM_VIEW;
	}
}
