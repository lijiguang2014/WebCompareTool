package com.sfit.comparetool.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.apache.log4j.Logger;

public class ConsoleUtils {
	private static Logger log = Logger.getLogger(ConsoleUtils.class);
	
    public static boolean callShell(String shellString) { 
    	System.out.println(shellString);
    	Process process = null;
        try {  
            process = Runtime.getRuntime().exec(shellString);  
            BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()), 4096);
            String line = null;
            while ( (line = br.readLine()) != null)
            System.out.println(line);
            int exitValue = process.waitFor();  
            if (0 != exitValue) { 
            	 log.error("call shell failed. error code is :" + exitValue);  
            	 return false;
            }  
            return true;
        } catch (Throwable e) {  
        	log.error("call shell failed. " + e);
        	return false;
        } finally {
        	try{  
        		if(null != process) {
        			process.getErrorStream().close();  
        			process.getInputStream().close();  
        			process.getOutputStream().close();  
        		}
            }catch(Exception ee){
            	log.error(ee);
            } 
        }
    }  
    
    public static void main(String[] args) {
    	String s = "cmd /c D:/code/WebCompareTool_V3.0/WebContent/WEB-INF/classes/../../script/bat/createAlterScript.bat result/temp/alterScript/20150108143231.sql template/fumargin/alter.sql.tpl xmlMiddleReuslt/20150108143231.xml";
		new ConsoleUtils().callShell(s);
	}
}
