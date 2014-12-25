package com.sfit.comparetool.common;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sfit.comparetool.bean.CompareHistory;
import com.sfit.comparetool.dao.CompareHistoryDao;

public class MyBatisUtil {
	private final static SqlSessionFactory sqlSessionFactory;
	
	static {
		String resource = "com/sfit/comparetool/common/mybatis-config.xml";
		Reader reader = null;
		try {
			reader = Resources.getResourceAsReader(resource);
		} catch (IOException e) {
			e.printStackTrace();
		}
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
	}
	
	public static SqlSessionFactory getSqlSessionFactory(){
		return sqlSessionFactory;
	}
	
	public static void main(String[] args) {
		SqlSessionFactory s = getSqlSessionFactory();
		SqlSession session = s.openSession();
		CompareHistoryDao mapper = session.getMapper(CompareHistoryDao.class);
		PageHelper.startPage(1, 3);
		List<CompareHistory> queryHistory = mapper.queryHistory();
		for(CompareHistory c : queryHistory) {
			System.out.println(c.toString());
		}
		//用PageInfo对结果进行包装
		PageInfo page = new PageInfo(queryHistory);
		System.out.println("PageNum:" + page.getPageNum());
		System.out.println("PageSize:" + page.getPageSize());
		System.out.println("StartRow:" + page.getStartRow());
		System.out.println("EndRow:" + page.getEndRow());
		System.out.println("Total:" + page.getTotal());
		System.out.println("Pages:" + page.getPages());
		
		CompareHistory history = new CompareHistory();
		history.setVersion("12");
		history.setCompareDate("2014-12-04");
		history.setReportFilePath("tt");
		history.setSrcFilePath("src");
		history.setStatus("1");
		history.setTargetFilePath("target");
		history.setAlterSqlFilePath("alter");
		
		int insertHistory = mapper.insertHistory(history);
		session.commit();
		System.out.println(insertHistory);
	}
}
