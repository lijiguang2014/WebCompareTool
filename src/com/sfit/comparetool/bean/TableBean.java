package com.sfit.comparetool.bean;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TableBean {

	private String id;
	private String domainName;
	private String domainDescription;
	private String markup;
	private Map<String, ColumnBean> columnMap = new HashMap<String, ColumnBean>();
	private Map<String, List<IndexBean>> indexes = new HashMap<String, List<IndexBean>>();
	
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
	public Map<String, List<IndexBean>> getIndexes() {
		return indexes;
	}
	public void setIndexes(Map<String, List<IndexBean>> indexes) {
		this.indexes = indexes;
	}
}
