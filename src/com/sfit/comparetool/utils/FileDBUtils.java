package com.sfit.comparetool.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sfit.comparetool.bean.CompareHistory;
import com.sfit.comparetool.constants.GlobalConstants;

public class FileDBUtils {
	
	private Map<String, Object> readHistoryFromFile(String filePath) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CompareHistory> historyList= new ArrayList<CompareHistory>();
		
		URL resource = this.getClass().getClassLoader().getResource("/");
		//classes文件夹的路径
		String basePath = resource.toString().substring(6) + "../../";
		
		BufferedReader br = null;
		int total = 0;
		try {
			File f = new File(basePath + filePath);
			if(!f.exists()) {
				return map;
			}
			
			br = new BufferedReader(new InputStreamReader(
					new FileInputStream(basePath + filePath)));
			String line = null;
			while(null != (line=br.readLine())) {
				CompareHistory history = encapsulateToBean(line);
				historyList.add(history);
				total++;
			}
			
			//给记录列表排序，版本号从大到小排列
			int size = historyList.size();
			for (int i = 0; i < (size%2 == 0 ? size/2 : (size/2+1)); i++) {
				CompareHistory temp = historyList.get(i);
				historyList.set(i, historyList.get(size-1-i));
				historyList.set(size-1-i, temp);
			}
			
			map.put(GlobalConstants.TOTAL, total);
			map.put(GlobalConstants.RECORD_LIST, historyList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(null != br) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return map;
	}

	private CompareHistory encapsulateToBean(String line) {
		String[] ss = line.split(",");
		
		CompareHistory history = new CompareHistory();
		history.setVersion(ss[0]);
		history.setCompareDate(ss[1]);
		history.setSrcFilePath(ss[2]);
		history.setTargetFilePath(ss[3]);
		history.setTemplateFilePath(ss[4]);
		history.setAlterSqlFilePath(ss[5]);
		history.setReportFilePath(ss[6]);
		history.setStatus(ss[7]);
		
		return history;
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> pageQuery(String projectName, int pageSize, int pageNum) {
		String filePath = PropertiesUtils.getHistoryPath(projectName);
		Map<String, Object> returnMap = new HashMap<String, Object>();

		Map<String, Object> map = readHistoryFromFile(filePath);
		if(map.size() == 0 || (Integer)map.get(GlobalConstants.TOTAL) == 0) {
			return returnMap;
		}
		
		int total = (Integer) map.get(GlobalConstants.TOTAL);
		List<CompareHistory> list = (List<CompareHistory>) map.get(GlobalConstants.RECORD_LIST);
		
		int bn = (pageNum-1)*pageSize;
		int en = pageNum*pageSize;
		List<CompareHistory> returnList = new ArrayList<CompareHistory>();
		int size = list.size();
		for (int i = bn; i <(en>size ? size : en); i++) {
			returnList.add(list.get(i));
		}
		returnMap.put(GlobalConstants.TOTAL, total);
		returnMap.put(GlobalConstants.PAGE_SIZE, pageSize);
		returnMap.put(GlobalConstants.PAGE_NO, pageNum);
		int totalPages = (total%pageSize)==0 ? (total/pageSize) : (total/pageSize+1);
		returnMap.put(GlobalConstants.TOTAL_PAGES, totalPages);
		returnMap.put(GlobalConstants.RECORD_LIST, returnList);
		
		//获取最新的比对记录
		CompareHistory latestHistory = list.get(list.size()-1);
		returnMap.put("latestHistory", latestHistory);
		
		return returnMap;
	}
	
	public void insertHistory(CompareHistory history, String projectName) {
		String historyPath = PropertiesUtils.getHistoryPath(projectName);
		URL resource = this.getClass().getClassLoader().getResource("/");
		//classes文件夹的路径
		String basePath = resource.toString().substring(6)+"../../";
		BufferedWriter bw = null;
		try {
			bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(basePath+historyPath, true), "GBK"));
			bw.append(history.toString()+"\r\n");
			bw.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != bw) {
				try {
					bw.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
