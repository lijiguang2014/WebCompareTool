alter table D_COMPCLIENTFUND add column RISKRATE    ;
	
alter table A_TEMP_LOGINRANK add column SHORTNAME1 TY_TRSEQ  ;
	
alter table A_QUERYUSER2_LOGINSTATUS drop column TRADECNT;
	
alter table D_SECBYARBITRAGEHEDGE add column ACCOUNTNUM    ;
	
alter table D_SECBYINVESTORTYPE add column ACCOUNTNUM    ;
	
alter table D_SECBYSPECIALCORPTYPE add column ACCOUNTNUM    ;
	
alter table T_B_CLIENT_YC add column POSTCODE TY_TRSEQ  ;
	
alter table D_SECBYCURRENCYVALUE add column ACCOUNTNUM    ;
	
alter table H_CHECKCLIIOFUNDDETAIL add column SEQID    ;
	
alter table D_SECBYOPENDATE add column ACCOUNTNUM    ;
	
alter table H_BUREAUREPORT add column BUREAUID    ;
alter table H_BUREAUREPORT add column REPORT    ;
	
