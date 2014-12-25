package com.sfit.comparetool.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfit.comparetool.bean.CompareHistory;
import com.sfit.comparetool.context.GlobalConstants;
import com.sfit.comparetool.utils.FileDBUtils;

@Controller
@RequestMapping("/compareHistory")
public class CompareHistoryController {
	
	FileDBUtils historyDB = new FileDBUtils(); 

	@RequestMapping(value="/getList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object>  getList(@RequestParam String projectName, 
			@RequestParam(value="pageNo", required=false, defaultValue="1") int pageNo,
			HttpServletRequest request){
		HttpSession session = request.getSession();
		session.setAttribute("pageNo", pageNo);
		Map<String, Object> pageQuery = historyDB.pageQuery(projectName, GlobalConstants.DEFAULT_PAGE_SIZE, pageNo);
		return pageQuery;
	}
	
	@RequestMapping(value="/storeForStable.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> storeStableDataModel(CompareHistory history,
			@RequestParam String projectName, HttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		String basePath = request.getSession().getServletContext().getRealPath("/");
		String stableDirectoryRelativePath =  "/dataModel/stable/";
		File stableDataModelDirectory = new File(basePath + stableDirectoryRelativePath);
		if (!stableDataModelDirectory.exists()) {
			stableDataModelDirectory.mkdirs();
		}
		
		String targetFileRelativePath = history.getTargetFilePath();
		String suffix = getSuffix(targetFileRelativePath);
		String newVersion = getNewVersion(stableDataModelDirectory, projectName, suffix);
		String stableFilePath = basePath + stableDirectoryRelativePath + projectName + newVersion + suffix;
		try {
			FileInputStream targetFile = new FileInputStream(basePath + targetFileRelativePath);
			FileCopyUtils.copy(targetFile, new FileOutputStream(stableFilePath));
		} catch (Exception e) {
			result.put("success", "0");
			result.put("msg", "转存稳定版本文件失败" + e.getMessage());
		} 
		
		history.setVersion(newVersion);
		history.setTargetFilePath(stableDirectoryRelativePath + projectName + newVersion + suffix);
		historyDB.insertHistory(history, projectName);
		result.put("success", "1");
		result.put("history", history);
		
		return result;
	}

	private String getSuffix(String path) {
		String[] ss = path.split("/");
		return ss[ss.length-1].substring(ss[ss.length-1].indexOf("."));
	}

	private String getNewVersion(File stableDataModelDirectory, String prefix, String suffix) {
		String[] filenameList = stableDataModelDirectory.list();
		List<String> list = new ArrayList<String>();
		for(String name : filenameList) {
			if(name.startsWith(prefix)) {
				list.add(name);
			}
		}
		
		if (list.size() == 0) {
			return "V1";
		}
		for(int i = 0; i < list.size()-1; i++) {
			if (list.get(i+1).compareTo(list.get(i)) < 0) {
				String temp = list.get(i);
				list.add(i, list.get(i+1));
				list.add(i+1, temp);
			}
		}
		String latestFilename = list.get(list.size()-1);
		int latestVersionNum = Integer.valueOf(latestFilename.substring(latestFilename.indexOf(prefix)+prefix.length()+1, latestFilename.indexOf("."))) + 1;
		return "V"+String.valueOf(latestVersionNum);
	}

}
