package com.sfit.comparetool.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.sfit.comparetool.bean.IndexBean;
import com.sfit.comparetool.service.i.Generator;
import com.sfit.comparetool.utils.JdbcUtil;

public class CSVGenerator implements Generator {
//	private String url = "jdbc:oracle:thin:@192.168.20.241:1521:orcl";
//	private String username = "fmargin";
//	private String password = "fmargin";

	/**
	 * 获取该用户下所有表的名字
	 */
	private static final String SQL_ALLTABLE = "select * from user_tables order by Table_Name";
	
//	/**
//	 * 获取公司上报接口文件的数据库表名的SQL
//	 */
//	private static final String SQL_COMPTABLE = "select * from user_tables where table_name like 'H_COMP%'";
//	
//	/**
//	 * 获取交易所上报接口文件的数据库表名的SQL
//	 */
//	private static final String SQL_EXTABLE = "select * from user_tables where table_name like 'H_EX%'";
//	
//	/**
//	 * 获取银行上报接口文件的数据库表名的SQL
//	 */
//	private static final String SQL_BANKTABLE = "select * from user_tables where table_name like 'H_BANK%'";
//	
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
		
	public CSVGenerator() {
	}
	
	public void generateEntity(String url, String username, String password, String resultPath) throws IOException {
		Connection conn = JdbcUtil.getConnection(url, username, password);
		try {
			Statement statement = conn.createStatement();
			ResultSet rs = statement.executeQuery(SQL_ALLTABLE);
//			ResultSet rs = statement.executeQuery(SQL_COMPTABLE);
//			recordTableName(rs);
//			rs = statement.executeQuery(SQL_EXTABLE);
//			recordTableName(rs);
//			rs = statement.executeQuery(SQL_BANKTABLE);
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
			int dataScale = 0;
			int dataLength = 0;
			int dataPrecision = 0;
			
			PreparedStatement prepareStatement = conn.prepareStatement(SQL_COLUMNINFO);
			PreparedStatement getTableComment = conn.prepareStatement(GET_TABLECOMMENT);
			PreparedStatement getTypeName = conn.prepareStatement(GET_TYPENAME);
			PreparedStatement getFieldDescription = conn.prepareStatement(GET_FIELDDESCRIPTION);
			PreparedStatement isKeyJudgement = conn.prepareStatement(IS_KEY);
			PreparedStatement isIndexJudgement = conn.prepareStatement(IS_INDEX);
			
			StringBuilder sb = new StringBuilder();
			File f = new File(resultPath);
			if (f.exists()) {
				f.delete();
			}
			FileOutputStream fos = new FileOutputStream(f, true);
			OutputStreamWriter osw = new OutputStreamWriter(fos, "GBK");
			for (int i = 0; i < tableNameList.size(); i++) {
				sb.append("编号,");
				sb.append(String.valueOf(i)+",");
				setEmptyCharacter(sb, 3, 8);
				writeIntoFile(osw, sb);
				
				tableName = tableNameList.get(i);
				sb.append("域名称,");
				sb.append(tableName + ",");
				setEmptyCharacter(sb, 3, 8);
				writeIntoFile(osw, sb);
				
				domainDescription = getDomainDescription(getTableComment, tableName);
				sb.append("域说明,");
				sb.append(domainDescription + ",");
				setEmptyCharacter(sb, 3, 8);
				writeIntoFile(osw, sb);
				
				sb.append("备注,");
				sb.append("来自核对系统,");
				setEmptyCharacter(sb, 3, 8);
				writeIntoFile(osw, sb);
				
				sb.append("字段名称,");
//				sb.append("字段类型,");
				sb.append("类型名称,");
				sb.append("字段说明,");
				sb.append("iskey,");
				sb.append("notnull,");
				sb.append("备注,");
				sb.append(",");
				writeIntoFile(osw, sb);
				
				prepareStatement.setString(1, tableName);
				ResultSet columnInfo = prepareStatement.executeQuery();
				List<IndexBean> indexList = new ArrayList<IndexBean>();
				while (columnInfo.next()) {
					columnName = columnInfo.getString("COLUMN_NAME");
					dataType = columnInfo.getString("DATA_TYPE");
					dataLength = columnInfo.getInt("DATA_LENGTH");
					dataScale = columnInfo.getInt("DATA_SCALE");
					dataPrecision = columnInfo.getInt("DATA_PRECISION");
					if (dataType.equals("CHAR") || dataType.equals("VARCHAR2")) {
						fieldType = dataType + "(" + dataLength + ")";
					} else {
						fieldType = dataType + "(" + dataPrecision + "," + dataScale + ")";
					}
					typeName = getTypeName(getTypeName, fieldType);
					fieldDescription = getFieldDescription(getFieldDescription, tableName, columnName);
					
					sb.append(columnName + ",");
//					sb.append(fieldType + ",");
					sb.append(typeName + ",");
					sb.append(fieldDescription + ",");
					
					isKeyJudgement.setString(1, tableName);
					isKeyJudgement.setString(2, columnName);
					ResultSet isKeyRs = isKeyJudgement.executeQuery();
					if (isKeyRs.next()) {
						isKey = "yes";
					} else {
						isKey = "no";
					}
					isKeyRs.close();
					sb.append(isKey + ",");
					
					notnull = columnInfo.getString("NULLABLE");
					if ("Y".equals(notnull)) {
						notnull = "no";
					} else {
						notnull = "yes";
					}
					sb.append(notnull + ",");
					sb.append(",");
					
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
					
					sb.append(",");
					writeIntoFile(osw, sb);
				}
				columnInfo.close();
				if (indexList.size() > 0) {
					sb.append("索引名,");
					sb.append("列名,");
					sb.append("descend,");
					sb.append("uniqueness,");
					setEmptyCharacter(sb, 5, 8);
					writeIntoFile(osw, sb);
					for (IndexBean index : indexList) {
						sb.append(index.getIndexName() + ",");
						sb.append(index.getColumnName()+ ",");
						sb.append(index.getDescend());
						sb.append(index.getUniqueness());
						setEmptyCharacter(sb, 5, 8);
						writeIntoFile(osw, sb);
					}
					indexList.clear();
				}
				
				setEmptyCharacter(sb, 1, 8);
				writeIntoFile(osw, sb);
				setEmptyCharacter(sb, 1, 8);
				writeIntoFile(osw, sb);
			}
			prepareStatement.close();
			osw.flush();
			osw.close();
			getTableComment.close();
			getTypeName.close();
			getFieldDescription.close();
			isKeyJudgement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (null != conn) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	private void writeIntoFile(OutputStreamWriter osw, StringBuilder sb) throws IOException {
		osw.append(sb.toString());
		osw.append("\r\n");
		sb.delete(0, sb.length());
	}

	private void setEmptyCharacter(StringBuilder sb, int start, int end) throws SQLException {
		for(int i = start; i < (end+1); i++) {
			sb.append(",");
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

	private String getTypeName(PreparedStatement getTypeName, String fieldType) throws SQLException {
		
		getTypeName.setString(1, fieldType);
		ResultSet rs = getTypeName.executeQuery();
		String typeName = " ";
		while (rs.next()) {
			typeName = rs.getString("TYPE_NAME");
		}
		rs.close();
		
		return typeName == null ? "" : typeName;
	}

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
