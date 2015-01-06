package com.sfit.comparetool.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.BindException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sfit.comparetool.bean.CompareBean;
import com.sfit.comparetool.service.ExcelGenerator;
import com.sfit.comparetool.service.XMLCompare;
import com.sfit.comparetool.service.XMLGenerator;

@Controller
public class FileController {
	
	private static Logger log = Logger.getLogger(FileController.class);
	
	private static final String uploadDirectoryRelativePath = "dataModel/upload/";
	
	@RequestMapping(value="/upload.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, String> uploadFile( @RequestParam MultipartFile[] upFile, HttpServletRequest request,
			HttpServletResponse response, BindException errors) throws Exception {
		
		Map<String, String> result = new HashMap<String, String>();
		 
		response.setCharacterEncoding("UTF-8");
		if (upFile.length == 0) {
			result.put("success", "0");
			result.put("msg", "后台未接收到上传文件");
			return result;
		}
		
		String fileName = upFile[0].getOriginalFilename();
		String fileExtend = fileName.substring(fileName.indexOf("."));
		if(checkFileExt(fileName)) {
			//获取路径
			String basePath = request.getSession().getServletContext().getRealPath("/");
			 
			File uploadTargetDirectory = new File(basePath + uploadDirectoryRelativePath);
			if(!uploadTargetDirectory.exists()) {
				uploadTargetDirectory.mkdirs();
			}
			
			//格式化当做版本号的日期字符串
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
			String dateStr = format.format(new Date());
			String uploadFileName =  dateStr + fileExtend;
			
			File uploadFile = new File(basePath + uploadDirectoryRelativePath + uploadFileName);
			boolean isSuccess = false;
			try {
				FileCopyUtils.copy(upFile[0].getBytes(), uploadFile);
				isSuccess = true;
			} catch (IOException e) {
				log.error(e);
				result.put("success", "0");
				result.put("msg", "转存文件失败,错误原因：" + e.getMessage());
			}
			
			if (isSuccess) {
				result.put("success", "1");
				result.put("fileRelativePath", uploadDirectoryRelativePath + uploadFileName);
				result.put("msg", "文件上传成功");
			}
		} else {
			result.put("success", "0");
			result.put("msg", "文件不合法(只接受csv，xls,xlsx,xml格式文件)");
		}
		
		return result;
	}
	
	private boolean checkFileExt(String fileName) {
		String[] allowExt = new String[]{".csv", ".xls", ".xlsx", ".xml"};
		for (String ext : allowExt) {
			if (fileName.endsWith(ext)) {
				return true;
			}
		}
		return false;
	}

