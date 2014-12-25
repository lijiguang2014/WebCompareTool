package com.sfit.comparetool.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.apache.log4j.Logger;

public class ConsoleUtils {
	private static Logger log = Logger.getLogger(ConsoleUtils.class);
	
    public static boolean callShell(String shellString) { 
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
}
