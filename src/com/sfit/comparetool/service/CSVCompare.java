package com.sfit.comparetool.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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

public class CSVCompare {
	
	private static Logger log = Logger.getLogger(CSVCompare.class);
	
	private static String oldVersion = "D:\\Working\\testData\\fumarginEntity.csv";
	private static String newVersion = "D:\\Working\\testData\\fumarginEntity1.csv";
	private static String typeMappingFilePath = "D:\\Working\\testData\\fumarginType.csv";
	private static String resultOutput = "D:\\Working\\testData\\compareResult.xml";
	private static String report = "D:\\Working\\testData\\report.txt";
	
	public CSVCompare() {
	}
	
	public static void main(String[] args) throws Exception {
		InputStream oldFile = new FileInputStream(oldVersion);
		InputStream newFile = new FileInputStream(newVersion);
		new CSVCompare().compare(oldFile, newFile, typeMappingFilePath, resultOutput, report);
	}
	
	public void compare(InputStream oldFile, InputStream newFile, String typeMappingFilePath, String resultOutput, String report) {
		boolean isChanged = false;
		try {
			isChanged = new CSVCompare().writeCompareResultIntoFile(oldFile, newFile, typeMappingFilePath, resultOutput, report);
		} catch (Exception e) {
			log.error(e);
		} finally {
			if (!isChanged) {
				File f = new File(resultOutput);
				f.deleteOnExit();
			}
		}
	}
	
	/**
	 * 新旧文件如果不一样，return true, 否则 return false;
	 * 
	 * @param oldFile
	 * @param newFile
	 * @param mappingFilePath
	 * @param resultOutput
	 * @param report
	 * @return
	 * @throws Exception
	 */
	private boolean writeCompareResultIntoFile(InputStream oldFile, InputStream newFile, 
			String mappingFilePath, String resultOutput, String report) throws Exception {
		Map<String, String> typeMapping = getTypeMapping(mappingFilePath);
		
		OutputStreamWriter reportOutput = null;
		OutputStreamWriter fw = null;
		File resultFile = new File(resultOutput);
		boolean isChanged = false; 
		try {
			fw = new OutputStreamWriter(new FileOutputStream(resultFile), "UTF-8");
			reportOutput = new OutputStreamWriter(new FileOutputStream(report), "UTF-8");
			List<TableElement> tableElements = getComapreResult(oldFile, newFile);
			
			fw.append("<Tables>\r\n");
			StringBuilder sb = new StringBuilder();
			StringBuilder reportsb = new StringBuilder();
			for (TableElement tableElement : tableElements) {
				String tableName = tableElement.getTableName();
				if (tableElement.isDrop()) {
					isChanged = true;
					sb.append("\t<Table name=\"" + tableName + "\" isCreate=\"false\" isDrop=\"true\"></Table>\r\n");
					reportsb.append("表" + tableName + "被删除了\r\n");
				} else if (tableElement.isCreate()) {
					isChanged = true;
					sb.append("\t<Table name=\"" + tableName + "\" isCreate=\"true\" isDrop=\"false\" description=\""
																				+ tableElement.getDescription() + "\">\r\n");
					reportsb.append("增加表" + tableName);
					Map<String, ColumnBean> columns = tableElement.getColumns();
					sb.append("\t\t<Columns>\r\n");
					for(String columId : columns.keySet()) {
						ColumnBean columnBean = columns.get(columId);
						String typeName = columnBean.getTypeName();
						sb.append("\t\t\t<Column columnName=\"" + columnBean.getColumnName() + "\" columnType=\""
								+ typeMapping.get(typeName) + "\" originalColumnType=\"" + typeName + "\" label=\"" + columnBean.getColumnDescription() + "\" iskey=\"" + columnBean.getIsKey() + "\" notnull=\""
								+ columnBean.getNotNull() + "\"></Column>\r\n");
					}
					sb.append("\t\t</Columns>\r\n");
					Map<String, DefineIndex> indexes = tableElement.getIndexes();
					generateIndexesElement(sb, reportsb, indexes);
					sb.append("\t</Table>\r\n");
				} else {
					List<String> dropColumns = tableElement.getDropColumns();
					List<ColumnBean> adds = tableElement.getAdds();
					List<AlterElement> alters = tableElement.getAlters();
					List<String> dropIndexes = tableElement.getDropIndexes();
					Map<String, DefineIndex> indexes = tableElement.getIndexes();
					
					if (dropColumns.size() > 0 || adds.size() > 0 || alters.size() > 0) {
						isChanged = true;
						sb.append("\t<Table name=\"" + tableName + "\" isCreate=\"false\" isDrop=\"false\" keyList=\"" + tableElement.getKeyList() + "\"");
						String tableDescription = tableElement.getDescription();
						if (null == tableDescription) {
							tableDescription = "";
						} else {
							reportsb.append("表" + tableName + "注释变更为" + tableDescription + "\r\n");
						}
						sb.append(" changedDescription=\"" + tableDescription + "\">\r\n");
						
						sb.append("\t\t<Drops>\r\n");
						for (String column : dropColumns) {
							sb.append("\t\t\t<Drop type=\"column\" tableName=\"" + tableName + "\" columnName=\"" + column + "\" ></Drop>\r\n");
							reportsb.append("表" + tableName + "中的列" + column + "被删除\r\n");
						}
						for (String index : dropIndexes) {
							sb.append("\t\t\t<Drop type=\"index\" indexName=\"" + index + "\" ></Drop>\r\n");
							reportsb.append("表" + tableName + "中的索引" + index + "被删除\r\n");
						}
						sb.append("\t\t</Drops>\r\n");
						
						sb.append("\t\t<Adds>\r\n");
						for (ColumnBean add : adds) {
							String typeName = add.getTypeName();
							sb.append("\t\t\t<Add columnName=\"" + add.getColumnName() +"\" typeName=\"" + typeName + 
									"\" originalTypeName=\"" + typeName + "\" label=\"" + add.getColumnDescription() + "\" iskey=\"" + add.getIsKey() 
									+ "\" notnull=\"" + add.getNotNull() + "\"></Add>\r\n");
							reportsb.append("增加列" + add.getColumnName() + "\r\n");
						}
						sb.append("\t\t</Adds>\r\n");
						
						sb.append("\t\t<Alters>\r\n");
						String alterType = null;
						for (AlterElement alter : alters) {
							alterType = alter.getType();
							sb.append("\t\t\t<Alter type=\"" + alterType + "\" columnName=\"" + alter.getColumnName() + "\" ");
							if (alterType.equals("columnName")) {
								sb.append(" changedName=\"" + alter.getChangedColumnName() + "\" ");
								reportsb.append("列名" + alter.getColumnName() + "变更成列名" + alter.getChangedColumnName() + "\r\n");
							} else if (alterType.equals("columnType")) {
								String changedTypeName = alter.getChangedTypeName();
								String realChangedTypeName = typeMapping.get(changedTypeName);
								if (null == realChangedTypeName) {
									throw new Exception("别名" + changedTypeName + "没有对应的数据类型！");
								}
								sb.append(" changedTypeName=\"" + typeMapping.get(changedTypeName) + "\" originalChangedTypeName=\""
																								+ changedTypeName + "\"");
								reportsb.append("列" + alter.getColumnName() + "数据类型变更为" + realChangedTypeName + "\r\n");
							} else if (alterType.equals("columnComment")) {
								sb.append(" changedComment=\"" + alter.getChangedComment() + "\" ");
								reportsb.append("列" + alter.getColumnName() + "注释变更为" + alter.getChangedComment() + "\r\n");
							} else if (alterType.equals("columnNotnull")) {
								String notnull = alter.getChangedNotNull();
								sb.append(" changedNotnull=\"" + notnull + "\" ");
								reportsb.append("列" + alter.getColumnName() + "notnull属性变更为" + notnull + "\r\n");
							} 
							sb.append("></Alter>\r\n");
						}
						sb.append("\t\t</Alters>\r\n");
						generateIndexesElement(sb, reportsb, indexes);
						sb.append("\t</Table>\r\n");
					}
				}
				fw.append(sb.toString());
				reportOutput.append(reportsb.toString());
				sb.setLength(0);
				reportsb.setLength(0);
			}
			fw.append("</Tables>");
			fw.flush();
			reportOutput.flush();
		} catch (IOException e1) {
			e1.printStackTrace();
		} finally {
			if (null != fw) {
				fw.close();
			}
			if (null != reportOutput) {
				reportOutput.close();
			}
		}
		return isChanged;
	}
	
