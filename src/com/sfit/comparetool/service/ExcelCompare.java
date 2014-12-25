package com.sfit.comparetool.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.sfit.comparetool.bean.AlterElement;
import com.sfit.comparetool.bean.ColumnBean;
import com.sfit.comparetool.bean.IndexBean;
import com.sfit.comparetool.bean.TableBean;
import com.sfit.comparetool.bean.TableElement;

public class ExcelCompare {
	
	private Logger log = Logger.getLogger(ExcelCompare.class);
	
	public static void main(String[] args) throws Exception {
		String newFilePath = "D:\\Working\\CompareTestData\\fumarginEntity.xls";
		String oldFilePath = "D:\\Working\\CompareTestData\\fumarginEntityold.xls";
		String resultFilePath = "D:\\result.xml";
		String reportFilePath = "D:\\report.xml";
		new ExcelCompare().compare(newFilePath, oldFilePath, resultFilePath, reportFilePath);
	}
	
	public void compare(String newFilePath, String oldFilePath, String resultFilePath,
			String reportFilePath) throws Exception {
		Map<String, String> typeMapping = getTypeMapping(newFilePath);
		Map<String, TableBean> newTableBeanMap = getTableBeanMap(newFilePath);
		Map<String, TableBean> oldTableBeanMap = getTableBeanMap(oldFilePath);
		List<TableElement> diffResult = diff(newTableBeanMap, oldTableBeanMap);
		recordAndReport(diffResult, resultFilePath, reportFilePath, typeMapping);
	}

