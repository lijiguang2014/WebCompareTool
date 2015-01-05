package com.sfit.comparetool.bean;

import java.util.HashMap;
import java.util.Map;

public class TableBean {
	
	private String tablename;
	private String title;
	private String description;
	Map<String, ColumnBean> columns = new HashMap<String, ColumnBean>();
	Map<String, DefineIndex> indexes = new HashMap<String, DefineIndex>();
	
	public String getTablename() {
		return tablename;
	}
	public void setTablename(String tablename) {
		this.tablename = tablename;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Map<String, ColumnBean> getColumns() {
		return columns;
	}
	public void setColumns(Map<String, ColumnBean> columns) {
		this.columns = columns;
	}
	public Map<String, DefineIndex> getIndexes() {
		return indexes;
	}
	public void setIndexes(Map<String, DefineIndex> indexes) {
		this.indexes = indexes;
	}
	
}
