package com.sfit.comparetool.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.sfit.comparetool.bean.ColumnBean;
import com.sfit.comparetool.bean.DefineIndex;
import com.sfit.comparetool.bean.KeyBean;
import com.sfit.comparetool.bean.EntityBean;

public class ExcelUtils {
	/**
	 * 读取Excel文件，生成TableBean的Map
	 * 
	 * @param newFilePath
	 * @return
	 * @throws IOException
	 */
	public Map<String, EntityBean> getTableBeanMap(String newFilePath) throws IOException {
		String[] ss = newFilePath.split("\\\\");
		String fileName = ss[ss.length-1];
		String extension = fileName.lastIndexOf(".") == -1 ? "" : fileName
				.substring(fileName.lastIndexOf(".") + 1);
		File file = new File(newFilePath);
		if ("xls".equals(extension)) {
			return readTableBeanMapFrom2003Excel(file);
		} else if ("xlsx".equals(extension)) {
			return readTableBeanMapFrom2007Excel(file);
		} else {
			throw new IOException("不支持的文件类型");
		}
	}

	private Map<String, EntityBean> readTableBeanMapFrom2007Excel(File file) {
		
		Map<String, EntityBean> tableBeanMap = new LinkedHashMap<String, EntityBean>();
		
		try {
			XSSFWorkbook hwb = new XSSFWorkbook(new FileInputStream(file));
			XSSFSheet sheet = hwb.getSheet("fumarginEntity");
			readTableBeanMap(sheet, tableBeanMap);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return tableBeanMap;
	}

	private Map<String, EntityBean> readTableBeanMapFrom2003Excel(File file) {
		
		Map<String, EntityBean> tableBeanMap = new LinkedHashMap<String, EntityBean>();
		
		try {
			HSSFWorkbook hwb = new HSSFWorkbook(new FileInputStream(file));
			HSSFSheet sheet = hwb.getSheet("fumarginEntity");
			readTableBeanMap(sheet, tableBeanMap);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return tableBeanMap;
	}

	private void readTableBeanMap(Sheet sheet, Map<String, EntityBean> tableBeanMap) {
		Row row = null;
		Cell cell = null;
		int counter = 0;
		EntityBean tableBean = null;
		List<String> cellValueList = new ArrayList<String>();
		boolean startIndex = false;//指示某一行开始是索引列的信息
		for (int i = sheet.getFirstRowNum(); counter < sheet.getPhysicalNumberOfRows(); i++) {
			row = sheet.getRow(i);
			if (null == row) {
				continue;
			} else {
				counter++;
			}
			
			for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++) {
				cell = row.getCell(j);
				if (null == cell) {
					cellValueList.add(""); 
					continue;
				}
				String cellValue = getCellValue(cell);
				cellValueList.add(cellValue);
			}
			
			if (cellValueList.size() > 0) {
				String firstValue = cellValueList.get(0);
				if (firstValue.equals("编号")) {
					startIndex = false;
					tableBean = new EntityBean();
				} else if (firstValue.equals("域名称")) {
					tableBean.setDomainName(cellValueList.get(1));
					tableBeanMap.put(cellValueList.get(1), tableBean);
				} else if (firstValue.equals("域说明")) {
					String domainDescription = "";
					if (cellValueList.size() == 2) {
						domainDescription = cellValueList.get(1);
					}
					tableBean.setDomainDescription(domainDescription);
				} else if (firstValue.equals("备注")) {
					tableBean.setMarkup(cellValueList.get(1));
				} else if ("索引名".equals(firstValue)) {
					startIndex = true;
					cellValueList.clear();
					continue;
				} else if (firstValue.equals("字段名称")||firstValue.equals("")) {
					cellValueList.clear();
					continue;
				} else {
					if(startIndex) {
						Map<String, DefineIndex> indexes = tableBean.getIndexes();
						if (indexes.containsKey(cellValueList.get(0))) {
							DefineIndex index = indexes.get(cellValueList.get(0));
							if (cellValueList.size() == 4) {
								index.setUniqueness(cellValueList.get(3));
							} else {
								index.setUniqueness("no");
							}
							KeyBean keyBean = new KeyBean();
							keyBean.setName(cellValueList.get(1));
							keyBean.setOrder(cellValueList.get(2));
							index.getKeyList().add(keyBean);
						} else {
							DefineIndex index = new DefineIndex();
							index.setName(cellValueList.get(0));
							if (cellValueList.size() == 4) {
								index.setUniqueness(cellValueList.get(3));
							} else {
								index.setUniqueness("no");
							}
							KeyBean keyBean = new KeyBean();
							keyBean.setName(cellValueList.get(1));
							keyBean.setOrder(cellValueList.get(2));
							index.getKeyList().add(keyBean);
							indexes.put(cellValueList.get(0), index);
						}
					} else {
						ColumnBean column = new ColumnBean();
						column.setColumnName(cellValueList.get(0));
						column.setTypeName(cellValueList.get(1));
						column.setColumnDescription(cellValueList.get(2));
						column.setIsKey(cellValueList.get(3));
						column.setNotNull(cellValueList.get(4));
						if(cellValueList.size() == 6) {
							column.setMarkup(cellValueList.get(5));
						}
						tableBean.getColumnMap().put(column.getColumnName(), column);
					}
				}
				cellValueList.clear();
			}
		}
	}
	
	public Map<String, String> getTypeMapping(String typeFilePath) throws IOException {
		String[] ss = typeFilePath.split("\\\\");
		String fileName = ss[ss.length-1];
		String extension = fileName.lastIndexOf(".") == -1 ? "" : fileName
				.substring(fileName.lastIndexOf(".") + 1);
		File file = new File(typeFilePath);
		if ("xls".equals(extension)) {
			return readTypeMappingFrom2003Excel(file);
		} else if ("xlsx".equals(extension)) {
			return readTypeMappingFrom2007Excel(file);
		} else {
			throw new IOException("不支持的文件类型");
		}
	}

	private Map<String, String> readTypeMappingFrom2003Excel(File file) {
		
		Map<String, String> typeMapping = new HashMap<String, String>();
		
		try {
			HSSFWorkbook hwb = new HSSFWorkbook(new FileInputStream(file));
			HSSFSheet sheet = hwb.getSheet("fumarginType");
			readTypeMapping(sheet, typeMapping);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return typeMapping;
	}
	
	private Map<String, String> readTypeMappingFrom2007Excel(File file) {
		
		Map<String, String> typeMapping = new HashMap<String, String>();
		
		try {
			XSSFWorkbook hwb = new XSSFWorkbook(new FileInputStream(file));
			XSSFSheet sheet = hwb.getSheet("fumarginType");
			readTypeMapping(sheet, typeMapping);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return typeMapping;
	}

	
	/**
	 * @param sheet
	 * @param typeMapping
	 */
	private void readTypeMapping(Sheet sheet, Map<String, String> typeMapping) {
		Row row = null;
		Cell cell = null;
		int counter = 0;
		for (int i = sheet.getFirstRowNum()+1; 
				counter < sheet.getPhysicalNumberOfRows()-1; i++) {
			row = sheet.getRow(i);
			if (null == row) {
				continue;
			} else {
				counter++;
			}
			
			String alias = null;
			String type = null;
			for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++){
				cell = row.getCell(j);
				if (null == cell) {
					continue;
				}
				String cellValue = getCellValue(cell);
				if (0 == j) {
					alias = cellValue;
				} else if (1 == j) {
					type = cellValue;
				} else {
					continue;
				}
			}
			typeMapping.put(alias, type);
		}
	}
	
	private String getCellValue(Cell cell) {
		String value = null;
		DecimalFormat df = new DecimalFormat("0");// 格式化 number String 字符
		SimpleDateFormat sdf = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
		DecimalFormat nf = new DecimalFormat("0.00");
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_STRING:
			value = cell.getStringCellValue();
			break;
		case Cell.CELL_TYPE_NUMERIC:
			if ("@".equals(cell.getCellStyle().getDataFormatString())) {
				value = df.format(cell.getNumericCellValue());
			} else if ("General".equals(cell.getCellStyle()
					.getDataFormatString())) {
				value = nf.format(cell.getNumericCellValue());
			} else {
				value = sdf.format(HSSFDateUtil.getJavaDate(cell
						.getNumericCellValue()));
			}
			break;
		case Cell.CELL_TYPE_BOOLEAN:
			value = String.valueOf(cell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_BLANK:
			value = "";
			break;
		default:
			value = cell.toString();
		}
		return value;
	}
}