	private List<TableElement> getComapreResult(InputStream oldFile, InputStream newFile) {
		Map<String, EntityBean> oldTableBeanMap = getTableBeanMap(oldFile);
		Map<String, EntityBean> newTableBeanMap = getTableBeanMap(newFile);
		
		List<TableElement> tableElements = new ArrayList<TableElement>();
		
		//找出被drop的表
		for(String tableName : oldTableBeanMap.keySet()) {
			if(!newTableBeanMap.containsKey(tableName)) {
				TableElement tableElement = new TableElement();
				tableElement.setTableName(tableName);
				tableElement.setDrop(true);
				tableElements.add(tableElement);
			}
		}
		
		for (String tableName : newTableBeanMap.keySet()) { 
			EntityBean newTableBean = newTableBeanMap.get(tableName);
			if(oldTableBeanMap.containsKey(tableName)) {
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
					} else {
						dropIndexes.add(indexName);
					}
				}
				for (String indexName : newIndexes.keySet()) {
					if (oldIndexes.containsKey(indexName)) {
						DefineIndex newIndex = newIndexes.get(indexName);
						DefineIndex oldIndex = oldIndexes.get(indexName);
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
				String keyList = "";
				List<ColumnBean> adds = new ArrayList<ColumnBean>();
				List<AlterElement> alters = new ArrayList<AlterElement>();
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
							keyList += newColumnBean.getColumnName();
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
				tableElement.setAdds(adds);
				tableElement.setAlters(alters);
				tableElement.setKeyList(keyList);
				if (dropColumns.size() > 0 || alters.size() > 0 
					|| adds.size() > 0 || (tableElement.getDescription() != null)
					|| !keyList.equals("")) {
					tableElements.add(tableElement);
				}
				
			} else {
				TableElement tableElement = new TableElement();
				tableElement.setTableName(newTableBean.getDomainName());
				Map<String, ColumnBean> columnMap = newTableBean.getColumnMap();
				tableElement.setCreate(true);
				tableElement.setColumns(columnMap);
				tableElement.setIndexes(newTableBean.getIndexes());
				tableElements.add(tableElement);
			}
		}
		
		return tableElements;
	}
	
