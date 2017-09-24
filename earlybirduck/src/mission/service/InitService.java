package mission.service;

import java.sql.Connection;
import java.sql.SQLException;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import mission.dao.MissionDao;
import mission.model.Mission;

public class InitService {
	
	private MissionDao missionDao = new MissionDao();
	
	public void init(MissionInit missionInit){
		Connection conn = null;
		try{
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			
			Mission mission = new Mission(missionInit.getId(),
					missionInit.getYear(),
					missionInit.getMonth(),
					missionInit.getDay(),
					missionInit.getWeek());
			
			missionDao.insert(conn, mission);
			conn.commit();
		} catch(SQLException e){
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		}finally{
			JdbcUtil.close(conn);
		}
	}
	


}
