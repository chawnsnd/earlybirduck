package mission.command;

import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import auth.service.User;
import mission.service.DetailService;
import mission.service.InitService;
import mission.service.MissionInit;
import mvc.command.CommandHandler;

public class MissionHandler implements CommandHandler{
	
	private static final String FORM_VIEW = "/WEB-INF/view/mission.jsp";
	private InitService initService = new InitService();
	private DetailService detailService = new DetailService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res){
		if(req.getMethod().equalsIgnoreCase("GET")){
			return processForm(req, res);
		}else if(req.getMethod().equalsIgnoreCase("POST")){
			return processSubmit(req, res);
		}else{
			res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}
	}
	
	private String processForm(HttpServletRequest req, HttpServletResponse res){
		return FORM_VIEW;
	}
	
	private String processSubmit(HttpServletRequest req, HttpServletResponse res){
		MissionInit missionInit = new MissionInit();
		User user = (User)req.getSession(false).getAttribute("authUser");
		String id = user.getId();
		missionInit.setId(id);
		String order = req.getParameter("order");
		
		//시간 유효성 확인
		Calendar today = Calendar.getInstance();
		int week = today.get(Calendar.DAY_OF_MONTH);
		Date now = new Date();
		int hours = now.getHours();
		int minutes = now.getMinutes();

		if(week==7 || week==1){ //주말일때
			if(hours != 8){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/missionFail.jsp";}//8시 그때 아니면 안됨
			if(order.equals("1")){ //1번클릭인데
				if(minutes>20){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/missionFail.jsp";}
			} else if(order.equals("2")){ //2번클릭인데
				if(minutes<20 || minutes>40){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/missionFail.jsp";}
			} else{ //3번클릭인데
				if(minutes<40){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/missionFail.jsp";}
			}
		}else{
			if(hours != 7){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/missionFail.jsp";} //8시 그때 아니면 안됨
			if(order.equals("1")){ //1번클릭인데
				if(minutes>20){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/missionFail.jsp";}
			} else if(order.equals("2")){ //2번클릭인데
				if(minutes<20 || minutes>40){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/missionFail.jsp";}
			} else{ //3번클릭인데
				if(minutes<40){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/missionFail.jsp";}
			}
		}
		
		//1번 클릭했을 떄
		if(order.equals("1")){
			try{
				initService.init(missionInit);
			}catch(Exception e){
				e.printStackTrace();
				return "/WEB-INF/view/missionFail.jsp";
			}
		}

		//일반적인 시간저장
		try{
			detailService.missionUpdate(missionInit, order);
			return "/WEB-INF/view/missionSuccess.jsp";
		}catch(Exception e){
			e.printStackTrace();
			return "/WEB-INF/view/missionFail.jsp";
		}

	}

}
