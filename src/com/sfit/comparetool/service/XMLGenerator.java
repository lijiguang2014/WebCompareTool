package com.sfit.comparetool.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.sfit.comparetool.bean.IndexBean;
import com.sfit.comparetool.service.i.Generator;
import com.sfit.comparetool.utils.GenerateUtils;
import com.sfit.comparetool.utils.JdbcUtil;

public class XMLGenerator implements Generator {
	private static String url = "jdbc:oracle:thin:@192.168.20.241:1521:orcl";
	private static String username = "fmargin";
	private static String password = "fmargin";

	/**
	 * 获取该用户下所有表的名字
	 */
	private static final String SQL_ALLTABLE = "select * from user_tables order by Table_Name";
	
	/**
	 * 获取数据库表中的字段信息的SQL
	 */
	private static final String SQL_COLUMNINFO = "select * from user_tab_columns where table_name=?";
	
	/**
	 * 获取数据库表的注释的SQL
	 */
	private static final String GET_TABLECOMMENT = "select * from user_tab_comments where table_name=?";
	
	/**
	 * 获取字段数据类型对应的类型别名
	 */
	private static final String GET_TYPENAME = "select * from colums_type where type=?";
	
	/**
	 * 获取某表中某一字段的注释
	 */
	private static final String GET_FIELDDESCRIPTION = "select comments from user_col_comments where table_name=? and column_name=?";
	
	/**
	 * 判断某个字段上是否有主键约束
	 */
	private static final String IS_KEY = "select * from user_constraints a, user_ind_columns b"
	+ " where a.index_name = b.index_name"
    + " and b.table_name = ?"
    + " and b.column_name = ?"
    + " and a.constraint_type = 'P'";
	
	/**
	 * 判断某一列是否为索引列
	 */
	private static final String IS_INDEX = "select a.INDEX_NAME as INDEXNAME, a.COLUMN_NAME as COLUMNNAME, a.DESCEND as DESCEND, b.uniqueness as UNIQUENESS"
			+ " from user_ind_columns a, user_indexes b "
			+ " where a.INDEX_NAME = b.index_name and a.table_Name=? and a.column_Name=?";
	
	private ArrayList<String> tableNameList = new ArrayList<String>();
	private ArrayList<String> uselessTableNameList = new ArrayList<String>(Arrays.asList("H_COMPANYREPORT", "H_COMPANYMESSAGE", "H_COMPCLIENTFEEDBACK", 
			"H_COMPCLIENTIDUPDATE","H_COMPAMCUSTODYACCOUNT","H_COMPCLIENTOPTEXERCISE"));
	
	
	public static void main(String[] args) throws Exception {
		new XMLGenerator().generateEntity(url, username, password, "D:\\fumarginEntity.xml");
		new XMLGenerator().generateXMLType(url, username, password, "D:\\fumarginType.xml");
	}
	
	public void generateXMLType(String url, String username, String password, String resultPath) throws Exception {
		try {
			GenerateUtils generateUtils = new GenerateUtils();
			Map<String, String> typeMap = generateUtils.generateTypeMap(url, username, password);

			FileOutputStream fos = new FileOutputStream(resultPath);
			OutputStreamWriter osw = new OutputStreamWriter(fos, "GBK");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<UFDataTypes>\r\n");
			for(String alias : typeMap.keySet()) {
				String type = typeMap.get(alias);
				if (type.toUpperCase().startsWith("VARCHAR2")) {
					sb.append("\t<VString typename=\"" + alias + "\" length=\"" + type.substring(type.indexOf("(")+1, type.indexOf(")")) 
							+ "\" label=\"\" />\r\n");
				} else if (type.toUpperCase().startsWith("CHAR")) {
					sb.append("\t<String typename=\"" + alias + "\" length=\"" + type.substring(type.indexOf("(")+1, type.indexOf(")"))
							+ "\" label=\"\" />\r\n");
				} else if (type.toUpperCase().startsWith("NUMBER") && type.contains(",")) {
					sb.append("\t<Float typename=\"" + alias + "\" length=\"" + type.substring(type.indexOf("(")+1, type.indexOf(","))
							+ "\" precision=\"" + type.substring(type.indexOf(",")+1, type.indexOf(")")) + "\" label=\"\" />\r\n");
				} else if (type.toUpperCase().startsWith("NUMBER(") && !type.contains(",")) {
					sb.append("\t<Int typename=\"" + alias + "\" length=\"" + type.substring(type.indexOf("(")+1, type.indexOf(")"))
							+ "\" label=\"\" />\r\n");
				} else {
					
				}
			}
			sb.append("</UFDataTypes>");
			osw.append(sb.toString());
			osw.flush();
			osw.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("导出XML格式的TYPE文件中出错!" + e);
		}
	}
	
