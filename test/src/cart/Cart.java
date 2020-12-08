package cart;

public class Cart {
	private int cartID;
	private int pID;
	private String userID;
	private int pPrice;
	private String pName;
	private String pFile;
	private int statement;
	private int pStock;
	private int amount;
	
	public int getcartID() {
		return cartID;
	}
	public void setcartID(int cartID) {
		this.cartID = cartID;
	}
	public int getpID() {
		return pID;
	}
	public void setpID(int pID) {
		this.pID = pID;
	}
	public String getuserID() {
		return userID;
	}
	public void setuserID(String userID) {
		this.userID = userID;
	}
	public int getpPrice() {
		return pPrice;
	}
	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpFile() {
		return pFile;
	}
	public void setpFile(String pFile) {
		this.pFile = pFile;
	}
	public int getstatement() {
		return statement;
	}
	public void setstatement(int statement) {
		this.statement = statement;
	}
	public int getpStock() {
		return pStock;
	}
	public void setpStock(int pStock) {
		this.pStock = pStock;
	}
	public int getamount() {
		return amount;
	}
	public void setamount(int amount) {
		this.amount = amount;
	}
}
