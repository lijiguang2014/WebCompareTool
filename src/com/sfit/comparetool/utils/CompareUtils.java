package com.sfit.comparetool.utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.sfit.comparetool.bean.AlterElement;
import com.sfit.comparetool.bean.ColumnBean;
import com.sfit.comparetool.bean.DefineIndex;
import com.sfit.comparetool.bean.KeyBean;
import com.sfit.comparetool.bean.EntityBean;
import com.sfit.comparetool.bean.TableElement;

public class CompareUtils {
	
	private static Logger log = Logger.getLogger(CompareUtils.class);
	
	/**
	 * 生成报告和xml结果文件
	 * 
	 * @param tableElements
	 * @param resultFilePath
	 * @param reportFilePath
	 * @param typeAliasMapping
	 */
	public void recordAndReport(List<TableElement> tableElements,
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
						String typeName = columnBean.getAlias();
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
					Map<String, DefineIndex> indexes = tableElement.getIndexes();
					generateIndexesElement(resultSb, reportSb, indexes);
					resultSb.append("\t\t</Index>\r\n");
					resultSb.append("\t</Table>\r\n");
				} else {
					List<String> dropColumns = tableElement.getDropColumns();
					List<ColumnBean> adds = tableElement.getAdds();
					List<AlterElement> alters = tableElement.getAlters();
					List<String> dropIndexes = tableElement.getDropIndexes();
					Map<String, DefineIndex> indexes = tableElement.getIndexes();
					
					if (dropColumns.size() > 0 || adds.size() > 0 || alters.size() > 0
							|| dropIndexes.size() > 0 || indexes.size() > 0) {
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
							String typeName = add.getAlias();
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
	
	private void generateIndexesElement(StringBuilder sb, StringBuilder reportsb, Map<String, DefineIndex> indexes) {
		sb.append("\t\t<Index>\r\n");
		for(String indexName : indexes.keySet()) {
			DefineIndex index = indexes.get(indexName);
			sb.append("\t\t\t<defineIndex name=\"" + indexName + "\" unique=\""
					+ index.getUniqueness() + "\">\r\n");
			List<KeyBean> keyList = index.getKeyList();
			for(KeyBean keyBean : keyList) {
				sb.append("\t\t\t\t<key name=\"" + keyBean.getName() + "\" order=\"" + keyBean.getOrder() + "\" />\r\n");
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
	public List<TableElement> diff(Map<String, EntityBean> newTableBeanMap
			, Map<String, EntityBean> oldTableBeanMap) {
		
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
			EntityBean newTableBean = newTableBeanMap.get(tableName);
			if (oldTableBeanMap.containsKey(tableName)) {
				EntityBean oldTableBean = oldTableBeanMap.get(tableName);
				
				TableElement tableElement = new TableElement();
				tableElement.setTableName(oldTableBean.getDomainName());
				if (!oldTableBean.getDomainDescription().equals(newTableBean.getDomainDescription())) {
					tableElement.setDescription(newTableBean.getDomainDescription());
				}
				
				//比较索引列
				List<String> dropIndexes = new ArrayList<String>();
				Map<String, DefineIndex> changedIndexes = new HashMap<String, DefineIndex>();
				
				Map<String, DefineIndex> newIndexes = newTableBean.getIndexes();
				Map<String, DefineIndex> oldIndexes = oldTableBean.getIndexes();
				//找出在新表中drop掉的索引和发生变化的索引
				for (String indexName : oldIndexes.keySet()) {
					if (newIndexes.containsKey(indexName)) {
						DefineIndex newIndex = newIndexes.get(indexName);
						DefineIndex oldIndex = oldIndexes.get(indexName);
						if (!newIndex.getUniqueness().equals(oldIndex.getUniqueness())) {
							dropIndexes.add(indexName);
						} else {
							for(KeyBean oldKeyBean : oldIndex.getKeyList()) {
								//比对两个索引的索引列是否相等
								boolean flag = false;
								for (KeyBean newKeyBean: newIndex.getKeyList()) {
									if ((!oldKeyBean.toString().equals(newKeyBean.toString()))
											&&oldKeyBean.getName().equals(newKeyBean.getName())) {
										flag = true;
										break;
									}
								}
								if (flag) {
									dropIndexes.add(indexName);
									break;
								}
							}
						}
					} else {
						dropIndexes.add(indexName);
					}
				}
				for (String indexName : newIndexes.keySet()) {
					if (oldIndexes.containsKey(indexName)) {
						DefineIndex newIndex = newIndexes.get(indexName);
						DefineIndex oldIndex = oldIndexes.get(indexName);
						if (!newIndex.getUniqueness().equals(oldIndex.getUniqueness())) {
							changedIndexes.put(indexName, newIndex);
						} else {
							for(KeyBean newKeyBean : newIndex.getKeyList()) {
								boolean flag = false;
								for (KeyBean oldKeyBean : oldIndex.getKeyList()) {
									if ((newKeyBean.getName().equals(oldKeyBean.getName()))
											&& (!newKeyBean.toString().equals(oldKeyBean.toString()))) {
										flag = true;
										break;
									}
								}
								
								if (flag) {
									//索引列有变化，drop之后重新创建索引
									changedIndexes.put(indexName, newIndex);
									break;
								}
							}
						}
					} else {
						//增加新的索引
						changedIndexes.put(indexName, newIndexes.get(indexName));
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
						
						String oldTypeName = oldColumnBean.getAlias();
						String newTypeName = newColumnBean.getAlias();
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
				
				if (changedIndexes.size()>0 || dropIndexes.size() > 0 || dropColumns.size() > 0 || alters.size() > 0 
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
}
