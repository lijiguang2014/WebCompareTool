package com.sfit.comparetool.bean;

public class KeyBean {
	
	private String name;
	private String order;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	
	@Override
	public String toString() {
		return this.name + this.order;
	}
}
