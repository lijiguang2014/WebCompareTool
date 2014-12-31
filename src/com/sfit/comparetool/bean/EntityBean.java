package com.sfit.comparetool.bean;

import java.util.HashMap;
import java.util.Map;

public class EntityBean {

	private String id;
	private String domainName;
	private String domainDescription;
	private String markup;
	private Map<String, ColumnBean> columnMap = new HashMap<String, ColumnBean>();
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDomainName() {
		return domainName;
	}
	public void setDomainName(String domainName) {
		this.domainName = domainName;
	}
	public String getDomainDescription() {
		return domainDescription;
	}
	public void setDomainDescription(String domainDescription) {
		this.domainDescription = domainDescription;
	}
	public String getMarkup() {
		return markup;
	}
	public void setMarkup(String markup) {
		this.markup = markup;
	}
	public Map<String, ColumnBean> getColumnMap() {
		return columnMap;
	}
	public void setColumnMap(Map<String, ColumnBean> columnMap) {
		this.columnMap = columnMap;
	}

}
