package com.sfit.comparetool.bean;

public class CompareHistory {
	
	private String version;
	private String compareDate;
	private String srcFilePath;
	private String targetFilePath;
	private String templateFilePath;
	private String middleResultFilePath;
	private String alterSqlFilePath;
	private String reportFilePath;
	private String status;
	
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getCompareDate() {
		return compareDate;
	}
	public void setCompareDate(String compareDate) {
		this.compareDate = compareDate;
	}
	public String getSrcFilePath() {
		return srcFilePath;
	}
	public void setSrcFilePath(String srcFilePath) {
		this.srcFilePath = srcFilePath;
	}
	public String getTargetFilePath() {
		return targetFilePath;
	}
	public void setTargetFilePath(String targetFilePath) {
		this.targetFilePath = targetFilePath;
	}
	public String getTemplateFilePath() {
		return templateFilePath;
	}
	public void setTemplateFilePath(String templateFilePath) {
		this.templateFilePath = templateFilePath;
	}
	public String getMiddleResultFilePath() {
		return middleResultFilePath;
	}
	public void setMiddleResultFilePath(String middleResultFilePath) {
		this.middleResultFilePath = middleResultFilePath;
	}
	public String getAlterSqlFilePath() {
		return alterSqlFilePath;
	}
	public void setAlterSqlFilePath(String alterSqlFilePath) {
		this.alterSqlFilePath = alterSqlFilePath;
	}
	public String getReportFilePath() {
		return reportFilePath;
	}
	public void setReportFilePath(String reportFilePath) {
		this.reportFilePath = reportFilePath;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		
		StringBuilder sb = new StringBuilder();
		sb.append(this.version);
		sb.append(",");
		sb.append(this.compareDate);
		sb.append(",");
		sb.append(this.srcFilePath);
		sb.append(",");
		sb.append(this.targetFilePath);
		sb.append(",");
		sb.append(this.templateFilePath);
		sb.append(",");
		sb.append(this.alterSqlFilePath);
		sb.append(",");
		sb.append(this.reportFilePath);
		sb.append(",");
		sb.append(this.status);
		
		return sb.toString();
	}
}
