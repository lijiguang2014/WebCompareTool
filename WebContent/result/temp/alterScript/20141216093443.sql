create table YC_USERS1 (
		NOTIFYTIME CHAR(8)  ,
		NOTIFYDATE CHAR(10)  ,
		YCDATE CHAR(10)  ,
		OPENDATE CHAR(10)  ,
		STATUS CHAR(1)  ,
		NOTIFYSTATUS CHAR(1)  ,
		PHONE VARCHAR2(20)  ,
		OPENTIME CHAR(8)  ,
		LASTLOGINDATE CHAR(10)  ,
		CLIENTTYPE VARCHAR2(1)  ,
		INITPASSWORD null  ,
		USERTYPE VARCHAR2(1)  ,
		EMAIL VARCHAR2(40)  ,
		PASSWORD null  ,
		POPWINDOWS VARCHAR2(1)  ,
		LASTLOGINTIME CHAR(8)  ,
		DEFAULTCLEARINGTYPE VARCHAR2(10)  ,
		COUNTLOGINTIMES NUMBER(18,0)  ,
		ACTIVEDATE CHAR(10)  ,
		CREATESTATICFILE CHAR(1)  ,
		FIRSTLOGIN CHAR(1)  ,
		COUNTINITLOGINTIMES null  ,
		USERNAME VARCHAR2(72)  ,
		COMPANYID CHAR(4)  ,
		USERID VARCHAR2(22)  ,
);
comment on table YC_USERS1 is 'null';
comment on column YC_USERS1.NOTIFYTIME is '';
comment on column YC_USERS1.NOTIFYDATE is '';
comment on column YC_USERS1.YCDATE is '';
comment on column YC_USERS1.OPENDATE is '';
comment on column YC_USERS1.STATUS is '';
comment on column YC_USERS1.NOTIFYSTATUS is '';
comment on column YC_USERS1.PHONE is '';
comment on column YC_USERS1.OPENTIME is '';
comment on column YC_USERS1.LASTLOGINDATE is '';
comment on column YC_USERS1.CLIENTTYPE is '';
comment on column YC_USERS1.INITPASSWORD is '';
comment on column YC_USERS1.USERTYPE is '';
comment on column YC_USERS1.EMAIL is '';
comment on column YC_USERS1.PASSWORD is '';
comment on column YC_USERS1.POPWINDOWS is '';
comment on column YC_USERS1.LASTLOGINTIME is '';
comment on column YC_USERS1.DEFAULTCLEARINGTYPE is '';
comment on column YC_USERS1.COUNTLOGINTIMES is '';
comment on column YC_USERS1.ACTIVEDATE is '';
comment on column YC_USERS1.CREATESTATICFILE is '';
comment on column YC_USERS1.FIRSTLOGIN is '';
comment on column YC_USERS1.COUNTINITLOGINTIMES is '';
comment on column YC_USERS1.USERNAME is '';
comment on column YC_USERS1.COMPANYID is '';
comment on column YC_USERS1.USERID is '';
	
alter table A_TEMP_LOGINRANK add column SHORTNAME1 TY_TRSEQ  ;
	
alter table A_QUERYUSER2_LOGINSTATUS drop column LOGINTYPE;
	
