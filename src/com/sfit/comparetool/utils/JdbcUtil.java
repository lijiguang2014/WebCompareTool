package com.sfit.comparetool.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class JdbcUtil {
	
	//创建数据库连接
	public static Connection getConnection(String url, String username, String password){
		Connection conn = null;
		
		try {
			if (url.contains("jdbc:oracle:")) {
				//加载驱动  
				Class.forName("oracle.jdbc.driver.OracleDriver");
			} else if (url.startsWith("jdbc:mysql:")) {
				Class.forName("com.mysql.jdbc.Driver");
			}
			//获得连接  
			conn = DriverManager.getConnection(url, username, password);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return conn;
	}
}
