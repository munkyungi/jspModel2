package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	// Driver 확인
	public static void initConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			System.out.println("Driver Loading Success");
		} catch (ClassNotFoundException e) {
			System.out.println("Driver Loading Failed");
			e.printStackTrace();
		}
	}
	
	// DB Connection data 얻기
	public static Connection getConnection() {
		Connection conn = null;
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://192.168.219.190:3306/mydb", "root", "1234");
			
			System.out.println("Connection Success");
		} catch (SQLException e) {
			System.out.println("db Connection Failed");
			e.printStackTrace();
		}
		
		return conn;
	}
}
