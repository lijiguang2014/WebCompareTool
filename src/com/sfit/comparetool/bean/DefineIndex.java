package com.sfit.comparetool.bean;

import java.util.ArrayList;
import java.util.List;

public class DefineIndex {
	
	private String name;
	private String uniqueness;
	private List<KeyBean> keyList = new ArrayList<KeyBean>();
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUniqueness() {
		return uniqueness;
	}
	public void setUniqueness(String uniqueness) {
		this.uniqueness = uniqueness;
	}
	public List<KeyBean> getKeyList() {
		return keyList;
	}
	public void setKeyList(List<KeyBean> keyList) {
		this.keyList = keyList;
	}
	
}
