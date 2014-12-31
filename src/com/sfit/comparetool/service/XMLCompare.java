package com.sfit.comparetool.service;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.sfit.comparetool.bean.ColumnBean;
import com.sfit.comparetool.bean.EntityBean;
import com.sfit.comparetool.bean.TableBean;
import com.sfit.comparetool.bean.TableElement;
import com.sfit.comparetool.utils.CompareUtils;
import com.sfit.comparetool.utils.ConsoleUtils;

public class XMLCompare {
	
	public static void main(String[] args) {
		String newFilePath = "D:\\Working\\CompareTestData\\fumarginEntity1.xml";
		String oldFilePath = "D:\\Working\\CompareTestData\\fumarginEntity.xml";
		String typeFilePath = "D:\\Working\\CompareTestData\\fumarginType.xml";
		String resultFilePath = "D:\\result.xml";
		String reportFilePath = "D:\\report.xml";
	}
	
	/**
	 * 合并framework,entity,type成一个xml
	 * 
	 * @param frameworkFilePath
	 * @param entityFilePath
	 * @param typeFilePath
	 * @param resultFilePath
	 * @throws Exception
	 */
	public void merge(String frameworkFilePath, String entityFilePath, String typeFilePath, String resultFilePath) throws Exception {
		String shellStr = "cmd /c " + resultFilePath + " " + frameworkFilePath + " " + entityFilePath + " " + typeFilePath;
		boolean success = ConsoleUtils.callShell(shellStr);
		if (!success) {
			throw new Exception("xml文件合并过程中出错了！");
		}
	}
	
	public void compare(String newFilePath, String oldFilePath,String resultFilePath,
			String reportFilePath) {
		Map<String, TableBean> newMap = getTableBeanMap(newFilePath);
		Map<String, TableBean> oldMap = getTableBeanMap(oldFilePath);
		CompareUtils compareUtils = new CompareUtils();
		List<TableElement> diffResult = compareUtils.diff(newMap, oldMap);
		if (diffResult.size() > 0) {
			compareUtils.recordAndReport(diffResult, resultFilePath, reportFilePath);
		}
	}

	private Map<String, TableBean> getTableBeanMap(String filePath) {
		Map<String, TableBean> tableBeanMap = new HashMap<String, TableBean>();
		BufferedReader br = null;
		try {
			br = new BufferedReader(
					new InputStreamReader(new FileInputStream(filePath), "GBK"));
			TableBean tableBean = null;
			EntityBean entityBean = null;
			Map<String, ColumnBean> columnMap = null;
			String line = null;
			while(null != (line=br.readLine())) {
				if (line.contains("<table")) {
					tableBean = new TableBean();
					tableBean.setTablename(getDomainName(line));
					entityBean = new EntityBean();
					entityBean.setDomainName(getDomainName(line));
					entityBean.setDomainDescription(getDomainDescription(line));
					tableBeanMap.put(tableBean.getTablename(), tableBean);
				} else if (line.contains("<Columns>")) {
					columnMap = new LinkedHashMap<String, ColumnBean>();
					entityBean.setColumnMap(columnMap);
				} else if (line.contains("<Column")) {
					ColumnBean column = new ColumnBean();
					column.setColumnName(getColumnName(line));
					column.setType(getColumnType(line));
					column.setAlias(getTypeAlias(line));
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

	private String getTypeAlias(String line) {
		return getAttributeValueInColumn(line, "originaltype");
	}

	private String getNotnull(String line) {
		return getAttributeValueInColumn(line, "notnull");
	}

	private String getIskey(String line) {
		return getAttributeValueInColumn(line, "iskey");
	}

	private String getColumnDescription(String line) {
		return getAttributeValueInColumn(line, "description");
	}

	private String getColumnType(String line) {
		return getAttributeValueInColumn(line, "type");
	}

	private String getColumnName(String line) {
		return getAttributeValueInColumn(line, "name");
	}

	private String getDomainDescription(String line) {
		return getAttributeValueInTable(line, "description");
	}

	private String getDomainName(String line) {
		return getAttributeValueInTable(line, "name");
	}
	
	private String getAttributeValueInTable (String line, String attributeName) {
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
	
	private String getAttributeValueInColumn (String line, String attributeName) {
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
			ne = line.indexOf("notnull") - 2;
		} else if (attributeName.equals("notnull")) {
			ne = line.indexOf("notnull") + 9;
			nb = line.indexOf("iskey") -2;
		} else if (attributeName.equals("iskey")) {
			nb = line.indexOf("iskey") + 7;
			ne = line.indexOf("originaltype") - 2;
		} else if (attributeName.equals("originaltype")) {
			nb = line.indexOf("originaltype") + 12;
			ne = line.indexOf("basetype") - 2;
		}
		
		return line.substring(nb, ne);
 	}
}
 