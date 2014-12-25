package com.sfit.comparetool.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 存储即将生成的XML文件的Table节点的信息
 * 
 * @author li.jiguang
 *
 */
public class TableElement {
	
	private String tableName;
	private String description;
	private boolean isDrop = false;
	private boolean isCreate = false;
	private boolean isDropPrimaryKey = false;
	private List<String> dropColumns = new ArrayList<String>();
	private List<ColumnBean> adds = new ArrayList<ColumnBean>();
	private List<AlterElement> alters = new ArrayList<AlterElement>();
	private Map<String, ColumnBean> columns = new HashMap<String, ColumnBean>();
	private Map<String, List<IndexBean>> indexes = new HashMap<String, List<IndexBean>>();
	private List<String> dropIndexes = new ArrayList<String>();
	private String keyList = "";
	
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public boolean isDrop() {
		return isDrop;
	}
	public void setDrop(boolean isDrop) {
		this.isDrop = isDrop;
	}
	public boolean isCreate() {
		return isCreate;
	}
	public void setCreate(boolean isCreate) {
		this.isCreate = isCreate;
	}
	public boolean isDropPrimaryKey() {
		return isDropPrimaryKey;
	}
	public void setDropPrimaryKey(boolean isDropPrimaryKey) {
		this.isDropPrimaryKey = isDropPrimaryKey;
	}
	public List<String> getDropColumns() {
		return dropColumns;
	}
	public void setDropColumns(List<String> dropColumns) {
		this.dropColumns = dropColumns;
	}
	public List<ColumnBean> getAdds() {
		return adds;
	}
	public void setAdds(List<ColumnBean> adds) {
		this.adds = adds;
	}
	public List<AlterElement> getAlters() {
		return alters;
	}
	public void setAlters(List<AlterElement> alters) {
		this.alters = alters;
	}
	public Map<String, ColumnBean> getColumns() {
		return columns;
	}
	public void setColumns(Map<String, ColumnBean> columns) {
		this.columns = columns;
	}
	public Map<String, List<IndexBean>> getIndexes() {
		return indexes;
	}
	public void setIndexes(Map<String, List<IndexBean>> indexes) {
		this.indexes = indexes;
	}
	public List<String> getDropIndexes() {
		return dropIndexes;
	}
	public void setDropIndexes(List<String> dropIndexes) {
		this.dropIndexes = dropIndexes;
	}
	public String getKeyList() {
		return keyList;
	}
	public void setKeyList(String keyList) {
		this.keyList = keyList;
	}
}
