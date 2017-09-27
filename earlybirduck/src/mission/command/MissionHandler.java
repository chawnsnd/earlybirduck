package mission.command;

import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import auth.service.User;
import mission.service.MissionReq;
import mission.service.MissionService;
import mission.service.TimeException;
import mvc.command.CommandHandler;

public class MissionHandler implements CommandHandler{
	
	private static final String FORM_VIEW = "/WEB-INF/view/mission/missionPerformance.jsp";
	private MissionService missionService = new MissionService();
	
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
		MissionReq missionReq = new MissionReq();
		User user = (User)req.getSession(false).getAttribute("authUser");
		String id = user.getId();
		missionReq.setId(id);
		String order = req.getParameter("order");
		missionReq.setOrder(Integer.parseInt(order));
		
		//시간 유효성 확인 -> 그냥 클라이언트에서 하는걸로 합시다
/*		Calendar today = Calendar.getInstance();
		int week = today.get(Calendar.DAY_OF_MONTH);
		Date now = new Date();
		int hours = now.getHours();
		int minutes = now.getMinutes();

		if(week==7 || week==1){ //주말일때
			if(hours != 8){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/mission/missionFail.jsp";}//8시 그때 아니면 안됨
			if(order.equals("1")){ //1번클릭인데
				if(minutes>20){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/mission/missionFail.jsp";}
			} else if(order.equals("2")){ //2번클릭인데
				if(minutes<20 || minutes>40){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/mission/missionFail.jsp";}
			} else{ //3번클릭인데
				if(minutes<40){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/mission/missionFail.jsp";}
			}
		}else{ //평일일때
			if(hours != 7){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/mission/missionFail.jsp";} //7시 그때 아니면 안됨
			if(order.equals("1")){ //1번클릭인데
				if(minutes>20){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/mission/missionFail.jsp";}
			} else if(order.equals("2")){ //2번클릭인데
				if(minutes<20 || minutes>40){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/mission/missionFail.jsp";}
			} else{ //3번클릭인데
				if(minutes<40){ System.out.println("걸렸다 요놈"); return "/WEB-INF/view/mission/missionFail.jsp";}
			}
		}
		*/

		try{
			missionService.performance(missionReq);
			return "/WEB-INF/view/mission/missionSuccess.jsp";
		}catch(TimeException e){
			e.printStackTrace();
			return "/WEB-INF/view/mission/missionTimeFail.jsp";
		}catch(Exception e){
			e.printStackTrace();
			return "/WEB-INF/view/mission/missionFail.jsp";
		}

	}

}