	private void generateIndexesElement(StringBuilder sb, StringBuilder reportsb, Map<String, DefineIndex> indexes) {
		sb.append("\t\t<Index>\r\n");
		for(String indexName : indexes.keySet()) {
			DefineIndex index = indexes.get(indexName);
			sb.append("\t\t\t<defineIndex name=\"" + indexName + "\" unique=\"" + index.getUniqueness() + "\">\r\n");
			for(KeyBean keyBean : index.getKeyList()) {
				sb.append("\t\t\t\t<key name=\"" + keyBean.getName() + "\" order=\"" + keyBean.getOrder() + "\" />\r\n");
			}
			sb.append("\t\t\t</defineIndex>\r\n");
		}
		sb.append("\t\t</Index>\r\n");
	}
	
	private Map<String, String> getTypeMapping(String mappingFilePath) {
		Map<String, String> typeMapping = new HashMap<String, String>();
		try {
			BufferedReader br = new BufferedReader(
									new InputStreamReader(
											new FileInputStream(mappingFilePath), "GBK"));
			String line = null;
			while((line = br.readLine()) != null) {
				String[] split = line.split(",");
				if ("类型名称".equals(split[0])) {
					continue;
				} else {
					if (3 == split.length) {
						int index = line.indexOf("NUMBER");
						String type = line.substring(index, line.indexOf(")")+1);
						typeMapping.put(split[0], type);
					} else {
						typeMapping.put(split[0], split[1]);
					}
				}
			}
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return typeMapping;
	}

	/**
	 * 从csv文件读取接口数据信息到Map中
	 * 
	 * @param fileName
	 * @return
	 */
	private Map<String, EntityBean> getTableBeanMap(InputStream inputStream) {
		Map<String, EntityBean> map = new HashMap<String, EntityBean>();
		BufferedReader br = null;
		try {
			br = new BufferedReader(new InputStreamReader(inputStream, "GBK"));
			String line = null;
			boolean startIndex = false;
			EntityBean tableBean = null;
			while((line = br.readLine()) != null) {
				if(isBlankLine(line)) {
					startIndex = false;
					continue;
				} else {
					String[] cols = line.split(",");
					if ("编号".equals(cols[0])) {
						tableBean = new EntityBean();
						tableBean.setId(cols[1]);
						map.put(tableBean.getId(), tableBean);
						continue;
					} else if ("域名称".equals(cols[0])) {
						tableBean.setDomainName(cols[1]);
					} else if ("域说明".equals(cols[0])) {
						if (1 == cols.length) {
							tableBean.setDomainDescription("");
						} else {
							tableBean.setDomainDescription(cols[1]);
						}
					} else if ("备注".equals(cols[0])) {
						tableBean.setMarkup(cols[1]);
					} else if ("索引名".equals(cols[0])) {
						startIndex = true;
					} else if ("字段名称".equals(cols[0])) {
						continue;
					} else {
						if (startIndex) {
							Map<String, DefineIndex> indexes = tableBean.getIndexes();
							
							if (indexes.containsKey(cols[0])) {
								DefineIndex index = indexes.get(cols[0]);
								if (cols.length == 4) {
									index.setUniqueness(cols[3]);
								} else {
									index.setUniqueness("no");
								}
								KeyBean keyBean = new KeyBean();
								keyBean.setName(cols[1]);
								keyBean.setOrder(cols[2]);
								index.getKeyList().add(keyBean);
							} else {
								DefineIndex index = new DefineIndex();
								if (cols.length == 4) {
									index.setUniqueness(cols[3]);
								}
								KeyBean keyBean = new KeyBean();
								keyBean.setName(cols[1]);
								keyBean.setOrder(cols[2]);
								index.getKeyList().add(keyBean);
								indexes.put(cols[0], index);
							}
						} else {
							ColumnBean col = new ColumnBean();
							col.setColumnName(cols[0]);
							col.setTypeName(cols[1]);
							col.setColumnDescription(cols[2]);
							col.setIsKey(cols[3]);
							col.setNotNull(cols[4]);
							if(cols.length==6) {
								col.setMarkup(cols[5]);
							}
							tableBean.getColumnMap().put(cols[0], col);
						}
					}
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
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
	
	private boolean isBlankLine(String line) {
		String[] split = line.split(",");
		for(String s : split) {
			if (!("".equals(s))) {
				return false;
			}
		}
		return true;
	}
	
}