	@RequestMapping("/downloadFile.do")
	public ModelAndView downloadFile(@RequestParam String filePath,
			HttpServletRequest request,HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
		
		String[] splits = filePath.split("/");
		String fileName = new String(splits[splits.length-1].getBytes("ISO8859-1"), "UTF-8");
		
		String basePath = request.getServletContext().getRealPath("/");
		String downloadPath = basePath + filePath;
		try {
			long fileLength = new File(downloadPath).length();
			response.setCharacterEncoding("application/x-msdownload;");
			response.setHeader("Content-Disposition", "attachment;filename="
					+ new String(fileName.getBytes("UTF-8"), "ISO8859-1"));
			response.setHeader("Content-Length", String.valueOf(fileLength));
			bis = new BufferedInputStream(new FileInputStream(downloadPath));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while(-1 != (bytesRead=bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis!=null) {
				bis.close();
			}
			if(bos!=null) {
				bos.close();
			}
		}
		return null;
	}
	
	@RequestMapping("/deleteFile.do")
	public @ResponseBody Map<String, String> deleteFile(@RequestParam String fileRelativePath, HttpServletRequest request) {

		Map<String, String> result = new HashMap<String, String>();
		
		String basePath = request.getServletContext().getRealPath("/");
		String filePath = basePath + fileRelativePath;
		File file = new File(filePath);
		
		if (file.exists()) {
			file.delete();
			result.put("success", "1");
			result.put("msg", "文件删除成功");
		} else {
			result.put("success", "0");
			result.put("msg", "指定的文件路径" + filePath + "不存在");
		}
	
		return result;
	}
	
	@RequestMapping("/getReportContent.do")
	public @ResponseBody Map<String, String> getReportContent(@RequestParam String reportPath,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Map<String, String> result = new HashMap<String, String>();
		
		response.setCharacterEncoding("UTF-8");
		
		String basePath = request.getServletContext().getRealPath("/");
		File report = new File(basePath + reportPath);
		if (!report.exists()) {
			result.put("success", "0");
			result.put("content", "文件不存在");
			return result;
		}
		
		StringBuffer sb = new StringBuffer();
		BufferedReader br = new BufferedReader(
				new InputStreamReader(new FileInputStream(report), "UTF-8"));
		String line = null;
		while((line=br.readLine()) != null) {
			sb.append(line + "\n");
		}
		
		result.put("success", "1");
		result.put("content", sb.toString());
		br.close();
		
		return result;
	}
	
	@RequestMapping("/showReport.do")
	public ModelAndView showReport(@RequestParam String reportPath,
			HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("showReport");
		String basePath = request.getServletContext().getRealPath("/");
		File report = new File(basePath + reportPath);
		if (!report.exists()) {
			mv.addObject("error", "文件不存在");
			return mv;
		}
		
		try {
			StringBuffer sb = new StringBuffer();
			BufferedReader br = new BufferedReader(
					new InputStreamReader(new FileInputStream(report), "UTF-8"));
			String line = null;
			while((line=br.readLine()) != null) {
				sb.append(line + "\n");
			}
			mv.addObject("reportContent", sb.toString());
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return mv;
	}
	
	@RequestMapping("/exportEntity.do")
	public @ResponseBody Map<String, String> exportEntityFileFromDB(CompareBean condition, @RequestParam String exportType,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> result = new HashMap<String, String>();
		
		String url = condition.getUrl();
		String password = condition.getPassword();
		String username = condition.getUsername();
		String basePath = request.getServletContext().getRealPath("/");
		//格式化当做版本号的日期字符串
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String dateStr = format.format(new Date());
		
		String resultRelativePath = "";;
		String resultPath = "";
		try {
			if(exportType.equals("excel")) {
				ExcelGenerator generator = new ExcelGenerator();
				resultRelativePath = "dataModel/fromDB/" + dateStr + ".xls";
				resultPath += basePath + resultRelativePath;
				generator.generateEntity(url, username, password, resultPath);
			} else if(exportType.equals("xml")) {
				XMLGenerator generator = new XMLGenerator();
				resultRelativePath = "dataModel/fromDB/" + dateStr + ".xml";
				resultPath += basePath + resultRelativePath;
				generator.generateEntity(url, username, password, resultPath);
			}
		} catch (Exception e) {
			result.put("success", "0");
			result.put("msg", e.getMessage());
			log.error(e);
			return result;
		}
		
		result.put("filePath", resultRelativePath);
		result.put("success", "1");
		
		return result;
	}
	
	@RequestMapping("/merge.do")
	public Map<String, String> mergeXMLByPUMP(@RequestParam String frameworkFileRelativePath,
			@RequestParam String entityFileRelativePath,
			@RequestParam String typeFileRelativePath,
			HttpServletRequest request) {
		
		Map<String, String> result = new HashMap<String, String>();
		
		String basePath = request.getServletContext().getRealPath("/");
		String frameworkFilePath = basePath + frameworkFileRelativePath;
		String entityFilePath = basePath + entityFileRelativePath;
		String typeFilePath = basePath + typeFileRelativePath;
		
		//格式化当做版本号的日期字符串
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String dateStr = format.format(new Date());
		
		String generateDirectoryPath = basePath + "generate/";
		File generateDirectory = new File(generateDirectoryPath);
		if (!generateDirectory.exists()) {
			generateDirectory.mkdirs();
		}
		
		String resultRelativePath = "generate/" + dateStr + ".xml";
		String resultFilePath = basePath + resultRelativePath;  
		
		XMLCompare xmlCompare = new XMLCompare();
		try {
			xmlCompare.merge(frameworkFilePath, entityFilePath, typeFilePath, resultFilePath);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", "0");
			result.put("msg", e.getMessage());
			return result;
		}
		
		result.put("filePath", resultRelativePath);
		result.put("success", "1");
		
		return result;
	}
	
}
