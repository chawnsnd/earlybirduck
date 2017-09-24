//회원들의 미션수행정보를 담는 VO

package mission.model;


public class Mission {

	private String id;
	private int year;
	private int month;
	private int day;
	private String week;
	private String firstMission;
	private String secondMission;
	private String thirdMission;
	
	public Mission(String id, int year, int month, int day, String week) {
		this.id = id;
		this.year = year;
		this.month = month;
		this.day = day;
		this.week = week;
	}

	public void setFirstMission(String firstMission) {
		this.firstMission = firstMission;
	}

	public void setSecondMission(String secondMission) {
		this.secondMission = secondMission;
	}

	public void setThirdMission(String thirdMission) {
		this.thirdMission = thirdMission;
	}

	public String getId() {
		return id;
	}

	public int getYear() {
		return year;
	}

	public int getMonth() {
		return month;
	}

	public int getDay() {
		return day;
	}

	public String getWeek() {
		return week;
	}

	public String getFirstMission() {
		return firstMission;
	}

	public String getSecondMission() {
		return secondMission;
	}

	public String getThirdMission() {
		return thirdMission;
	}
	
}
