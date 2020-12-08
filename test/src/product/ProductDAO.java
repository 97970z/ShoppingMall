package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import bbs.Bbs;
import product.Product;

public class ProductDAO {
		// dao : �����ͺ��̽� ���� ��ü�� ����
		private Connection conn; // connection:db�������ϰ� ���ִ� ��ü

		//private PreparedStatement pstmt;
		private ResultSet rs;

		// mysql ó���κ�
		public ProductDAO() {
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
		
		//������ �ð��� �������� �Լ�
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
			return ""; //�����ͺ��̽� ����
		}

		//��ȣ �������� �Լ�
		public int getNext() { 
			String SQL = "SELECT pID FROM PRODUCT ORDER BY pID DESC";
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
			public int write(String pName, String pExp, int pStock, int pPrice, String pFile) { 
				String SQL = "INSERT INTO PRODUCT VALUES(?, ?, ?, ?, ?, ?, ?)";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext());
					pstmt.setString(2, pName);
					pstmt.setInt(3, pPrice);
					pstmt.setInt(4, pStock);
					pstmt.setString(5, pExp);
					pstmt.setString(6, pFile);
					pstmt.setString(7, getDate());

					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; //�����ͺ��̽� ����
			}
			
			public ArrayList<Product> getList(int pageNumber){ 
				String SQL = "SELECT * FROM PRODUCT WHERE pID < ? ORDER BY pID DESC LIMIT 10";
				ArrayList<Product> list = new ArrayList<Product>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
					rs = pstmt.executeQuery();
					
					while (rs.next()) {
						Product product = new Product();
						product.setpID(rs.getInt(1));
						product.setpName(rs.getString(2));
						product.setpPrice(rs.getInt(3));
						product.setpStock(rs.getInt(4));
						product.setpExp(rs.getString(5));
						product.setpFile(rs.getString(6));
						product.setpDate(rs.getString(7));
						list.add(product);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list; 
			}
			
			public Product getProduct(int pID) {
				String SQL = "SELECT * FROM PRODUCT WHERE pID = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, pID);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						Product product = new Product();
						product.setpID(rs.getInt(1));
						product.setpName(rs.getString(2));
						product.setpPrice(rs.getInt(3));
						product.setpStock(rs.getInt(4));
						product.setpExp(rs.getString(5));
						product.setpFile(rs.getString(6));
						product.setpDate(rs.getString(7));
						
						return product;
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return null;
			}
			
			public int update(int pID, String pName, int pPrice, int pStock, String pExp) {
				String SQL = "UPDATE PRODUCT SET pName = ?, pPrice = ?, pStock = ?, pExp = ? WHERE pID = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, pName);
					pstmt.setInt(2, pPrice);
					pstmt.setInt(3, pStock);
					pstmt.setString(4, pExp);
					pstmt.setInt(5, pID);
					
					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; // �����ͺ��̽� ����
			}
			
			public int delete(int pID) {
				String SQL = "DELETE FROM PRODUCT WHERE pID = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);   
					pstmt.setInt(1, pID);
					
					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; // �����ͺ��̽� ����
			}
			public int delete_review(int pID) {
				String SQL = "DELETE FROM REVIEW WHERE pID = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);   
					pstmt.setInt(1, pID);
					
					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; // �����ͺ��̽� ����
			}
			
			public ArrayList<Product> getSearchList(String search){ 
				String SQL = "SELECT * FROM PRODUCT WHERE pName LIKE '%" + search + "%'";
				ArrayList<Product> list = new ArrayList<Product>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					//pstmt.setString(1, search);
					rs = pstmt.executeQuery();
					
					while (rs.next()) {
						Product product = new Product();
						product.setpID(rs.getInt(1));
						product.setpName(rs.getString(2));
						product.setpPrice(rs.getInt(3));
						product.setpStock(rs.getInt(4));
						product.setpExp(rs.getString(5));
						product.setpFile(rs.getString(6));
						product.setpDate(rs.getString(7));
						list.add(product);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list; 
			}
}