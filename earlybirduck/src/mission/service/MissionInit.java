package mission.service;

import java.util.Calendar;

public class MissionInit {
	
	Calendar now = Calendar.getInstance();
	
	private String id;
	private int year = now.get(Calendar.YEAR);
	private int month = now.get(Calendar.MONTH)+1;
	private int day = now.get(Calendar.DAY_OF_MONTH);
	private String week = strWeek(now.get(Calendar.DAY_OF_WEEK));
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}

	public String strWeek(int week){
		switch(week){
		case Calendar.MONDAY:
			return "MON";
		case Calendar.TUESDAY:
			return "TUE";
		case Calendar.WEDNESDAY:
			return "WED";
		case Calendar.THURSDAY:
			return "THU";
		case Calendar.FRIDAY:
			return "FRI";
		case Calendar.SATURDAY:
			return "SAT";
		default:
			return "SUN";
		}
	}
}
