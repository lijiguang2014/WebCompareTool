package com.sfit.comparetool.bean;

public class AlterElement {

	private String columnName;
	private String type;
	private String changedColumnName;
	private String originalChangedTypeName;
	private String changedTypeName;
	private String changedComment;
	private String changedIsKey;
	private String changedNotNull;
	private String changedIsIndex;
	
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getChangedColumnName() {
		return changedColumnName;
	}
	public void setChangedColumnName(String changedColumnName) {
		this.changedColumnName = changedColumnName;
	}
	public String getChangedTypeName() {
		return changedTypeName;
	}
	public void setChangedTypeName(String changedTypeName) {
		this.changedTypeName = changedTypeName;
	}
	public String getChangedComment() {
		return changedComment;
	}
	public void setChangedComment(String changedComment) {
		this.changedComment = changedComment;
	}
	public String getChangedIsKey() {
		return changedIsKey;
	}
	public void setChangedIsKey(String changedIsKey) {
		this.changedIsKey = changedIsKey;
	}
	public String getChangedNotNull() {
		return changedNotNull;
	}
	public void setChangedNotNull(String changedIsNull) {
		this.changedNotNull = changedIsNull;
	}
	public String getChangedIsIndex() {
		return changedIsIndex;
	}
	public void setChangedIsIndex(String changedIsIndex) {
		this.changedIsIndex = changedIsIndex;
	}
	public String getOriginalChangedTypeName() {
		return originalChangedTypeName;
	}
	public void setOriginalChangedTypeName(String originalChangedTypeName) {
		this.originalChangedTypeName = originalChangedTypeName;
	}
	
}
