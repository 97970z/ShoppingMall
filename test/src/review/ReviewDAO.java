package review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import product.Product;

public class ReviewDAO {
	private Connection conn; // connection:db�������ϰ� ���ִ� ��ü

	//private PreparedStatement pstmt;
	private ResultSet rs;

	// mysql ó���κ�
	public ReviewDAO() {
		// �����ڸ� ������ش�.
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
		String SQL = "SELECT wID FROM REVIEW ORDER BY wID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;//ù ��° �Խù��� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	//������ ���� �ۼ��ϴ� �Լ�
	public int write(int pID, String userID, String content) { 
		String SQL = "INSERT INTO REVIEW VALUES(?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, pID);
			pstmt.setString(3, userID);
			pstmt.setString(4, content);


			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	public ArrayList<Review> getList(int pageNumber){ 
		String SQL = "SELECT * FROM REVIEW WHERE wID < ? ORDER BY wID DESC LIMIT 10";
		ArrayList<Review> list = new ArrayList<Review>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Review review = new Review();
				review.setwID(rs.getInt(1));
				review.setpID(rs.getInt(2));
				review.setUserID(rs.getString(3));
				review.setContent(rs.getString(4));

				list.add(review);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	public Review getReview(int wID) {
		String SQL = "SELECT * FROM REVIEW WHERE wID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, wID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Review review = new Review();
				review.setwID(rs.getInt(1));
				review.setpID(rs.getInt(2));
				review.setUserID(rs.getString(3));
				review.setContent(rs.getString(4));
				
				return review;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int delete(int pID) {
		String SQL = "DELETE FROM REVIEW WHERE wID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);   
			pstmt.setInt(1, pID);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
}
