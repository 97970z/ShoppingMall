package cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;
import product.Product;
import review.Review;

public class CartDAO {
	// dao : 데이터베이스 접근 객체의 약자
			private Connection conn; // connection:db에접근하게 해주는 객체

			//private PreparedStatement pstmt;
			private ResultSet rs;

			// mysql 처리부분
			public CartDAO() {
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
			
			public int getNext() { 
				String SQL = "SELECT cartID FROM CART ORDER BY cartID DESC";
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
			
			//실제로 글을 작성하는 함수
			public int write(int pID, String userID, String pName, int pPrice, String pFile, int pStock) { 
				String SQL = "INSERT INTO CART VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext());
					pstmt.setInt(2, pID);
					pstmt.setString(3, userID);
					pstmt.setString(4, pName);
					pstmt.setInt(5, pPrice);
					pstmt.setString(6, pFile);
					pstmt.setInt(7, 1);
					pstmt.setInt(8, pStock);
					pstmt.setInt(9, 1);


					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; //데이터베이스 오류
			}
			
			public ArrayList<Cart> getList(int pageNumber){ 
				String SQL = "SELECT * FROM CART WHERE cartID < ? AND STATEMENT = 1 ORDER BY cartID";
				ArrayList<Cart> list = new ArrayList<Cart>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
					rs = pstmt.executeQuery();
					
					while (rs.next()) {
						Cart cart = new Cart();
						
						cart.setcartID(rs.getInt(1));
						cart.setpID(rs.getInt(2));
						cart.setuserID(rs.getString(3));
						cart.setpName(rs.getString(4));
						cart.setpPrice(rs.getInt(5));
						cart.setpFile(rs.getString(6));
						cart.setstatement(rs.getInt(7));
						cart.setpStock(rs.getInt(8));
						cart.setamount(rs.getInt(9));

						list.add(cart);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list; 
			}
			
			public int update(int pID) {
				String SQL = "UPDATE CART SET amount = amount + ? WHERE pID = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, 1);
					pstmt.setInt(2, pID);
					
					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; // 데이터베이스 오류
			}
			
			public int delete(int cartID) {
				String SQL = "UPDATE CART SET STATEMENT = 0 WHERE cartID = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);   
					pstmt.setInt(1, cartID);
					
					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; // 데이터베이스 오류
			}
			public int Alldelete(String userID) {
				String SQL = "DELETE FROM CART WHERE userID = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);   
					pstmt.setString(1, userID);
					
					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; // 데이터베이스 오류
			}
			
}
