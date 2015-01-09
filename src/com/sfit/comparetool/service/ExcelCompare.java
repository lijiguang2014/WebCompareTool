package com.sfit.comparetool.service;

import java.util.List;
import java.util.Map;

import com.sfit.comparetool.bean.TableBean;
import com.sfit.comparetool.bean.TableElement;
import com.sfit.comparetool.utils.CompareUtils;
import com.sfit.comparetool.utils.ExcelUtils;

public class ExcelCompare {
	
	public static void main(String[] args) throws Exception {
		String newFilePath = "D:\\Working\\CompareTestData\\fumarginEntity_modify.xls";
		String oldFilePath = "D:\\Working\\CompareTestData\\fumarginEntity_prod.xls";
		String resultFilePath = "D:\\test.xml";
		String reportFilePath = "D:\\report.xml";
		new ExcelCompare().compare(newFilePath, oldFilePath, resultFilePath, reportFilePath);
	}
	
	public void compare(String newFilePath, String oldFilePath, String resultFilePath,
			String reportFilePath) throws Exception {
		ExcelUtils excelUtils = new ExcelUtils();
		Map<String, String> typeMapping = excelUtils.getTypeMapping(newFilePath);
		Map<String, TableBean> newTableBeanMap = excelUtils.getTableBeanMap(newFilePath);
		Map<String, TableBean> oldTableBeanMap = excelUtils.getTableBeanMap(oldFilePath);
		CompareUtils compareUtils = new CompareUtils();
		List<TableElement> diffResult = compareUtils.diff(newTableBeanMap, oldTableBeanMap);
		compareUtils.recordAndReport(diffResult, resultFilePath, reportFilePath, typeMapping);
	}

	
	
}
