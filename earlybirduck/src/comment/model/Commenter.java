package comment.model;

public class Commenter {
	private String id;
	private String name;
	
	public Commenter(String id, String name){
		this.id = id;
		this.name = name;
	}
	
	public String getId(){
		return id;
	}
	
	public String getName(){
		return name;
	}
}
