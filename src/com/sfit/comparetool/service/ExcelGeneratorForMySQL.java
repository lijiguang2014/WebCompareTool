package com.sfit.comparetool.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
import com.sfit.comparetool.utils.JdbcUtil;

public class ExcelGeneratorForMySQL implements Generator {
	
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
		new ExcelGeneratorForMySQL().generateEntity(url, username, password, "D:\\fumarginEntity.xls");
	}
	
	public void generateEntity(String url, String username, String password, String resultPath) throws IOException {

		Connection conn = JdbcUtil.getConnection(url, username, password);
		String databaseName = getDatabaseName(url);
		
		File f = new File(resultPath);
		if (f.exists()) {
			f.delete();
		}
		
		FileOutputStream fos = new FileOutputStream(f, true);
	   
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
        
		//开始收集各个表字段的信息
		String tableName = null;
		String domainDescription = null;
		String columnName = null;
		String columnType = null;
		String columnComment = null;
		String typeName = null;
		String iskey = null;
		String notnull = null;
		
		try {
			PreparedStatement tableStatement = conn.prepareStatement(SQL_ALLTABLE);
			tableStatement.setString(1,databaseName);
			ResultSet rs = tableStatement.executeQuery();
			
			int rownum = 0;
			int i = 0;
			while (rs.next()) {
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
				
				tableName = rs.getString("TABLE_NAME");
				domainDescription = rs.getString("TABLE_COMMENT");
				
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
					
					rownum++;
					row = sheet.createRow(rownum);
					createCellAndFillValue(row, 0, columnName);
					createCellAndFillValue(row, 1, typeName);
					createCellAndFillValue(row, 2, columnComment);
					createCellAndFillValue(row, 3, iskey);
					createCellAndFillValue(row, 4, notnull);
					createCellAndFillValue(row, 5, "");
					i++;
				}
				columnRs.close();
				
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
			rs.close();
			tableStatement.close();
			wb.write(fos);
			fos.flush();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (null != fos) {
				fos.close();
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

	private void createCellAndFillValue(Row row, int cellNum, String value) {
		Cell cell = row.createCell(cellNum);
		cell.setCellValue(value);
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
