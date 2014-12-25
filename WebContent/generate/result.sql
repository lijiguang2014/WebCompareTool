spool CreateTable.log
--******************************
--´´½¨
--******************************
drop table A_QUERYUSER2_LOGINSTATUS;

create table A_QUERYUSER2_LOGINSTATUS
(
	LOGINCNT number(10,0) 
	,TRADECNT number(10,0) 
	,LOGINTYPE varchar2(10) 
	,TRADEDATE varchar2(10) 
);

comment on table A_QUERYUSER2_LOGINSTATUS is '';
	comment on column A_QUERYUSER2_LOGINSTATUS.LOGINCNT is '';
	comment on column A_QUERYUSER2_LOGINSTATUS.TRADECNT is '';
	comment on column A_QUERYUSER2_LOGINSTATUS.LOGINTYPE is '';
	comment on column A_QUERYUSER2_LOGINSTATUS.TRADEDATE is '';


spool off
quit;

