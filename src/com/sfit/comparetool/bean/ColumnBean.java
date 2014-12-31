package com.sfit.comparetool.bean;

public class ColumnBean {
	private String columnName;
	private String alias;
	private String type;
	private String columnDescription;
	private String notNull;
	private String isKey;
	private String markup;
	
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getColumnDescription() {
		return columnDescription;
	}
	public void setColumnDescription(String columnDescription) {
		this.columnDescription = columnDescription;
	}
	public String getNotNull() {
		return notNull;
	}
	public void setNotNull(String notNull) {
		this.notNull = notNull;
	}
	public String getIsKey() {
		return isKey;
	}
	public void setIsKey(String isKey) {
		this.isKey = isKey;
	}
	public String getMarkup() {
		return markup;
	}
	public void setMarkup(String markup) {
		this.markup = markup;
	}
	
}
