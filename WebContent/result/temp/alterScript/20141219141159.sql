alter table A_TEMP_NOLOGIN modify (CLIENTID not null);
	
alter table A_TEMP_LOGINRANK add column TRADEMONTH1 VCHAR2(10)  ;
	
alter table A_QUERYUSER2_LOGINSTATUS drop column TRADEDATE;
	
