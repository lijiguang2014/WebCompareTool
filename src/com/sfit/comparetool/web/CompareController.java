package com.sfit.comparetool.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfit.comparetool.bean.CompareBean;
import com.sfit.comparetool.bean.CompareHistory;
import com.sfit.comparetool.bean.TableBean;
import com.sfit.comparetool.service.CSVCompare;
import com.sfit.comparetool.service.CSVGenerator;
import com.sfit.comparetool.service.ExcelCompare;
import com.sfit.comparetool.service.ExcelGenerator;
import com.sfit.comparetool.service.XMLCompare;
import com.sfit.comparetool.service.XMLGenerator;
import com.sfit.comparetool.service.i.Generator;
import com.sfit.comparetool.utils.ConsoleUtils;
import com.sfit.comparetool.utils.ConvertUtils;
import com.sfit.comparetool.utils.ExcelUtils;
import com.sfit.comparetool.utils.PropertiesUtils;

@Controller
public class CompareController {
	
	private static Logger log = Logger.getLogger(CompareController.class);
	
	private static final String fromDBDirectoryRelativePath = "dataModel/fromDB/";
	private static final String uploadDirectoryRelativePath = "dataModel/upload/";
	private static final String excelExtend = ".xls";
	private static final String xmlExtend = ".xml";
	
	@RequestMapping("/login.do")
	public String login(@RequestParam String projectName, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("projectName", projectName);
		return "redirect:/main.jsp";
	}
	
	@RequestMapping("/compare.do")
	public @ResponseBody Map<String, Object> compare(CompareBean compareBean, @RequestParam String projectName,
			@RequestParam String sourceFileRelativePath, @RequestParam String targetFileRelativePath,
			@RequestParam String compareFileType, @RequestParam String databaseType) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		String url = null;
		String username = null;
		String password = null;
		InputStream sourceInputStream = null;
		InputStream targetInputStream = null;
		String sourceFilePath = null;
		
		URL resource = this.getClass().getClassLoader().getResource("/");
		String basePath = resource.toString().substring(6) + "../../";
		File dataModelFromDBDirectory = new File(basePath + fromDBDirectoryRelativePath);
		if(!dataModelFromDBDirectory.exists()) {
			dataModelFromDBDirectory.mkdirs();
		}
		
		File uploadDirectory = new File(basePath + uploadDirectoryRelativePath);
		if(!uploadDirectory.exists()) {
			uploadDirectory.mkdirs();
		}
		
		//格式化当做版本号的日期字符串
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String dateStr = format.format(new Date());

		//格式化日期字符串
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String compareDate = dateFormat.format(new Date());
		
