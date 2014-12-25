package com.sfit.comparetool.bean;

public class CompareBean {
	
	private String sourceType;
	private String url;
	private String username;
	private String password;
	
	public CompareBean(){}
	
	public CompareBean(String sourceType, 
			String url, String username, String password){
		this.sourceType = sourceType;
		this.url = url;
		this.username = username;
		this.password = password;
	}
	
	
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
