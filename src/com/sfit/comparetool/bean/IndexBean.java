package com.sfit.comparetool.bean;

public class IndexBean {
	private String indexName;
	private String columnName;
	private String descend;
	private String uniqueness;
	
	public String getIndexName() {
		return indexName;
	}
	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getDescend() {
		return descend;
	}
	public void setDescend(String descend) {
		this.descend = descend;
	}
	public String getUniqueness() {
		return uniqueness;
	}
	public void setUniqueness(String uniqueness) {
		this.uniqueness = uniqueness;
	}
}
