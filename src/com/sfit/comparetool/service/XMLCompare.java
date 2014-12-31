package com.sfit.comparetool.service;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sfit.comparetool.bean.ColumnBean;
import com.sfit.comparetool.bean.EntityBean;
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
		new XMLCompare().compare(newFilePath, oldFilePath, typeFilePath, resultFilePath, reportFilePath);
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
			throw new Exception("合并过程中出错了！");
		}
	}
	
	public void compare(String newFilePath, String oldFilePath,
			String typeFilePath, String resultFilePath,
			String reportFilePath) {
		Map<String, String> typeMapping = getTypeMapping(typeFilePath);
		Map<String, EntityBean> newMap = getTableBeanMap(newFilePath, typeMapping);
		Map<String, EntityBean> oldMap = getTableBeanMap(oldFilePath, typeMapping);
		CompareUtils compareUtils = new CompareUtils();
		List<TableElement> diffResult = compareUtils.diff(newMap, oldMap);
		if (diffResult.size() > 0) {
			compareUtils.recordAndReport(diffResult, resultFilePath, reportFilePath, typeMapping);
		}
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
	
	private Map<String, EntityBean> getTableBeanMap(String filePath, Map<String, String> typeAliasMap) {
		Map<String, EntityBean> tableBeanMap = new HashMap<String, EntityBean>();
		BufferedReader br = null;
		try {
			br = new BufferedReader(
					new InputStreamReader(new FileInputStream(filePath), "GBK"));
			EntityBean tableBean = null;
			Map<String, ColumnBean> columnMap = null;
			String line = null;
			while(null != (line=br.readLine())) {
				if (line.contains("<Entity")) {
					tableBean = new EntityBean();
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
 