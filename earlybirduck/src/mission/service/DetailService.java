package mission.service;

import java.sql.Connection;
import java.sql.SQLException;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import mission.dao.MissionDao;
import mission.model.Mission;

public class DetailService {

	private MissionDao missionDao = new MissionDao();
	
	public void missionUpdate(MissionInit missionInit, String order){
		Connection conn = null; 
		Mission mission = new Mission(
				missionInit.getId(),
				missionInit.getYear(),
				missionInit.getMonth(),
				missionInit.getDay(),
				missionInit.getWeek());
		try{
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			if(order.equals("1")){
				missionDao.firstUpdate(conn, mission);
			}else if(order.equals("2")){
				missionDao.secondUpdate(conn, mission);
			}else{
				missionDao.thirdUpdate(conn, mission);
			}
			conn.commit();
		} catch(SQLException e){
			e.printStackTrace();
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		} finally{
			JdbcUtil.close(conn);
		}

	}
}