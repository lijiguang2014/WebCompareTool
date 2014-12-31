package com.sfit.comparetool.utils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;

public class PropertiesUtils {
	
	private static final Logger log = Logger.getLogger(PropertiesUtils.class); 
	
	private static final Properties prop = new Properties();
	
	private static final String file = "/config.properties";
	
	private static final String historyDirectoryPath= "historyDirectoryPath";
	private static final String templatePath= "templatePath";
	private static final String typeMappingPath= "typeMappingPath";
	private static final String projectNames= "projectNames";
	
	static {
		init();
		Executors.newSingleThreadScheduledExecutor().scheduleAtFixedRate(new Listener(System.currentTimeMillis()), 60, 20, TimeUnit.SECONDS);
	}
	
	private static void init() {
		log.debug(PropertiesUtils.class.getName()+" init at "+DateUtils.format(new Date()));
		
		InputStream is = PropertiesUtils.class.getClassLoader().getResourceAsStream(file);
		
		try {
			prop.load(is);
			is.close();
		} catch (IOException e) {
			log.error("Failed read properties file from " + file);
		}
	}
	
	private PropertiesUtils() {
		//不允许通过new来构造实例
		log.error("Can't instance PropertiesUtils.");
		throw new IllegalAccessError("Can't instance PropertiesUtil.");
	}
	
	/**
	 * 根据传入的key读取value值
	 * @param key 要获取value的key
	 * @return key对应的value值
	 */
	private static String get(String key){
		
		String value = (String) prop.get(key);

		if(value.trim().length() == 0)
			return null;
		
		return value.trim(); 
	}
	
	//获取项目列表
	public static List<String> getProjectNames() {
		
		List<String> list = new ArrayList<String>();
		
		String projectNamesStr = get(projectNames);
		String[] ss = projectNamesStr.split(",");
		for (String s : ss) {
			list.add(s);
		}

		return list;
	}
	
	/**
	 * 获取项目对应的比对记录文件的存储路径
	 * 
	 * @param projectName
	 * @return
	 */
	public static String getHistoryDirectoryPath(String projectName) {
		return get(projectName + "." + historyDirectoryPath);
	}
	
	/**
	 * 获取项目对应的alter脚本生成模板的存储路径
	 * 
	 * @param projectName
	 * @return
	 */
	public static String getTemplatePath(String projectName) {
		return get(projectName + "." + templatePath);
	}
	
	public static String getTypeMappingPath(String projectName) {
		return get(projectName + "." + typeMappingPath);
	}
	
	/**
	 * 监听器,监听文件是否被修改,如果修改,则重新加载
	 * @author LiJianlin
	 *
	 */
	 private static class Listener implements Runnable {
		private File f;
		private long modifyTime;
		
		private Listener(long current) {
			this.modifyTime = current;
		}
		
		@Override
		public void run() {
			f = new File(PropertiesUtils.class.getClassLoader().getResource(file).getPath());
			long lastModified = f.lastModified();
			
			if (lastModified > modifyTime) {
				this.modifyTime = lastModified;
				init();
			}
		}
	 }
	 
}
