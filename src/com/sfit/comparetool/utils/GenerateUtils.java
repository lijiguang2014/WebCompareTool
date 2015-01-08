package com.sfit.comparetool.utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class GenerateUtils {
	
	/**
	 * 按规则生成数据库中所有数据类型的别名
	 */
	private static final String GENERATE_TYPE = "select 'TY_' || min(c.COLUMN_NAME) TYPE_NAME, cc.datatype type"
			+ " from user_tab_columns c, (select distinct u.DATA_TYPE || '(' || u.DATA_LENGTH || ')' datatype"
			+ " from user_tab_columns u"
			+ " where u.DATA_TYPE <> 'NUMBER') cc"
			+ " where cc.datatype = c.DATA_TYPE || '(' || c.DATA_LENGTH || ')' and c.DATA_TYPE <> 'NUMBER'"
			+ " group by cc.datatype"
			+ " union select 'TY_' || min(c.COLUMN_NAME) TYPE_NAME, cc.datatype type"
			+ " from user_tab_columns c, (select distinct u.DATA_TYPE || '(' || u.DATA_PRECISION || ',' ||u.DATA_SCALE || ')' datatype"
			+ " from user_tab_columns u"
			+ " where u.DATA_TYPE = 'NUMBER' and u.DATA_PRECISION is not null) cc"
			+ " where cc.datatype = c.DATA_TYPE || '(' || c.DATA_PRECISION || ',' || c.DATA_SCALE || ')' and c.DATA_TYPE = 'NUMBER'"
			+ " group by cc.datatype "
			+ " union select 'TY_' || min(c.COLUMN_NAME) TYPE_NAME, cc.datatype type"
			+ " from user_tab_columns c,"
			+ "(select distinct u.DATA_TYPE || '(' || u.DATA_LENGTH || ')' datatype"
			+ " from user_tab_columns u"
			+ " where u.DATA_TYPE = 'NUMBER' and u.DATA_PRECISION is null) cc"
			+ " where cc.datatype = c.DATA_TYPE || '(' || c.DATA_LENGTH || ')' and c.DATA_TYPE = 'NUMBER'"
			+ " group by cc.datatype"
			+ " union select 'TY_FLOAT', 'NUMBER' from dual";
	
	public Map<String, String> generateTypeMap(String url, String username, String password) throws Exception {
		Map<String, String> resultMap = new HashMap<String, String>();
		
		Connection conn = JdbcUtil.getConnection(url, username, password);
		try {
			Statement statement = conn.createStatement();
			ResultSet rs = statement.executeQuery(GENERATE_TYPE);
			
			while (rs.next()) {
				String alias = rs.getString("TYPE_NAME");
				String type = rs.getString("TYPE");
				if (resultMap.containsKey(alias)) {
					alias = getDifferentAlias(resultMap, alias, 0);
				}
				resultMap.put(alias, type);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("导出XML格式的TYPE文件中出错!");
		}
		
		return resultMap;
	}

	private String getDifferentAlias(Map<String, String> resultMap,
			String alias, int i) {
		if (!resultMap.containsKey(alias+i)) {
			return alias+i;
		} else {
			return getDifferentAlias(resultMap, alias, i+1);
		}
	}
}
