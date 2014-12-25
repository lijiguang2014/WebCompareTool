package com.sfit.comparetool.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sfit.comparetool.bean.IndexBean;
import com.sfit.comparetool.service.i.Generator;
import com.sfit.comparetool.utils.JdbcUtil;

public class XMLGeneratorForMySQL implements Generator {
	
	private static String url = "jdbc:mysql://127.0.0.1:3306/ljg";
	private static String username = "root";
	private static String password = "1234";
	
	/**
	 * 获取该用户下所有表的信息（包含表注释）
	 */
	private static final String SQL_ALLTABLE = "SELECT * FROM INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = ?";//table_schema就是数据库名
	
	/**
	 * 获取数据库表中的字段信息的SQL（包含表注释）
	 */
	private static final String SQL_COLUMNINFO = "SELECT * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = ? and TABLE_SCHEMA=?";
	
	/**
	 * 获取字段数据类型对应的类型别名
	 */
	private static final String GET_TYPENAME = "select * from colums_type where type=?";
	
	/**
	 * 判断某个字段上是否有主键约束
	 */
	private static final String IS_KEY = "SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE a, INFORMATION_SCHEMA.TABLE_CONSTRAINTS b "
			+ "where a.CONSTRAINT_NAME=b.CONSTRAINT_NAME AND a.TABLE_NAME = b.TABLE_NAME "
			+ "AND a.TABLE_SCHEMA = b.TABLE_SCHEMA AND b.CONSTRAINT_TYPE='PRIMARY KEY'"
			+ " and a.TABLE_NAME=? and a.TABLE_SCHEMA=? AND a.COLUMN_NAME =?";
	
	/**
	 * 判断某一列是否为索引列
	 */
	private static final String IS_INDEX = "SELECT * FROM INFORMATION_SCHEMA.STATISTICS "
			+ "WHERE COLUMN_NAME = ? AND INDEX_SCHEMA = ?";
	
	public static void main(String[] args) throws IOException {
		new XMLGeneratorForMySQL().generateEntity(url, username, password, "D:\\fumarginEntity.xml");
	}
	
	public void generateEntity(String url, String username, String password, String resultPath) throws IOException {

		Connection conn = JdbcUtil.getConnection(url, username, password);
		String databaseName = getDatabaseName(url);
		
		File f = new File(resultPath);
		if (f.exists()) {
			f.delete();
		}
		FileOutputStream fos = new FileOutputStream(f, true);
		OutputStreamWriter osw = new OutputStreamWriter(fos, "GBK");
		
		//开始收集各个表字段的信息
		String tableName = null;
		String domainDescription = null;
		String columnName = null;
		String columnType = null;
		String typeName = null;
		String columnComment = null;
		String iskey = null;
		String notnull = null;
		
		try {
			PreparedStatement tableStatement = conn.prepareStatement(SQL_ALLTABLE);
			tableStatement.setString(1,databaseName);
			ResultSet rs = tableStatement.executeQuery();
			
			StringBuilder sb = new StringBuilder();
			sb.append("<?xml version=\"1.0\" encoding=\"GB2312\"?>\r\n");
			sb.append("<!DOCTYPE UFEntityModel SYSTEM \"UFEntity.dtd\">\r\n");
			sb.append("<UFEntityModel>\r\n");
			while (rs.next()) {
				tableName = rs.getString("TABLE_NAME");
				domainDescription = rs.getString("TABLE_COMMENT");
				sb.append("\t\t<Entity name=\"" + tableName + "\" title=\"" + domainDescription + "\" description=\"" + domainDescription + "\">\r\n");
				sb.append("\t\t\t<Field name=\"字段名称\" type=\"类型名称\" label=\"字段说明\" description=\"字段说明\" iskey=\"iskey\" notnull=\"notnull\" />\r\n");
				
				PreparedStatement columnStatement = conn.prepareStatement(SQL_COLUMNINFO);
				columnStatement.setString(1, tableName);
				columnStatement.setString(2, databaseName);
				ResultSet columnRs = columnStatement.executeQuery();
				
				List<IndexBean> indexList = new ArrayList<IndexBean>();
				while (columnRs.next()) {
					columnName = columnRs.getString("COLUMN_NAME");
					columnType = columnRs.getString("COLUMN_TYPE");
					
					PreparedStatement getTypeName = conn.prepareStatement(GET_TYPENAME);
					typeName = getTypeName(getTypeName, columnType);
					
					columnComment = columnRs.getString("COLUMN_COMMENT");
					PreparedStatement isKeyStatement = conn.prepareStatement(IS_KEY);
					isKeyStatement.setString(1, databaseName);
					isKeyStatement.setString(2, tableName);
					isKeyStatement.setString(3, columnName);
					ResultSet isKeyRs = isKeyStatement.executeQuery();
					iskey = "no";
					while(isKeyRs.next()) {
						iskey = "yes";
					}
					notnull = columnRs.getString("IS_NULLABLE").equals("NO") ? "yes" : "no";
					
					PreparedStatement isIndexStatement = conn.prepareStatement(IS_INDEX);
					isIndexStatement.setString(1, columnName);
					isIndexStatement.setString(2, databaseName);
					ResultSet indexRs = isIndexStatement.executeQuery();
					String indexName = null;
					String indexColumnName = null;
					String descend = null;
					String uniqueness = null;
					while(indexRs.next()) {
						indexName = indexRs.getString("INDEX_NAME");
						indexColumnName = indexRs.getString("COLUMN_NAME");
						IndexBean indexBean = new IndexBean();
						indexBean.setIndexName(indexName);
						indexBean.setColumnName(indexColumnName);
						indexList.add(indexBean);
					}
					indexRs.close();
					sb.append("\t\t\t<Field name=\"" + columnName + "\" type=\"" + typeName
							+ "\" label=\"" + columnComment + "\" description=\"" 
							+ columnComment + "\" iskey=\"" + iskey + "\" notnull=\""
							+ notnull +"\" />\r\n");
				}
				columnRs.close();
				sb.append("\t\t</Entity>\r\n");
			}
			sb.append("</UFEntityModel>");
			osw.append(sb.toString());
			osw.flush();
			
			rs.close();
			tableStatement.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != osw) {
				osw.close();
			}
			if (null != conn) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
			
	}
	
	private String getDatabaseName(String url) {
		String[] ss = url.split("/");
		return ss[ss.length-1];
	}

	
	/**
	 * 从表colums_type获取数据类型对应的别名
	 * 
	 * @param getTypeName
	 * @param fieldType
	 * @return
	 * @throws SQLException
	 */
	private String getTypeName(PreparedStatement getTypeName, String columnType) throws SQLException {
		
		return columnType;
	}
	
}