	public void generateEntity(String url, String username, String password, String resultPath) throws Exception {

		Connection conn = JdbcUtil.getConnection(url, username, password);
		try {
			Statement statement = conn.createStatement();
			ResultSet rs = statement.executeQuery(SQL_ALLTABLE);
			recordTableName(rs);
			rs.close();
			statement.close();
			
			//开始收集各个表字段的信息
//			String domainName = null;
			String domainDescription = null;
			String columnName = null;
			String fieldType = null;
			String typeName = null;
			String fieldDescription = null;
			String isKey = null;
			String notnull = null;
			String tableName = null;
			String dataType = null;
			String dataScale = null;
			int dataLength = 0;
			String dataPrecision = null;
			
			PreparedStatement prepareStatement = conn.prepareStatement(SQL_COLUMNINFO);
			PreparedStatement getTableComment = conn.prepareStatement(GET_TABLECOMMENT);
			PreparedStatement getTypeName = conn.prepareStatement(GET_TYPENAME);
			PreparedStatement getFieldDescription = conn.prepareStatement(GET_FIELDDESCRIPTION);
			PreparedStatement isKeyJudgement = conn.prepareStatement(IS_KEY);
			PreparedStatement isIndexJudgement = conn.prepareStatement(IS_INDEX);
			
			File f = new File(resultPath);
			if (f.exists()) {
				f.delete();
			}
			
			GenerateUtils generateUtils = new GenerateUtils();
			Map<String, String> typeMap = generateUtils.generateTypeMap(url, username, password);
			
			FileOutputStream fos = new FileOutputStream(f, true);
			OutputStreamWriter osw = new OutputStreamWriter(fos, "GBK");
			StringBuilder sb = new StringBuilder();
			sb.append("<?xml version=\"1.0\" encoding=\"GB2312\"?>\r\n");
			sb.append("<!DOCTYPE UFEntityModel SYSTEM \"UFEntity.dtd\">\r\n");
			sb.append("<UFEntityModel>\r\n");
			for (int i = 0; i < tableNameList.size(); i++) {
				tableName = tableNameList.get(i);
				domainDescription = getDomainDescription(getTableComment, tableName);
				sb.append("\t\t<Entity name=\"" + tableName + "\" title=\"" + domainDescription + "\" description=\"" + domainDescription + "\">\r\n");
				
				prepareStatement.setString(1, tableName);
				ResultSet columnInfo = prepareStatement.executeQuery();
				List<IndexBean> indexList = new ArrayList<IndexBean>();
				while (columnInfo.next()) {
					columnName = columnInfo.getString("COLUMN_NAME");
					dataType = columnInfo.getString("DATA_TYPE");
					dataLength = columnInfo.getInt("DATA_LENGTH");
					dataScale = columnInfo.getString("DATA_SCALE");
					dataPrecision = columnInfo.getString("DATA_PRECISION");
					if (dataType.equals("CHAR") || dataType.equals("VARCHAR2")) {
						fieldType = dataType + "(" + dataLength + ")";
					} else if (dataType.equals("NUMBER")&&dataPrecision!=null&&dataScale!=null) {
						fieldType = dataType + "(" + dataPrecision + "," + dataScale + ")";
					} else if (dataType.equals("NUMBER")&&dataPrecision==null&&dataScale==null){
						fieldType = dataType + "(38)" ;
					} else {
						fieldType = dataType;
					}
					typeName = getTypeName(typeMap, fieldType);
					fieldDescription = getFieldDescription(getFieldDescription, tableName, columnName);
					
					isKeyJudgement.setString(1, tableName);
					isKeyJudgement.setString(2, columnName);
					ResultSet isKeyRs = isKeyJudgement.executeQuery();
					if (isKeyRs.next()) {
						isKey = "yes";
					} else {
						isKey = "no";
					}
					isKeyRs.close();
					
					notnull = columnInfo.getString("NULLABLE");
					if ("Y".equals(notnull)) {
						notnull = "no";
					} else {
						notnull = "yes";
					}
					
					isIndexJudgement.setString(1, tableName);
					isIndexJudgement.setString(2, columnName);
					ResultSet indexRs = isIndexJudgement.executeQuery();
					String indexName = null;
					String indexColumnName = null;
					String descend = null;
					String uniqueness = null;
					while(indexRs.next()) {
						indexName = indexRs.getString("INDEXNAME");
						indexColumnName = indexRs.getString("COLUMNNAME");
						descend = indexRs.getString("DESCEND");
						uniqueness = indexRs.getString("UNIQUENESS");
						IndexBean indexBean = new IndexBean();
						indexBean.setIndexName(indexName);
						indexBean.setColumnName(indexColumnName);
						indexBean.setDescend(descend);
						indexBean.setUniqueness(uniqueness);
						indexList.add(indexBean);
					}
					indexRs.close();
					
					sb.append("\t\t\t<Field name=\"" + columnName + "\" type=\"" + typeName
							+ "\" label=\"" + fieldDescription + "\" description=\"" 
							+ fieldDescription + "\" iskey=\"" + isKey + "\" notnull=\""
							+ notnull +"\" />\r\n");
				}
				columnInfo.close();
				sb.append("\t\t</Entity>\r\n");
			}
			sb.append("</UFEntityModel>");
			osw.append(sb.toString());
			prepareStatement.close();
			osw.flush();
			osw.close();
			getTableComment.close();
			getTypeName.close();
			getFieldDescription.close();
			isKeyJudgement.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new Exception("导出XML格式的Entity文件出错!");
		} finally {
			if (null != conn) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					throw new Exception("关闭数据库连接出错");
				}
			}
		}
	}
	
	private String getFieldDescription(PreparedStatement getFieldDescription,
			String tableName, String fieldName) throws SQLException {

		getFieldDescription.setString(1, tableName);
		getFieldDescription.setString(2, fieldName);
		ResultSet rs = getFieldDescription.executeQuery();
		String fieldDescription = " ";
		while (rs.next()) {
			fieldDescription = rs.getString("COMMENTS");
		}
		rs.close();
		
		return fieldDescription == null ? "" : fieldDescription;
	}
	
	
	private String getTypeName(Map<String, String> typeMap, String fieldType) throws SQLException {
		
		String type = null;
		for (String typeName : typeMap.keySet()) {
			type = typeMap.get(typeName);
			if (type.toUpperCase().equals(fieldType.toUpperCase())) {
				return typeName;
			}
		}
		
		return "";
	}
	
	/**
	 * 有comment则返回comment， 没有则返回“”
	 * 
	 * @param ps
	 * @param tableName
	 * @return
	 * @throws SQLException
	 */
	private String getDomainDescription(PreparedStatement ps, String tableName) throws SQLException {
		
		ps.setString(1, tableName);
		ResultSet rs = ps.executeQuery();
		String domainDescription = null;
		while(rs.next()) {
			domainDescription = rs.getString("COMMENTS");
		}
		rs.close();

		return domainDescription == null ? "" : domainDescription;
	}

	
	private void recordTableName(ResultSet rs) throws SQLException {
		String tableName = null;
		while (rs.next()) {
			tableName = rs.getString("TABLE_NAME");
			if(!uselessTableNameList.contains(tableName)) {
				tableNameList.add(tableName);
			}
		}
	}
}
