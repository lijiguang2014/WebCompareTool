package com.sfit.comparetool.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import com.sfit.comparetool.bean.IndexBean;
import com.sfit.comparetool.service.i.Generator;
import com.sfit.comparetool.utils.GenerateUtils;
import com.sfit.comparetool.utils.JdbcUtil;

public class ExcelGenerator implements Generator {
	
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
		new ExcelGenerator().generateEntity(url, username, password, "D:\\fumarginEntity.xls");
//		new ExcelGenerator().generateExcelType(url, username, password, "D:\\fumarginEntity.xls");
	}
	
	public void generateExcelType(String url, String username, String password, String resultPath) throws Exception {
		
		try {
			GenerateUtils generateUtils = new GenerateUtils();
			Map<String, String> typeMap = generateUtils.generateTypeMap(url, username, password);
			
			FileInputStream fis = new FileInputStream(resultPath);
			HSSFWorkbook wb = new HSSFWorkbook(fis);
			HSSFSheet sheet = wb.createSheet("TypeMapping");
			
			int rownum = 0;
			for(String alias : typeMap.keySet()) {
				String type = typeMap.get(alias);
				
				HSSFRow row = sheet.createRow(rownum);
				createCellAndFillValue(row, 0, alias);
				createCellAndFillValue(row, 1, type);
				rownum++;
			}
			fis.close();
			
			FileOutputStream fos = new FileOutputStream(resultPath);
			wb.write(fos);
			fos.flush();
			fos.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("导出Excel格式的TYPE文件中出错!" + e);
		}
	}
	
	public void generateEntity(String url, String username, String password, String resultPath) throws Exception {

		Connection conn = JdbcUtil.getConnection(url, username, password);
		FileOutputStream fos = null;
		try {
			Statement statement = conn.createStatement();
			ResultSet rs = statement.executeQuery(SQL_ALLTABLE);
			recordTableName(rs);
			rs.close();
			statement.close();
			
			String tableStr = "";
			for(String table: tableNameList) {
				tableStr += table;
			}
			System.out.println(tableStr);
			
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
			
			File f = new File(resultPath);
			if (f.exists()) {
				f.delete();
			}
			
			fos = new FileOutputStream(f, true);
		   
			//创建excel文件对象  
            HSSFWorkbook wb = new HSSFWorkbook();
            HSSFSheet sheet = wb.createSheet("fumarginEntity");
            HSSFCellStyle style = wb.createCellStyle();
            
            //生成一个字体
            HSSFFont font=wb.createFont();
            font.setColor(HSSFColor.BLACK.index);//HSSFColor.VIOLET.index //字体颜色
            font.setFontHeightInPoints((short)12);
            font.setFontName("宋体");
           //把字体应用到当前的样式
            style.setFont(font);
            
            int rownum = 0;
			for (int i = 0; i < tableNameList.size(); i++) {
				tableName = tableNameList.get(i);
				System.out.println(tableName);
				domainDescription = getDomainDescription(getTableComment, tableName);

				HSSFRow row = sheet.createRow(rownum);
				createCellAndFillValue(row, 0, "编号");
				Cell cell = row.createCell(1);
				cell.setCellValue(i);
				
				rownum++;
				row = sheet.createRow(rownum);
				createCellAndFillValue(row, 0, "域名称");
				createCellAndFillValue(row, 1, tableName);
				
				rownum++;
				row = sheet.createRow(rownum);
				createCellAndFillValue(row, 0, "域说明");
				createCellAndFillValue(row, 1, domainDescription);
				
				rownum++;
				row = sheet.createRow(rownum);
				createCellAndFillValue(row, 0, "备注");
				createCellAndFillValue(row, 1, "来自核对系统");
				
				rownum++;
				row = sheet.createRow(rownum);
				String[] columnHeader = new String[]{"字段名称", "类型名称", "字段说明","iskey", "notnull", "备注"};
				for (int j = 0; j < 6; j++) {
					createCellAndFillValue(row, j, columnHeader[j]);
				}
				
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
					
					rownum++;
					row = sheet.createRow(rownum);
					createCellAndFillValue(row, 0, columnName);
					createCellAndFillValue(row, 1, typeName);
					createCellAndFillValue(row, 2, fieldDescription);
					createCellAndFillValue(row, 3, isKey);
					createCellAndFillValue(row, 4, notnull);
					createCellAndFillValue(row, 5, "");
				}
				columnInfo.close();
				
				if (indexList.size() > 0) {
					rownum++;
					row = sheet.createRow(rownum);
					String[] indexHeader = new String[]{"索引名", "列名", "descend", "uniqueness"};
					for (int l = 0; l < 4; l++) {
						createCellAndFillValue(row, l, indexHeader[l]);
					}
					for (IndexBean index : indexList) {
						rownum++;
						row = sheet.createRow(rownum);
						createCellAndFillValue(row, 0, index.getIndexName());
						createCellAndFillValue(row, 1, index.getColumnName());
						createCellAndFillValue(row, 2, index.getDescend());
						createCellAndFillValue(row, 3, index.getUniqueness());
					}
				}
				
				rownum++;
				sheet.createRow(rownum);
				rownum++;
				sheet.createRow(rownum);
			}
			wb.write(fos);
			prepareStatement.close();
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
			if (null != fos) {
				fos.close();
			}
		}
	}
	
	/**
	 * 
	 * @param row 
	 * @param cellNum 列序号
	 * @param value   列中单元格的值
	 */
	private void createCellAndFillValue(Row row, int cellNum, String value) {
		Cell cell = row.createCell(cellNum);
		cell.setCellValue(value);
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
	
	/**
	 * 从表colums_type获取数据类型对应的别名
	 * 
	 * @param getTypeName
	 * @param fieldType
	 * @return
	 * @throws SQLException
	 */
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