		try {
			//sourceType=0 代表标准数据模型由数据库生成
			if (compareBean.getSourceType().equals("0")) {
				url = compareBean.getUrl();
				username = compareBean.getUsername();
				password = compareBean.getPassword();
				
				sourceFileRelativePath = fromDBDirectoryRelativePath + dateStr + ".csv";
				sourceFilePath = basePath + sourceFileRelativePath;
				
				Generator generator = null;
				if(compareFileType.equals(excelExtend)) {
					generator = new ExcelGenerator();
				} else if (compareFileType.equals(xmlExtend)) {
					generator = new XMLGenerator();
				} else {
					generator = new CSVGenerator();
				}
				try {
					generator.generateEntity(url, username, password, sourceFilePath);
				} catch (IOException e) {
					log.error(e);
					result.put("success", "0");
					result.put("error", "从数据库导出标准数据模型出错！");
					return result;
				}
				
				
			} else {
				sourceFilePath = basePath + sourceFileRelativePath;
			}
			
			String uploadTargetFilePath = basePath + targetFileRelativePath;
			
			String typeMappingFilePath = basePath + PropertiesUtils.getTypeMappingPath(projectName);
			
			String middleResultDirectoryPath = basePath + "result/xmlMiddleReuslt/";
			File middleResultDirectory = new File(middleResultDirectoryPath);
			if (!middleResultDirectory.exists()) {
				middleResultDirectory.mkdirs();
			}
			String middleResultPath = middleResultDirectoryPath + dateStr + ".xml";
			
			String reportFileRelativePath = "result/report/" + dateStr + ".txt";
			String reportFilePath = basePath + reportFileRelativePath;
			File reportDirectory = new File(basePath + "result/report/");
			if (!reportDirectory.exists()) {
				reportDirectory.mkdirs();
			}
			
			try {
				if (compareFileType.equals(xmlExtend)) {
					XMLCompare comparetool = new XMLCompare();
					comparetool.compare(uploadTargetFilePath, sourceFilePath, typeMappingFilePath, middleResultPath, reportFilePath);
				} else if (compareFileType.equals(excelExtend)) {
					ExcelCompare comparetool = new ExcelCompare();
					comparetool.compare(uploadTargetFilePath, sourceFilePath, middleResultPath, reportFilePath);
				} else {
					CSVCompare comparetool = new CSVCompare();
					comparetool.compare(sourceInputStream, targetInputStream, typeMappingFilePath, middleResultPath, reportFilePath);
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
				result.put("success", "0");
				result.put("error", "比对过程中出错" + e);
				return result;
			}
			
			File middleResultFile = new File(middleResultPath);
			if (!middleResultFile.exists()) {
				//修改前后的数据模型没有变化
				result.put("success", "0");
				result.put("error", "修改前后的数据模型没有变化");
				return result;
			}
			
			//调用Pump解析xml中间结果生成alter脚本
			String finalResultRelativePath = "result/alterScript/" + dateStr + ".sql";
			String alterTemplatePath = PropertiesUtils.getTemplatePath(projectName);
			String middleResultRelativePath = "result/xmlMiddleReuslt/" + dateStr + ".xml";
			String shellString = "cmd /c " + basePath + "script/bat/createAlterScript.bat " 
						+ finalResultRelativePath + " " + alterTemplatePath + " " + middleResultRelativePath;
			boolean isSuccess = ConsoleUtils.callShell(shellString);
			if(!isSuccess) {
				result.put("success", "0");
				result.put("error", "PUMP解析中间结果出错（文件路径：" + middleResultPath + ")");
				return result;
			} 

			//持久化比对历史记录
			CompareHistory history = new CompareHistory();
			history.setVersion(dateStr);
			history.setCompareDate(compareDate);
			history.setSrcFilePath(sourceFileRelativePath);
			history.setTargetFilePath(targetFileRelativePath);
			history.setTemplateFilePath(PropertiesUtils.getTemplatePath(projectName));
			history.setAlterSqlFilePath(finalResultRelativePath);
			history.setReportFilePath(reportFileRelativePath);
			history.setStatus("0");
			
			result.put("success", "1");
			result.put("latestHistory", history);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return result;
	}

	@RequestMapping("/generate.do")
	public @ResponseBody Map<String, String> generate(@RequestParam String designRelativeFilePath) throws Exception {
		Map<String, String> returnMap = new HashMap<String, String>();
		
		String errorMsg = "";
		
		URL resource = this.getClass().getClassLoader().getResource("/");
		String basePath = resource.toString().substring(6) + "../../";
		String designFilePath = basePath + designRelativeFilePath;
		
		String generatePath = basePath + "generate/";
		File generateDirectory = new File(generatePath);
		if (!generateDirectory.exists()) {
			generateDirectory.mkdirs();
		}
		
		String entityPath =  basePath+"generate/entity.xml";
		String frameworkPath = basePath + "generate/framework.xml";
		String typeMappingPath = basePath + "generate/typeMapping.xml";
		
		ConvertUtils convertUtils = new ConvertUtils();
		ExcelUtils excelUtils = new ExcelUtils();
		try {
			Map<String, TableBean> tableBeanMap = excelUtils.getTableBeanMap(designFilePath);
			Map<String, String> typeMapping = excelUtils.getTypeMapping(designFilePath);
			convertUtils.generateEntityXMLFromExcel(tableBeanMap, entityPath);
			convertUtils.generateFrameworkXML(tableBeanMap, frameworkPath);
			convertUtils.generateTypeMappingXMLFromExcel(typeMapping, typeMappingPath);
			String shellStr = "cmd /c " + basePath + "script/bat/createDataModel.bat "
					+ generatePath+"result.xml" + " " + frameworkPath +" " + entityPath
					+ " " + typeMappingPath + " " + generatePath + "result.sql" + " "
					+ basePath+"template/fumargin/CreateTable.sql.tpl";
			ConsoleUtils.callShell(shellStr);
			
			returnMap.put("success", "1");
			returnMap.put("filePath", "generate/result.sql");
			return returnMap;
		} catch (IOException e) {
			log.error(e);
			errorMsg = e.getMessage();
		}
		
		returnMap.put("success", "0");
		returnMap.put("msg", errorMsg);
		return returnMap;
	}
	
	@RequestMapping("/getProjectNames.do")
	public @ResponseBody List<String> getProjectNames() {
		return PropertiesUtils.getProjectNames();
	}
	
}
