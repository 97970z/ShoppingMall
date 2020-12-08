package review;

public class Review {
	private int wID;
	private int pID;
	private String userID;
	private String content;
	
	public int getwID() {
		return wID;
	}
	public void setwID(int wID) {
		this.wID = wID;
	}
	public int getpID() {
		return pID;
	}
	public void setpID(int pID) {
		this.pID = pID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
