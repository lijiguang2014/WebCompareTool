package com.sfit.comparetool.service;

import java.util.List;
import java.util.Map;

import com.sfit.comparetool.bean.TableBean;
import com.sfit.comparetool.bean.TableElement;
import com.sfit.comparetool.utils.CompareUtils;
import com.sfit.comparetool.utils.ExcelUtils;

public class ExcelCompare {
	
	public static void main(String[] args) throws Exception {
		String newFilePath = "D:\\Working\\CompareTestData\\fumarginEntity.xls";
		String oldFilePath = "D:\\Working\\CompareTestData\\fumarginEntityold.xls";
		String resultFilePath = "D:\\result.xml";
		String reportFilePath = "D:\\report.xml";
		new ExcelCompare().compare(newFilePath, oldFilePath, resultFilePath, reportFilePath);
	}
	
	public void compare(String newFilePath, String oldFilePath, String resultFilePath,
			String reportFilePath) throws Exception {
		ExcelUtils xmlUtils = new ExcelUtils();
		Map<String, String> typeMapping = xmlUtils.getTypeMapping(newFilePath);
		Map<String, TableBean> newTableBeanMap = xmlUtils.getTableBeanMap(newFilePath);
		Map<String, TableBean> oldTableBeanMap = xmlUtils.getTableBeanMap(oldFilePath);
		CompareUtils compareUtils = new CompareUtils();
		List<TableElement> diffResult = compareUtils.diff(newTableBeanMap, oldTableBeanMap);
		compareUtils.recordAndReport(diffResult, resultFilePath, reportFilePath, typeMapping);
	}

	
	
}
