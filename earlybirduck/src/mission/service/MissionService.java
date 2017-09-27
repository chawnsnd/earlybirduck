package mission.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import mission.dao.MissionDao;
import mission.model.Mission;

public class MissionService {
	
	private MissionDao missionDao = new MissionDao();
	
	public void performance(MissionReq missionReq){
		Calendar today = Calendar.getInstance();
		int week = today.get(Calendar.WEEK_OF_MONTH);
		Date now = new Date();
		int hours = now.getHours();
		int minutes = now.getMinutes();
		Connection conn = null;
		try{
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			Mission mission = null;
			
			//일단 테이블에 컬럼이 있나?
			mission = missionDao.selectById(conn, missionReq.getId(), missionReq.getYear(),
					missionReq.getMonth(), missionReq.getDay()); //문제! 여기서 다 널됨
			
			//칼럼이 없으면 미션넣음
			if(mission==null){
				mission = new Mission(missionReq.getId(),
					missionReq.getYear(),
					missionReq.getMonth(),
					missionReq.getDay(),
					missionReq.getWeek());
				missionDao.insert(conn, mission);
			}
			
			//1번시도일 때
			if(missionReq.getOrder()==1){
				//시간유효성검사 -> 타임익셉션
				if(((week==7||week==1)&&(hours!=8||minutes>=20))||
						((week>=2&&week<=6)&&(hours!=7||minutes>=20))){
					System.out.println("여기들어가면 실팬데");
					throw new TimeException();
				}else{
					missionDao.firstUpdate(conn, mission);
					System.out.println(week+" "+hours+" "+minutes);
				}
			//2번시도일 떄
			}else if(missionReq.getOrder()==2){
				//시간 유효성 검사 -> 타임익셉션
				if(((week==7||week==1)&&(hours!=8||(minutes<20)&&(minutes>=40)))||
						((week>=2&&week<=6)&&(hours!=7||(minutes<20)&&(minutes>=40)))){
					throw new TimeException();
				}else{
					missionDao.secondUpdate(conn, mission);
				}
			//3번시도일 때
			}else{
				//시간 유효성 검사 -> 타임익셉션
				if(((week==7||week==1)&&(hours!=8||minutes<40))||
						((week>=2&&week<=6)&&(hours!=7||minutes<40))){
					throw new TimeException();
				}else{
					missionDao.thirdUpdate(conn, mission);
				}
			}
			conn.commit();
		} catch(SQLException e){
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		}finally{
			JdbcUtil.close(conn);
		}
	}
	


}