	/**
	 * 生成报告和xml结果文件
	 * 
	 * @param tableElements
	 * @param resultFilePath
	 * @param reportFilePath
	 * @param typeAliasMapping
	 */
	private void recordAndReport(List<TableElement> tableElements,
			String resultFilePath, String reportFilePath, Map<String, String> typeAliasMapping) {
		OutputStreamWriter resultWriter = null;
		OutputStreamWriter reportWriter = null;
		
		try {
			resultWriter = new OutputStreamWriter(new FileOutputStream(resultFilePath), "UTF-8");
			reportWriter = new OutputStreamWriter(new FileOutputStream(reportFilePath), "UTF-8");
			
			StringBuilder resultSb = new StringBuilder();
			StringBuilder reportSb = new StringBuilder();
			resultSb.append("<Tables>\r\n");
			for (TableElement tableElement : tableElements) {

				String tableName = tableElement.getTableName();
				if (tableElement.isDrop()) {
					resultSb.append("\t<Table name=\"" + tableName + "\" isCreate=\"false\" isDrop=\"true\" ></Table>\r\n");
					reportSb.append("表" + tableName + "被删除了\r\n");
				} else if (tableElement.isCreate()) {
					resultSb.append("\t<Table name=\"" + tableName + "\" isCreate=\"true\" isDrop=\"false\" description=\""
																				+ tableElement.getDescription() + "\" >\r\n");
					reportSb.append("增加表" + tableName);
					Map<String, ColumnBean> columns = tableElement.getColumns();
					resultSb.append("\t\t<Columns>\r\n");
					for(String columnName : columns.keySet()) {
						ColumnBean columnBean = columns.get(columnName);
						String typeName = columnBean.getTypeName();
						String realTypeName = typeAliasMapping.get(typeName);
						if (null == realTypeName) {
							realTypeName = "";
							String errorMsg = "表" + tableName+"中的列" + columnName + "的类型别名" + typeName + "没有对应的数据类型！";
							log.error(errorMsg);
//							throw new Exception(errorMsg);
						}
						resultSb.append("\t\t\t<Column columnName=\"" + columnBean.getColumnName() + "\" columnType=\""
								+ realTypeName + "\" originalColumnType=\"" + typeName + "\" label=\"" + columnBean.getColumnDescription() + "\" iskey=\"" + columnBean.getIsKey() + "\" notnull=\""
								+ columnBean.getNotNull() + "\"></Column>\r\n");
					}
					resultSb.append("\t\t</Columns>\r\n");
					Map<String, List<IndexBean>> indexes = tableElement.getIndexes();
					generateIndexesElement(resultSb, reportSb, indexes);
					resultSb.append("\t\t</Index>\r\n");
					resultSb.append("\t</Table>\r\n");
				} else {
					List<String> dropColumns = tableElement.getDropColumns();
					List<ColumnBean> adds = tableElement.getAdds();
					List<AlterElement> alters = tableElement.getAlters();
					List<String> dropIndexes = tableElement.getDropIndexes();
					Map<String, List<IndexBean>> indexes = tableElement.getIndexes();
					
					if (dropColumns.size() > 0 || adds.size() > 0 || alters.size() > 0) {
						resultSb.append("\t<Table name=\"" + tableName + "\" isCreate=\"false\" isDrop=\"false\" keyList=\"" + tableElement.getKeyList() + "\"");
						String tableDescription = tableElement.getDescription();
						if (null == tableDescription) {
							tableDescription = "";
						} else {
							reportSb.append("表" + tableName + "注释变更为" + tableDescription + "\r\n");
						}
						resultSb.append(" changedDescription=\"" + tableDescription + "\">\r\n");
						resultSb.append("\t\t<Drops>\r\n");
						for (String column : dropColumns) {
							resultSb.append("\t\t\t<Drop type=\"column\" tableName=\"" + tableName + "\" columnName=\"" + column + "\" ></Drop>\r\n");
							reportSb.append("表" + tableName + "中的列" + column + "被删除\r\n");
						}
						for (String index : dropIndexes) {
							resultSb.append("\t\t\t<Drop type=\"index\" indexName=\"" + index + "\" ></Drop>\r\n");
							reportSb.append("表" + tableName + "中的索引" + index + "被删除\r\n");
						}
						if(tableElement.isDropPrimaryKey()) {
							resultSb.append("\t\t\t<Drop type=\"primaryKey\" constraintName=\"PK_" + tableName + "\" ></Drop>\r\n");
							reportSb.append("表" + tableName + "中的主键约束PK_" + tableName + "已经发生变化\r\n");
						}
						resultSb.append("\t\t</Drops>\r\n");
						
						resultSb.append("\t\t<Adds>\r\n");
						for (ColumnBean add : adds) {
							String typeName = add.getTypeName();
							String realTypeName = typeAliasMapping.get(typeName);
							if (null == realTypeName) {
								realTypeName = "";
								String errorMsg = "表" + tableName+"中的列" + add.getColumnName() + "的类型别名" + typeName + "没有对应的数据类型！";
								log.error(errorMsg);
//								throw new Exception(errorMsg);
							}
							resultSb.append("\t\t\t<Add columnName=\"" + add.getColumnName() +"\" typeName=\"" + realTypeName + 
									"\" originalTypeName=\"" + typeName + "\" label=\"" + add.getColumnDescription() + "\" iskey=\"" + add.getIsKey() 
									+ "\" notnull=\"" + add.getNotNull() + "\"></Add>\r\n");
							reportSb.append("增加列" + add.getColumnName() + "\r\n");
						}
						resultSb.append("\t\t</Adds>\r\n");
						
						resultSb.append("\t\t<Alters>\r\n");
						String alterType = null;
						for (AlterElement alter : alters) {
							alterType = alter.getType();
							resultSb.append("\t\t\t<Alter type=\"" + alterType + "\" columnName=\"" + alter.getColumnName() + "\" ");
							if (alterType.equals("columnName")) {
								resultSb.append(" changedName=\"" + alter.getChangedColumnName() + "\" ");
								reportSb.append("列名" + alter.getColumnName() + "变更成列名" + alter.getChangedColumnName() + "\r\n");
							} else if (alterType.equals("columnType")) {
								String changedTypeName = alter.getChangedTypeName();
								String realChangedTypeName = typeAliasMapping.get(changedTypeName);
								if (null == realChangedTypeName) {
									realChangedTypeName = "";
									String errorMsg = "表" + tableName+"中的列" + alter.getColumnName() + "的类型别名" + changedTypeName + "没有对应的数据类型！";
									log.error(errorMsg);
//									throw new Exception(errorMsg);
								}
								resultSb.append(" changedTypeName=\"" + realChangedTypeName + "\" originalChangedTypeName=\""
																								+ changedTypeName + "\"");
								reportSb.append("列" + alter.getColumnName() + "数据类型变更为" + realChangedTypeName + "\r\n");
							} else if (alterType.equals("columnComment")) {
								resultSb.append(" changedComment=\"" + alter.getChangedComment() + "\" ");
								reportSb.append("列" + alter.getColumnName() + "注释变更为" + alter.getChangedComment() + "\r\n");
							} else if (alterType.equals("columnNotnull")) {
								String notnull = alter.getChangedNotNull();
								resultSb.append(" changedNotnull=\"" + notnull + "\" ");
								reportSb.append("列" + alter.getColumnName() + " notnull属性变更为" + notnull + "\r\n");
							} 
							resultSb.append("></Alter>\r\n");
						}
						resultSb.append("\t\t</Alters>\r\n");
						generateIndexesElement(resultSb, reportSb, indexes);
						resultSb.append("\t</Table>\r\n");
					}
				}
			}
			resultSb.append("</Tables>");
			resultWriter.append(resultSb.toString());
			reportWriter.append(reportSb.toString());
			resultSb.setLength(0);
			reportSb.setLength(0);
			resultWriter.flush();
			reportWriter.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != resultWriter) {
				try {
					resultWriter.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (null != reportWriter) {
				try {
					reportWriter.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	private void generateIndexesElement(StringBuilder sb, StringBuilder reportsb, Map<String, List<IndexBean>> indexes) {
		sb.append("\t\t<Index>\r\n");
		for(String key : indexes.keySet()) {
			sb.append("\t\t\t<defineIndex name=\"" + key + "\">\r\n");
			List<IndexBean> list = indexes.get(key);
			for(IndexBean indexColumn : list) {
				sb.append("\t\t\t\t<key name=\"" + indexColumn.getColumnName() + "\" />\r\n");
			}
			sb.append("\t\t\t</defineIndex>\r\n");
		}
		sb.append("\t\t</Index>\r\n");
	}

	/**
	 * 比较两个TableBean的Map， key是tableName
	 * 
	 * @param newTableBeanMap
	 * @param oldTableBeanMap
	 * @return
	 */
	private List<TableElement> diff(Map<String, TableBean> newTableBeanMap
			, Map<String, TableBean> oldTableBeanMap) {
		
		List<TableElement> tableElements = new ArrayList<TableElement>();
		
		for (String tableName : oldTableBeanMap.keySet()) {
			if (!newTableBeanMap.containsKey(tableName)) {
				TableElement e = new TableElement();
				e.setDrop(true);
				e.setTableName(tableName);
				tableElements.add(e);
			}
		}
		
		for (String tableName : newTableBeanMap.keySet()) {
			TableBean newTableBean = newTableBeanMap.get(tableName);
			if (oldTableBeanMap.containsKey(tableName)) {
				TableBean oldTableBean = oldTableBeanMap.get(tableName);
				
				TableElement tableElement = new TableElement();
				tableElement.setTableName(oldTableBean.getDomainName());
				if (!oldTableBean.getDomainDescription().equals(newTableBean.getDomainDescription())) {
					tableElement.setDescription(newTableBean.getDomainDescription());
				}
				
				//比较索引列
				List<String> dropIndexes = new ArrayList<String>();
				Map<String, List<IndexBean>> changedIndexes = new HashMap<String, List<IndexBean>>();
				
				Map<String, List<IndexBean>> newIndexes = newTableBean.getIndexes();
				Map<String, List<IndexBean>> oldIndexes = oldTableBean.getIndexes();
				for (String indexName : oldIndexes.keySet()) {
					if (newIndexes.containsKey(indexName)) {
						List<IndexBean> newIndexColumns = newIndexes.get(indexName);
						List<IndexBean> oldIndexColumns = oldIndexes.get(indexName);
						for(IndexBean oldIndexColumn : oldIndexColumns) {
							//比对两个索引的索引列是否相等
							boolean flag = false;
							for (IndexBean newIndexColumn : newIndexColumns) {
								if ((!oldIndexColumn.toString().equals(newIndexColumn.toString()))
										&&oldIndexColumn.getColumnName().equals(newIndexColumn.getColumnName())) {
									flag = true;
									break;
								}
							}
							if (flag) {
								dropIndexes.add(indexName);
								break;
							}
						}
					} else {
						dropIndexes.add(indexName);
					}
				}
				for (String index : newIndexes.keySet()) {
					if (oldIndexes.containsKey(index)) {
						List<IndexBean> newIndexColumns = newIndexes.get(index);
						List<IndexBean> oldIndexColumns = oldIndexes.get(index);
						for(IndexBean newIndex : newIndexColumns) {
							boolean flag = false;
							for (IndexBean oldIndex : oldIndexColumns) {
								if ((newIndex.getColumnName().equals(oldIndex.getColumnName()))
										&& (!newIndex.toString().equals(oldIndex.toString()))) {
									flag = true;
									break;
								}
							}
							
							if (flag) {
								//索引列有变化，drop之后重新创建索引
								changedIndexes.put(index, newIndexColumns);
								break;
							}
						}
					} else {
						//增加新的索引
						changedIndexes.put(index, newIndexes.get(index));
					}
				}
				tableElement.setIndexes(changedIndexes);
				tableElement.setDropIndexes(dropIndexes);
				
				Map<String, ColumnBean> newColumnMap = newTableBean.getColumnMap();
				Map<String, ColumnBean> oldColumnMap = oldTableBean.getColumnMap();
				List<String> dropColumns = new ArrayList<String>();
				
				//找出drop的column
				for (String columnId : oldColumnMap.keySet()) {
					ColumnBean oldColumnBean = oldColumnMap.get(columnId);
					if(!newColumnMap.containsKey(columnId)) {
						dropColumns.add(oldColumnBean.getColumnName());
					}
				}
				tableElement.setDropColumns(dropColumns);
				
				//比较新旧版本的column区别
				List<ColumnBean> adds = new ArrayList<ColumnBean>();
				List<AlterElement> alters = new ArrayList<AlterElement>();
				boolean iskeyChanged = false;
				for (String columnName : newColumnMap.keySet()) {
					ColumnBean newColumnBean = newColumnMap.get(columnName);
					if (oldColumnMap.containsKey(columnName)) {
						ColumnBean oldColumnBean = oldColumnMap.get(columnName);
						
						String oldColumnName = oldColumnBean.getColumnName();
						String newColumnName = newColumnBean.getColumnName();
						if (!newColumnName.equals(oldColumnName)) {
							AlterElement alter = new AlterElement();
							alter.setType("columnName");
							alter.setColumnName(oldColumnName);
							alter.setChangedColumnName(newColumnName);
							alters.add(alter);
						}
						
						String oldTypeName = oldColumnBean.getTypeName();
						String newTypeName = newColumnBean.getTypeName();
						if(!newTypeName.equals(oldTypeName)) {
							AlterElement alter = new AlterElement();
							alter.setType("columnType");
							alter.setColumnName(newColumnName);
							alter.setChangedTypeName(newTypeName);
							alters.add(alter);
						}
						
						String oldColumnDescription = oldColumnBean.getColumnDescription();
						String newColumnDescription = newColumnBean.getColumnDescription();
						if(!newColumnDescription.equals(oldColumnDescription)) {
							AlterElement alter = new AlterElement();
							alter.setType("columnComment");
							alter.setColumnName(newColumnName);
							alter.setChangedComment(newColumnDescription);
							alters.add(alter);
						}
						
						String oldIsKey = oldColumnBean.getIsKey();
						String newIsKey = newColumnBean.getIsKey();
						if (!newIsKey.equals(oldIsKey)) {
							iskeyChanged = true;
						}
						
						String oldNotNull = oldColumnBean.getNotNull();
						String newNotNull = newColumnBean.getNotNull();
						if (!newNotNull.equals(oldNotNull)) {
							AlterElement alter = new AlterElement();
							alter.setType("columnNotnull");
							alter.setColumnName(newColumnName);
							alter.setChangedNotNull(newNotNull);
							alters.add(alter);
						}
					} else {
						adds.add(newColumnBean);
					}
				}
				
				String keyList = "";
				if (iskeyChanged) {
					tableElement.setDropPrimaryKey(true);
					for (String columnName : newColumnMap.keySet()) {
						if (newColumnMap.get(columnName).getIsKey().equals("yes")) {
							if (!keyList.equals("")) {
								keyList += ",";
							}
							keyList += columnName;
						}
					}
				}
				
				tableElement.setAdds(adds);
				tableElement.setAlters(alters);
				tableElement.setKeyList(keyList);
				if (dropColumns.size() > 0 || alters.size() > 0 
					|| adds.size() > 0 || (tableElement.getDescription() != null)
					|| !keyList.equals("")) {
					tableElements.add(tableElement);
				}
			} else {
				TableElement e = new TableElement();
				e.setTableName(tableName);
				e.setCreate(true);
				e.setColumns(newTableBean.getColumnMap());
				e.setIndexes(newTableBean.getIndexes());
				tableElements.add(e);
			}
		}
		return tableElements;
	}
	
	/**
	 * 读取Excel文件，生成TableBean的Map
	 * 
	 * @param newFilePath
	 * @return
	 * @throws IOException
	 */
	private Map<String, TableBean> getTableBeanMap(String newFilePath) throws IOException {
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

	private Map<String, TableBean> readTableBeanMapFrom2007Excel(File file) {
		
		Map<String, TableBean> tableBeanMap = new HashMap<String, TableBean>();
		
		try {
			XSSFWorkbook hwb = new XSSFWorkbook(new FileInputStream(file));
			XSSFSheet sheet = hwb.getSheet("fumarginEntity");
			readTableBeanMap(sheet, tableBeanMap);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return tableBeanMap;
	}

	private Map<String, TableBean> readTableBeanMapFrom2003Excel(File file) {
		
		Map<String, TableBean> tableBeanMap = new HashMap<String, TableBean>();
		
		try {
			HSSFWorkbook hwb = new HSSFWorkbook(new FileInputStream(file));
			HSSFSheet sheet = hwb.getSheet("fumarginEntity");
			readTableBeanMap(sheet, tableBeanMap);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return tableBeanMap;
	}

	private void readTableBeanMap(Sheet sheet, Map<String, TableBean> tableBeanMap) {
		Row row = null;
		Cell cell = null;
		int counter = 0;
		TableBean tableBean = null;
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
					tableBean = new TableBean();
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
						Map<String, List<IndexBean>> indexes = tableBean.getIndexes();
						if (indexes.containsKey(cellValueList.get(0))) {
							List<IndexBean> list = indexes.get(cellValueList.get(0));
							IndexBean indexBean = new IndexBean();
							indexBean.setIndexName(cellValueList.get(0));
							indexBean.setColumnName(cellValueList.get(1));
							indexBean.setDescend(cellValueList.get(2));
							if (cellValueList.size() == 4) {
								indexBean.setUniqueness(cellValueList.get(3));
							}
							list.add(indexBean);
						} else {
							List<IndexBean> list = new ArrayList<IndexBean>();
							IndexBean indexBean = new IndexBean();
							indexBean.setIndexName(cellValueList.get(0));
							indexBean.setColumnName(cellValueList.get(1));
							indexBean.setDescend(cellValueList.get(2));
							if (cellValueList.size() == 4) {
								indexBean.setUniqueness(cellValueList.get(3));
							}
							list.add(indexBean);
							indexes.put(cellValueList.get(0), list);
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
	
	private Map<String, String> getTypeMapping(String typeFilePath) throws IOException {
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
