package buy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import product.Product;

public class BuyDAO {
	private Connection conn; // connection:db에접근하게 해주는 객체

	//private PreparedStatement pstmt;
	private ResultSet rs;

	// mysql 처리부분
	public BuyDAO() {
		// 생성자를 만들어준다.
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//현재의 시간을 가져오는 함수
			public String getDate() {
				String SQL = "SELECT NOW()";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						return rs.getString(1);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return ""; //데이터베이스 오류
			}
			
			public int getNext() { 
				String SQL = "SELECT orderID FROM BUY ORDER BY orderID DESC";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						return rs.getInt(1) + 1;
					}
					return 1;//첫 번째 게시물인 경우
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; //데이터베이스 오류
			}
			
			public int write(int pID, String userID, String name, String address, String contact, String pname, int amount, int price, String file) { 
				String SQL = "INSERT INTO BUY VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext());
					pstmt.setInt(2, pID);
					pstmt.setString(3, userID);
					pstmt.setString(4, name);
					pstmt.setString(5, address);
					pstmt.setString(6, contact);
					pstmt.setString(7, pname);
					pstmt.setInt(8, amount);
					pstmt.setInt(9, price * amount);
					pstmt.setString(10, getDate());
					pstmt.setString(11, file);

					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; //데이터베이스 오류
			}
			
			public int write_cart(int pID, String userID, String name, String address, String contact, String pname, int amount, int price, String file) { 
				String SQL = "INSERT INTO BUY VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext());
					pstmt.setInt(2, pID);
					pstmt.setString(3, userID);
					pstmt.setString(4, name);
					pstmt.setString(5, address);
					pstmt.setString(6, contact);
					pstmt.setString(7, pname);
					pstmt.setInt(8, amount);
					pstmt.setInt(9, price);
					pstmt.setString(10, getDate());
					pstmt.setString(11, file);

					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; //데이터베이스 오류
			}
			
			public ArrayList<Buy> getList(int pageNumber){ 
				String SQL = "SELECT * FROM BUY WHERE orderID < ? ORDER BY orderID DESC";
				ArrayList<Buy> list = new ArrayList<Buy>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
					rs = pstmt.executeQuery();
					
					while (rs.next()) {
						Buy buy = new Buy();
						buy.setorderID(rs.getInt(1));
						buy.setpID(rs.getInt(2));
						buy.setuserID(rs.getString(3));
						buy.setname(rs.getString(4));
						buy.setaddress(rs.getString(5));
						buy.setcontact(rs.getString(6));
						buy.setpname(rs.getString(7));
						buy.setamount(rs.getInt(8));
						buy.setprice(rs.getInt(9));
						buy.setorderTime(rs.getString(10));
						buy.setfile(rs.getString(11));
						list.add(buy);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list; 
			}
			
			public int update(int pID, int amount) {
				String SQL = "UPDATE PRODUCT SET pStock = pStock - ? WHERE pID = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, amount);
					pstmt.setInt(2, pID);
					
					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; // 데이터베이스 오류
			}
}
