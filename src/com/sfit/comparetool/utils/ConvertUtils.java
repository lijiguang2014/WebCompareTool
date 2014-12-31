package com.sfit.comparetool.utils;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import com.sfit.comparetool.bean.ColumnBean;
import com.sfit.comparetool.bean.DefineIndex;
import com.sfit.comparetool.bean.KeyBean;
import com.sfit.comparetool.bean.EntityBean;

public class ConvertUtils {
	
	public static void main(String[] args) {
		ExcelUtils excelUtils = new ExcelUtils();
		try {
			Map<String, EntityBean> tableBeanMap = excelUtils.getTableBeanMap("D:\\fumarginEntity.xls");
			Map<String, String> typeMapping = excelUtils.getTypeMapping("D:\\fumarginEntity.xls");
			ConvertUtils convertUtils = new ConvertUtils();
			convertUtils.generateEntityXMLFromExcel(tableBeanMap, "D:/Entity.xml");
			convertUtils.generateFrameworkXML(tableBeanMap, "D:/framework.xml");
			convertUtils.generateTypeMappingXMLFromExcel(typeMapping, "D:/type.xml");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void generateFrameworkXML(Map<String, EntityBean> tableBeanMap, String destFilePath) {
		try {
			OutputStreamWriter fw = new OutputStreamWriter(new FileOutputStream(destFilePath), "gb2312");
			fw.append("<?xml version=\"1.0\" encoding=\"gb2312\"?>\r\n");
			fw.append("<!DOCTYPE DB SYSTEM \"DB.dtd\">\r\n");
			fw.append("<DB author=\"UApp\" version=\"1\" iskey=\"no\" notnull=\"no\" order=\"asc\" unique=\"no\">\r\n");
			fw.append("\t<schemas />\r\n");
			fw.append("\t<tableGroups>\r\n");
			fw.append("\t\t<tables group=\"Framework\">\r\n");
			EntityBean tableBean = null;
			String description = null;
			Map<String, DefineIndex> indexes = null;
			DefineIndex defineIndex = null;
			List<KeyBean> keyList = null;
			for(String tableName : tableBeanMap.keySet()) {
				tableBean = tableBeanMap.get(tableName);
				description = tableBean.getDomainDescription();
				fw.append("\t\t\t<table name=\"" + tableName +"\" title=\"" + description + "\" description=\"" + description + "\">\r\n");
				fw.append("\t\t\t\t<Columns ref=\"" + tableName + "\" />\r\n");
				fw.append("\t\t\t\t<Index>\r\n");
				indexes = tableBean.getIndexes();
				for(String indexName : indexes.keySet()) {
					defineIndex = indexes.get(indexName);
					fw.append("\t\t\t\t\t<defineIndex name=\"" + indexName + "\" unique=\"" + defineIndex.getUniqueness() + "\">\r\n");
					keyList = defineIndex.getKeyList();
					for(KeyBean keyBean : keyList) {
						fw.append("\t\t\t\t\t\t<key name=\"" + keyBean.getName() + "\" order=\"" + keyBean.getOrder() + "\"/>\r\n");
					}
					fw.append("\t\t\t\t\t</defineIndex>\r\n");
				}
				fw.append("\t\t\t\t</Index>\r\n");
				fw.append("\t\t\t</table>\r\n");
			}
			fw.append("\t\t</tables>\r\n");
			fw.append("\t</tableGroups>\r\n");
			fw.append("\t<entities />\r\n");
			fw.append("</DB>\r\n");
			fw.flush();
			fw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void generateEntityXMLFromExcel(Map<String, EntityBean> tableBeanMap, String destFilePath) {
		try {
			OutputStreamWriter fw = new OutputStreamWriter(new FileOutputStream(destFilePath), "gb2312");
			fw.append("<?xml version=\"1.0\" encoding=\"GB2312\"?>\r\n");
			fw.append("<!DOCTYPE UFEntityModel SYSTEM \"UFEntity.dtd\">\r\n");
			fw.append("<UFEntityModel>\r\n");
			StringBuilder sb = new StringBuilder();
			EntityBean tableBean = null;
			ColumnBean columnBean = null;
			for(String tableName : tableBeanMap.keySet()) {
				tableBean = tableBeanMap.get(tableName);
				sb.append("\t\t<Entity name=\"" + tableName + "\" title=\"" + tableBean.getDomainDescription() + "\" description=\"" + tableBean.getDomainDescription() + "\">\r\n");
				Map<String, ColumnBean> columnMap = tableBean.getColumnMap();
				for (String columnName : columnMap.keySet()) {
					columnBean = columnMap.get(columnName);
					sb.append("\t\t\t<Field name=\"" + columnName + "\" type=\"" + columnBean.getAlias()
							+ "\" label=\"" + columnBean.getColumnDescription() + "\" description=\"" + columnBean.getColumnDescription() 
							+ "\" iskey=\"" + columnBean.getIsKey() + "\" notnull=\"" + columnBean.getNotNull() + "\" />\r\n");
				}
				sb.append("\t\t</Entity>\r\n");
				fw.append(sb.toString());
				fw.flush();
				sb.setLength(0);
			}
			fw.append("</UFEntityModel>");
			fw.flush();
			fw.close();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void generateTypeMappingXMLFromExcel(Map<String, String> typeMapping, String destFilePath) {
		try {
			OutputStreamWriter fw = new OutputStreamWriter(new FileOutputStream(destFilePath), "gb2312");
			fw.append("<?xml version=\"1.0\" encoding=\"gb2312\"?>\r\n");
			fw.append("<!DOCTYPE UFDataTypes SYSTEM \"UFDataType.dtd\">\r\n");
			fw.append("<UFDataTypes>\r\n");
			StringBuilder sb = new StringBuilder();
			for(String alias: typeMapping.keySet()) {
				String type = typeMapping.get(alias);
				if (type.toUpperCase().startsWith("CHAR")) {
					sb.append("\t<String typename=\""+ alias + "\" length=\"" 
				+ type.substring(type.indexOf("(")+1, type.indexOf(")"))
				+ "\" label=\"\" />\r\n");
				} else if (type.toUpperCase().startsWith("VARCHAR2")) {
					sb.append("\t<VString typename=\""+ alias + "\" length=\"" 
							+ type.substring(type.indexOf("(")+1, type.indexOf(")"))
							+ "\" label=\"\" />\r\n");
				} else if (type.toUpperCase().startsWith("NUMBER")) {
					if(!type.contains(",")) {
						sb.append("\t<Int typename=\"" + alias + "\" length=\""
								+ type.substring(type.indexOf("(")+1, type.indexOf(")"))
								+ "\" label=\"\" />\r\n");
					} else {
						sb.append("\t<Float typename=\"" + alias + "\" length=\""
								+ type.substring(type.indexOf("(")+1, type.indexOf(",")) 
								+ "\" precision=\"" + type.substring(type.indexOf(",")+1, type.indexOf(")"))
								+ "\" label=\"\" />\r\n");
					}
				}
				fw.append(sb.toString());
				sb.setLength(0);
			}
			fw.append("</UFDataTypes>\r\n");
			fw.flush();
			fw.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
}
