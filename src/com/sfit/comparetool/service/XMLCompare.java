package com.sfit.comparetool.service;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.sfit.comparetool.bean.AlterElement;
import com.sfit.comparetool.bean.ColumnBean;
import com.sfit.comparetool.bean.IndexBean;
import com.sfit.comparetool.bean.TableBean;
import com.sfit.comparetool.bean.TableElement;

public class XMLCompare {
	
	private static Logger log = Logger.getLogger(XMLCompare.class);
	
	public static void main(String[] args) {
		String newFilePath = "D:\\Working\\CompareTestData\\fumarginEntity1.xml";
		String oldFilePath = "D:\\Working\\CompareTestData\\fumarginEntity.xml";
		String typeFilePath = "D:\\Working\\CompareTestData\\fumarginType.xml";
		String resultFilePath = "D:\\result.xml";
		String reportFilePath = "D:\\report.xml";
		new XMLCompare().compare(newFilePath, oldFilePath, typeFilePath, resultFilePath, reportFilePath);
	}
	
	public void compare(String newFilePath, String oldFilePath,
			String typeFilePath, String resultFilePath,
			String reportFilePath) {
		Map<String, String> typeMapping = getTypeMapping(typeFilePath);
		Map<String, TableBean> newMap = getTableBeanMap(newFilePath, typeMapping);
		Map<String, TableBean> oldMap = getTableBeanMap(oldFilePath, typeMapping);
		List<TableElement> diffResult = diff(newMap, oldMap);
		if (diffResult.size() > 0) {
			recordAndReport(diffResult, resultFilePath, reportFilePath, typeMapping);
		}
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
	
	private Map<String, String> getTypeMapping(String typeFilePath) {
		Map<String, String> map = new HashMap<String, String>();
		BufferedReader br = null;
		try {
			br = new BufferedReader(new InputStreamReader(new FileInputStream(typeFilePath),"GBK"));
			String line = null;
			String type = null;
			String typeAlias = null;
			while (null != (line = br.readLine())) {
				int nb, ne;
				if (line.contains("<VString")) {
					nb = line.indexOf("length") + 8;
					ne = line.indexOf("label")-1;
					type = "VCHAR2(" + line.substring(nb, ne).replace("\"","").replace(" ","")+")";
					typeAlias = line.substring(line.indexOf("typename")+10, line.indexOf("length")-2);
				} else if (line.contains("<String")) {
					nb = line.indexOf("length") + 8;
					ne = line.indexOf("label")-1;
					type = "CHAR(" + line.substring(nb, ne).replace("\"","").replace(" ","")+")";
					typeAlias = line.substring(line.indexOf("typename")+10, line.indexOf("length")-2);
				} else if (line.contains("<Int")) {
					nb = line.indexOf("length")+8;
			        ne = line.indexOf("label")-1;
			        type = "NUMBER("+line.substring(nb, ne).replace("\"","").replace(" ","")+")";
			        typeAlias = line.substring(line.indexOf("typename")+10, line.indexOf("length")-2);
				} else if (line.contains("<Float")) {
					nb = line.indexOf("length")+8;
			        ne = line.indexOf("precision")-1;
			        int ne2e = line.indexOf("label")-1;
			        int ne2b = ne + 11;
			        type = "NUMBER("+line.substring(nb, ne).replace("\"","").replace(" ","")+","+line.substring(ne2b, ne2e).replace("\"","").replace(" ","")+")";
			        typeAlias = line.substring(line.indexOf("typename")+10, line.indexOf("length")-2);
				}
				map.put(typeAlias, type);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != br) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return map;
	}
	
	private Map<String, TableBean> getTableBeanMap(String filePath, Map<String, String> typeAliasMap) {
		Map<String, TableBean> tableBeanMap = new HashMap<String, TableBean>();
		BufferedReader br = null;
		try {
			br = new BufferedReader(
					new InputStreamReader(new FileInputStream(filePath), "GBK"));
			TableBean tableBean = null;
			Map<String, ColumnBean> columnMap = null;
			String line = null;
			while(null != (line=br.readLine())) {
				if (line.contains("<Entity")) {
					tableBean = new TableBean();
					tableBean.setDomainName(getDomainName(line));
					tableBean.setDomainDescription(getDomainDescription(line));
					tableBeanMap.put(tableBean.getDomainName(), tableBean);
				} else if (line.contains("<Field name=\"字段名称\"")) {
					columnMap = tableBean.getColumnMap();
				} else if (line.contains("<Field")) {
					ColumnBean column = new ColumnBean();
					column.setColumnName(getColumnName(line));
					column.setTypeName(getColumnType(line));
					column.setColumnDescription(getColumnDescription(line));
					column.setIsKey(getIskey(line));
					column.setNotNull(getNotnull(line));
					columnMap.put(getColumnName(line), column);
				} 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != br) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return tableBeanMap;
	}

	private String getNotnull(String line) {
		return getAttributeValueInField(line, "notnull");
	}

	private String getIskey(String line) {
		return getAttributeValueInField(line, "iskey");
	}

	private String getColumnDescription(String line) {
		return getAttributeValueInField(line, "description");
	}

	private String getColumnType(String line) {
		return getAttributeValueInField(line, "type");
	}

	private String getColumnName(String line) {
		return getAttributeValueInField(line, "name");
	}

	private String getDomainDescription(String line) {
		return getAttributeValueInEntity(line, "description");
	}

	private String getDomainName(String line) {
		return getAttributeValueInEntity(line, "name");
	}
	
	private String getAttributeValueInEntity (String line, String attributeName) {
		int nb = 0, ne=0;
		if (attributeName.equals("name")) {
			nb = line.indexOf("name") + 6;
			ne = line.indexOf("title") - 2;
		} else if (attributeName.equals("title")) {
			nb = line.indexOf("title") + 7;
			ne = line.indexOf("description") - 2;
		} else if (attributeName.equals("description")) {
			nb = line.indexOf("description") + 13;
			ne = line.indexOf(">")-1;
		}
		return line.substring(nb, ne);
	}
	
	private String getAttributeValueInField (String line, String attributeName) {
		int nb = 0, ne = 0;
		if (attributeName.equals("name")) {
			nb = line.indexOf("name") + 6;
			ne = line.indexOf("type") - 2;
		} else if (attributeName.equals("type")) {
			nb = line.indexOf("type") + 6;
			ne = line.indexOf("label") - 2;
		} else if (attributeName.equals("label")) {
			nb = line.indexOf("label") + 7;
			ne = line.indexOf("description") - 2;
		} else if (attributeName.equals("description")) {
			nb = line.indexOf("description") + 13;
			ne = line.indexOf("iskey") - 2;
		} else if (attributeName.equals("iskey")) {
			nb = line.indexOf("iskey") + 7;
			ne = line.indexOf("notnull") - 2;
		} else if (attributeName.equals("notnull")) {
			nb = line.indexOf("notnull") + 9;
			ne = line.indexOf("/>") - 2;
		}
		return line.substring(nb, ne);
 	}
}
 