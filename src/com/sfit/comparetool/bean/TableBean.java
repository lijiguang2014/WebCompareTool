package com.sfit.comparetool.bean;

import java.util.HashMap;
import java.util.Map;

public class TableBean {
	
	private String tablename;
	private EntityBean entity;
	private Map<String, DefineIndex> indexes = new HashMap<String, DefineIndex>();
	
	public String getTablename() {
		return tablename;
	}
	public void setTablename(String tablename) {
		this.tablename = tablename;
	}
	public EntityBean getEntity() {
		return entity;
	}
	public void setEntity(EntityBean entity) {
		this.entity = entity;
	}
	public Map<String, DefineIndex> getIndexes() {
		return indexes;
	}
	public void setIndexes(Map<String, DefineIndex> indexes) {
		this.indexes = indexes;
	}
	
}
