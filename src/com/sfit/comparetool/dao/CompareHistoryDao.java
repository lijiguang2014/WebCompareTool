package com.sfit.comparetool.dao;

import java.util.List;

import com.sfit.comparetool.bean.CompareHistory;

public interface CompareHistoryDao {
	/**
	 * 查询比对记录
	 * 
	 * @return
	 */
	List<CompareHistory> queryHistory();
	
	/**
	 * 插入记录
	 * 
	 * @param history
	 */
	int insertHistory(CompareHistory history);
}
