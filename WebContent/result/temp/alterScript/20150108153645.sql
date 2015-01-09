
alter table D_COMPCLIENTOPTEXERCISE add column EXECMARGIN NUMBER(15,3)  ;
alter table D_COMPCLIENTOPTEXERCISE add column FREEZFUNDS NUMBER(20,3)  ;
	
alter table D_COMPCLIENTOPTLIQUID add column CUFLAG CHAR(1)  ;
	
alter table D_COMPCLIENTOPTPOS add column CUFLAG CHAR(1)  ;
	
alter table D_COMPCLIENTOPTPOSDETAIL add column CUFLAG CHAR(1)  ;
	
alter table D_COMPCLIENTOPTTRADE add column CUFLAG CHAR(1)  ;
	
comment on table H_COMPCASHMORTGAGE is '货币充抵资金文件';
comment on column H_COMPCASHMORTGAGE.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPCASHMORTGAGE.AMOUNT_IN is '充抵金额';
comment on column H_COMPCASHMORTGAGE.EXCHANGERATE is '充抵汇率';
comment on column H_COMPCASHMORTGAGE.CURRENCY_IN is '充抵目标币种';
comment on column H_COMPCASHMORTGAGE.CURRENCY_OUT is '原币种';
comment on column H_COMPCASHMORTGAGE.AMOUNT_OUT is '原币种余额';
comment on column H_COMPCASHMORTGAGE.DISCOUNT is '充抵折扣率';
comment on column H_COMPCASHMORTGAGE.NOTES is '备注';
comment on column H_COMPCASHMORTGAGE.TRADEDATE is '日期';
	
alter table H_COMPCLIENTFUND add column FREEZFUNDS NUMBER(20,3)  ;
comment on column H_COMPCLIENTFUND.LASTRIGHTBYDATE is '上日结存（逐笔对冲）';
comment on column H_COMPCLIENTFUND.TODAYRIGHTBYTRADE is '当日结存（逐笔对冲）';
	
alter table H_COMPCLIENTINFO add column SECUROPENDATE VARCHAR2(10)  ;
alter table H_COMPCLIENTINFO add column SECURACCOUNT VARCHAR2(18)  ;
alter table H_COMPCLIENTINFO add column ISSUBASSET CHAR(1)  ;
	
comment on table H_COMPCLIENTOPTLIQUID is '期权平仓明细文件';
alter table H_COMPCLIENTOPTLIQUID add column CUFLAG CHAR(1)  ;
comment on column H_COMPCLIENTOPTLIQUID.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPCLIENTOPTLIQUID.LASTSETTLEPRICE is '昨结算价';
comment on column H_COMPCLIENTOPTLIQUID.OPENPRICE is '开仓价';
comment on column H_COMPCLIENTOPTLIQUID.LIQUIDOPTPAYMENT is '权利金';
comment on column H_COMPCLIENTOPTLIQUID.TRANSDATE is '成交日期';
comment on column H_COMPCLIENTOPTLIQUID.CONTRACTID is '品种合约';
comment on column H_COMPCLIENTOPTLIQUID.TRADESEQ is '成交流水号';
comment on column H_COMPCLIENTOPTLIQUID.OPENTRADESEQ is '原成交流水号';
comment on column H_COMPCLIENTOPTLIQUID.CURRENCY is '币种';
comment on column H_COMPCLIENTOPTLIQUID.BSTAG is '买卖标志';
comment on column H_COMPCLIENTOPTLIQUID.VOLUMN is '成交量';
comment on column H_COMPCLIENTOPTLIQUID.SETTLEMENTPRICE is '今结算价';
comment on column H_COMPCLIENTOPTLIQUID.OPENOPTPAYMENT is '开仓权利金';
comment on column H_COMPCLIENTOPTLIQUID.EXCLIENTID is '交易编码';
comment on column H_COMPCLIENTOPTLIQUID.TRADEDATE is '日期';
comment on column H_COMPCLIENTOPTLIQUID.LIQUIDPRICE is '成交价';
	
comment on table H_COMPCLIENTOPTPOS is '期权持仓数据文件';
alter table H_COMPCLIENTOPTPOS add column CUFLAG CHAR(1)  ;
comment on column H_COMPCLIENTOPTPOS.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPCLIENTOPTPOS.LASTSETTLEPRICE is '今结算价';
comment on column H_COMPCLIENTOPTPOS.POSITIONPROFITBYDATE is '持仓盈亏(逐日盯市)';
comment on column H_COMPCLIENTOPTPOS.VHFLAG is '投机套保标志';
comment on column H_COMPCLIENTOPTPOS.BSTAG is '买卖标志';
comment on column H_COMPCLIENTOPTPOS.EXCHANGEID is '交易所统一标识';
comment on column H_COMPCLIENTOPTPOS.EXCLIENTID is '交易编码';
comment on column H_COMPCLIENTOPTPOS.POSITION is '持仓量';
comment on column H_COMPCLIENTOPTPOS.TRADEDATE is '日期';
comment on column H_COMPCLIENTOPTPOS.AVERAGEPRICE is '持仓均价';
comment on column H_COMPCLIENTOPTPOS.POSITIONPROFITBYTRADE is '持仓盈亏(逐笔对冲)';
comment on column H_COMPCLIENTOPTPOS.MARGIN is '交易保证金';
comment on column H_COMPCLIENTOPTPOS.CONTRACTID is '品种合约';
comment on column H_COMPCLIENTOPTPOS.OPTTYPE is '期权类型';
comment on column H_COMPCLIENTOPTPOS.NONSETTLEMEMDATA is '是否为交易会员';
comment on column H_COMPCLIENTOPTPOS.STRIKEPRICE is '执行价';
comment on column H_COMPCLIENTOPTPOS.CURRENCY is '币种';
comment on column H_COMPCLIENTOPTPOS.SETTLEMENTPRICE is '昨结算价';
alter table H_COMPCLIENTOPTPOS modify(BASEPRODUCTID VARCHAR2(6));
comment on column H_COMPCLIENTOPTPOS.BASEPRODUCTID is '标的品种';
comment on column H_COMPCLIENTOPTPOS.BASECONTRACTID is '标的合约';
	
comment on table H_COMPCLIENTOPTPOSDETAIL is '期权持仓明细文件';
alter table H_COMPCLIENTOPTPOSDETAIL add column CUFLAG CHAR(1)  ;
comment on column H_COMPCLIENTOPTPOSDETAIL.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPCLIENTOPTPOSDETAIL.LASTSETTLEPRICE is '昨结算价';
comment on column H_COMPCLIENTOPTPOSDETAIL.OPENPRICE is '开仓价';
comment on column H_COMPCLIENTOPTPOSDETAIL.TRANSDATE is '成交日期';
comment on column H_COMPCLIENTOPTPOSDETAIL.POSITIONPROFITBYTRADE is '持仓盈亏(逐笔对冲)';
comment on column H_COMPCLIENTOPTPOSDETAIL.MARGIN is '交易保证金';
comment on column H_COMPCLIENTOPTPOSDETAIL.CONTRACTID is '品种合约';
comment on column H_COMPCLIENTOPTPOSDETAIL.POSITIONPROFITBYDATE is '持仓盈亏(逐日盯市)';
comment on column H_COMPCLIENTOPTPOSDETAIL.TRADESEQ is '成交流水号';
comment on column H_COMPCLIENTOPTPOSDETAIL.VHFLAG is '投机套保标志';
comment on column H_COMPCLIENTOPTPOSDETAIL.CURRENCY is '币种';
comment on column H_COMPCLIENTOPTPOSDETAIL.BSTAG is '买卖标志';
comment on column H_COMPCLIENTOPTPOSDETAIL.SETTLEMENTPRICE is '今结算价';
comment on column H_COMPCLIENTOPTPOSDETAIL.EXCHANGEID is '交易所id';
comment on column H_COMPCLIENTOPTPOSDETAIL.EXCLIENTID is '交易编码';
comment on column H_COMPCLIENTOPTPOSDETAIL.POSITION is '持仓量';
comment on column H_COMPCLIENTOPTPOSDETAIL.TRADEDATE is '日期';
	
comment on table H_COMPCLIENTOPTTRADE is '期权成交明细文件';
alter table H_COMPCLIENTOPTTRADE add column CUFLAG CHAR(1)  ;
comment on column H_COMPCLIENTOPTTRADE.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPCLIENTOPTTRADE.PRICE is '权利金单价';
comment on column H_COMPCLIENTOPTTRADE.TRANSDATE is '成交日期';
comment on column H_COMPCLIENTOPTTRADE.TRADESEQ is '成交流水号';
comment on column H_COMPCLIENTOPTTRADE.VHFLAG is '投机套保标志';
comment on column H_COMPCLIENTOPTTRADE.ORDERID is '报单号';
comment on column H_COMPCLIENTOPTTRADE.BSTAG is '买卖标志';
comment on column H_COMPCLIENTOPTTRADE.VOLUMN is '成交量';
comment on column H_COMPCLIENTOPTTRADE.TRADETIME is '成交时间';
comment on column H_COMPCLIENTOPTTRADE.EXCHANGEID is '交易所统一标识';
comment on column H_COMPCLIENTOPTTRADE.SEATNO is '席位号';
comment on column H_COMPCLIENTOPTTRADE.EXCLIENTID is '交易编码';
comment on column H_COMPCLIENTOPTTRADE.TRADEDATE is '日期';
comment on column H_COMPCLIENTOPTTRADE.TRADEFEE is '手续费';
comment on column H_COMPCLIENTOPTTRADE.CONTRACTID is '品种合约';
comment on column H_COMPCLIENTOPTTRADE.AMOUNT is '权利金';
comment on column H_COMPCLIENTOPTTRADE.OPTTYPE is '期权类型';
comment on column H_COMPCLIENTOPTTRADE.NONSETTLEMEMDATA is '是否为交易会员';
comment on column H_COMPCLIENTOPTTRADE.STRIKEPRICE is '执行价';
comment on column H_COMPCLIENTOPTTRADE.CURRENCY is '币种';
comment on column H_COMPCLIENTOPTTRADE.OCTAG is '开平仓标志';
alter table H_COMPCLIENTOPTTRADE modify(BASEPRODUCTID VARCHAR2(6));
comment on column H_COMPCLIENTOPTTRADE.BASEPRODUCTID is '标的品种';
comment on column H_COMPCLIENTOPTTRADE.BASECONTRACTID is '标的合约';
	
comment on column H_COMPCLIENTPOS.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPCLIENTPOS.LASTSETTLEPRICE is '昨结算价';
comment on column H_COMPCLIENTPOS.AVERAGEPRICE is '持仓均价';
comment on column H_COMPCLIENTPOS.POSITIONPROFITBYTRADE is '持仓盈亏(逐笔对冲)';
comment on column H_COMPCLIENTPOS.CONTRACTID is '品种合约';
comment on column H_COMPCLIENTPOS.TRADEMARGIN is '交易保证金';
comment on column H_COMPCLIENTPOS.POSITIONPROFIT is '持仓盈亏(逐日盯市)';
comment on column H_COMPCLIENTPOS.NONSETTLEMEMDATA is '是否为交易会员';
comment on column H_COMPCLIENTPOS.SETTLEPRICE is '今结算价';
comment on column H_COMPCLIENTPOS.VHFLAG is '投机套保标志';
comment on column H_COMPCLIENTPOS.CURRENCY is '币种';
comment on column H_COMPCLIENTPOS.BSTAG is '买卖标志';
comment on column H_COMPCLIENTPOS.EXCHANGEID is '交易所统一标识';
comment on column H_COMPCLIENTPOS.EXCLIENTID is '交易编码';
comment on column H_COMPCLIENTPOS.POSITION is '持仓量';
comment on column H_COMPCLIENTPOS.TRADEDATE is '日期';
	
comment on column H_COMPCLIENTTRADE.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPCLIENTTRADE.PRICE is '成交价';
comment on column H_COMPCLIENTTRADE.TRADESEQ is '成交流水号';
comment on column H_COMPCLIENTTRADE.VHFLAG is '投机套保标志';
comment on column H_COMPCLIENTTRADE.ORDERID is '报单号';
comment on column H_COMPCLIENTTRADE.BSTAG is '买卖标志';
comment on column H_COMPCLIENTTRADE.VOLUMN is '成交量';
comment on column H_COMPCLIENTTRADE.TRADETIME is '成交时间';
comment on column H_COMPCLIENTTRADE.SEATNO is '席位号';
comment on column H_COMPCLIENTTRADE.CLOSEPROFIT is '平仓盈亏(逐日盯市)';
comment on column H_COMPCLIENTTRADE.TRADEDATE is '日期';
comment on column H_COMPCLIENTTRADE.TRADEFEE is '交易所统一标识';
comment on column H_COMPCLIENTTRADE.CONTRACTID is '品种合约';
comment on column H_COMPCLIENTTRADE.AMOUNT is '成交额';
comment on column H_COMPCLIENTTRADE.UPLOADDATE is '平仓盈亏(逐笔对冲)';
comment on column H_COMPCLIENTTRADE.NONSETTLEMEMDATA is '是否为交易会员';
comment on column H_COMPCLIENTTRADE.CLOSEPROFITBYTRADE is '交易编码';
comment on column H_COMPCLIENTTRADE.CHECKTAG is '手续费';
comment on column H_COMPCLIENTTRADE.TRADINGCOMPID is '成交日期';
comment on column H_COMPCLIENTTRADE.OCTAG is '开平仓标志';
	
comment on table H_COMPDELIVCONTRACTDATA is '期货待交割结算合约文件';
comment on column H_COMPDELIVCONTRACTDATA.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPDELIVCONTRACTDATA.OPENPRICE is '开仓价';
comment on column H_COMPDELIVCONTRACTDATA.DELIVSETTLEPRICE is '交割结算价';
comment on column H_COMPDELIVCONTRACTDATA.CONTRACTID is '品种合约';
comment on column H_COMPDELIVCONTRACTDATA.DELIVMARGIN is '交割保证金';
comment on column H_COMPDELIVCONTRACTDATA.NONSETTLEMEMDATA is '是否为交易会员';
comment on column H_COMPDELIVCONTRACTDATA.TRADESEQ is '成交流水号';
comment on column H_COMPDELIVCONTRACTDATA.CURRENCY is '币种';
comment on column H_COMPDELIVCONTRACTDATA.BSTAG is '买卖标志';
comment on column H_COMPDELIVCONTRACTDATA.EXCHANGEID is '交易所统一标识';
comment on column H_COMPDELIVCONTRACTDATA.EXCLIENTID is '交易编码';
comment on column H_COMPDELIVCONTRACTDATA.POSITION is '待交割持仓量';
comment on column H_COMPDELIVCONTRACTDATA.TRADEDATE is '日期';
	
comment on table H_COMPEXCHANGEDETAILS is '汇兑明细文件';
comment on column H_COMPEXCHANGEDETAILS.DIRECTION is '记账流水号';
comment on column H_COMPEXCHANGEDETAILS.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPEXCHANGEDETAILS.DMSAMOUNT is '本币金额';
comment on column H_COMPEXCHANGEDETAILS.BUSINESSTYPE is '换汇业务种类';
comment on column H_COMPEXCHANGEDETAILS.DMSACCOUNTNO is '本币账号';
comment on column H_COMPEXCHANGEDETAILS.TRANSDATE is '汇兑日期';
comment on column H_COMPEXCHANGEDETAILS.EXCHANGERATE is '当笔兑换汇率';
comment on column H_COMPEXCHANGEDETAILS.FGNAMOUNT is '外币金额';
comment on column H_COMPEXCHANGEDETAILS.DMSCURRENCY is '本币币种';
comment on column H_COMPEXCHANGEDETAILS.TRADESEQ is '换汇方向';
comment on column H_COMPEXCHANGEDETAILS.DMSACCOUNTNAME is '本币账户名称';
comment on column H_COMPEXCHANGEDETAILS.FGNACCOUNTNAME is '外币账户名称';
comment on column H_COMPEXCHANGEDETAILS.FGNCURRENCY is '外币币种';
comment on column H_COMPEXCHANGEDETAILS.FGNACCOUNTNO is '外币账号';
comment on column H_COMPEXCHANGEDETAILS.TRANSTIME is '交易时间';
comment on column H_COMPEXCHANGEDETAILS.NOTES is '备注';
comment on column H_COMPEXCHANGEDETAILS.TRADEDATE is '日期';
	
comment on table H_COMPMORTGAGEDETAILS is '非货币充抵明细文件';
comment on column H_COMPMORTGAGEDETAILS.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPMORTGAGEDETAILS.PRICE is '充抵价格';
comment on column H_COMPMORTGAGEDETAILS.CURRENCY is '币种';
comment on column H_COMPMORTGAGEDETAILS.VOLUMN is '充抵手数';
comment on column H_COMPMORTGAGEDETAILS.COMMODITYID is '充抵品名称';
comment on column H_COMPMORTGAGEDETAILS.EXCHANGEID is '交易所id';
comment on column H_COMPMORTGAGEDETAILS.AMOUNT is '充抵金额';
comment on column H_COMPMORTGAGEDETAILS.TRADEDATE is '日期';
	
comment on table H_COMPOTHERINFO is '其它需要说明的信息或数据文件';
comment on column H_COMPOTHERINFO.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPOTHERINFO.CONTENT is '描述';
comment on column H_COMPOTHERINFO.TYPE is '事由';
comment on column H_COMPOTHERINFO.TRADEDATE is '日期';
comment on column H_COMPOTHERINFO.NONSETTLEMEMDATA is '是否为交易会员';
	
alter table H_STANDCLIOPTTRDDETAIL modify(BASEPRODUCTID VARCHAR2(6));
	
create table H_CLRMEMBER (
		CHECKTAG CHAR(4)  
		,MENBERNAME VARCHAR2(40)  
		,TRADETYPE CHAR(1)  
		,SHORTNAME VARCHAR2(10)  
		,SETTLETYPE CHAR(1)  
		,MEMBERNUM VARCHAR2(5)  
		,UPLOADDATE CHAR(10)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table H_CLRMEMBER is '会员基本资料文件';
comment on column H_CLRMEMBER.CHECKTAG is '检查标识';
comment on column H_CLRMEMBER.MENBERNAME is '会员名称';
comment on column H_CLRMEMBER.TRADETYPE is '会员交易类型';
comment on column H_CLRMEMBER.SHORTNAME is '会员简称';
comment on column H_CLRMEMBER.SETTLETYPE is '会员结算类型';
comment on column H_CLRMEMBER.MEMBERNUM is '会员号';
comment on column H_CLRMEMBER.UPLOADDATE is '上报日期';
comment on column H_CLRMEMBER.TRADEDATE is '日期';
	
create table H_CLRCUSTOMER (
		ORGNUMBER VARCHAR2(40)  
		,SUBNUMBER VARCHAR2(10)  
		,TRADETYPE CHAR(1)  
		,CONTACTS VARCHAR2(40)  
		,AUTHORTYPE CHAR(1)  
		,OPENDATE VARCHAR2(10)  
		,ORGDEADLINE VARCHAR2(10)  
		,SECURITIESID VARCHAR2(10)  
		,PHONE VARCHAR2(40)  
		,BUSINESSNUM VARCHAR2(40)  
		,CONTACTCOUNTRY CHAR(3)  
		,POSTALCODE VARCHAR2(6)  
		,READDRESS VARCHAR2(200)  
		,VALIDIDENTITY VARCHAR2(40)  
		,MENBERNUM VARCHAR2(5)  
		,OCFLAG CHAR(1)  
		,POSTALADDRESS VARCHAR2(200)  
		,AUTHORNAME VARCHAR2(40)  
		,TRADEDATE VARCHAR2(10)  
		,LEGALPERSON VARCHAR2(40)  
		,IDENTITYNUM VARCHAR2(40)  
		,COUNTRY CHAR(3)  
		,ADDRESS VARCHAR2(40)  
		,CUSTOMERTYPE CHAR(1)  
		,UPLOADDATE CHAR(10)  
		,IDDEADLINE VARCHAR2(10)  
		,OVERSEASFLAG CHAR(1)  
		,CUSTOMERNAME VARCHAR2(200)  
		,PASSPORT VARCHAR2(50)  
		,DERIVATIVENUM VARCHAR2(13)  
		,CHECKTAG CHAR(4)  
		,CONTACTADDR VARCHAR2(200)  
		,ACCOUNTSTATE CHAR(1)  
		,MAILADDRESS VARCHAR2(100)  
		,AUTHORIDENTITY VARCHAR2(40)  
);


comment on table H_CLRCUSTOMER is '客户基本资料文件';
comment on column H_CLRCUSTOMER.ORGNUMBER is '组织机构代码证号';
comment on column H_CLRCUSTOMER.SUBNUMBER is '二级代理商编号';
comment on column H_CLRCUSTOMER.TRADETYPE is '交易编码类型';
comment on column H_CLRCUSTOMER.CONTACTS is '联系人';
comment on column H_CLRCUSTOMER.AUTHORTYPE is '有效身份证明文件类别';
comment on column H_CLRCUSTOMER.OPENDATE is '客户开户日期';
comment on column H_CLRCUSTOMER.ORGDEADLINE is '组织机构代码证有效期截止日期';
comment on column H_CLRCUSTOMER.SECURITIESID is '客户证券账户';
comment on column H_CLRCUSTOMER.PHONE is '联系电话';
comment on column H_CLRCUSTOMER.BUSINESSNUM is '商业登记证号';
comment on column H_CLRCUSTOMER.CONTACTCOUNTRY is '经办人国籍/地区';
comment on column H_CLRCUSTOMER.POSTALCODE is '邮政编码';
comment on column H_CLRCUSTOMER.READDRESS is '注册地址';
comment on column H_CLRCUSTOMER.VALIDIDENTITY is '有效身份证明文件号码';
comment on column H_CLRCUSTOMER.MENBERNUM is '所属会员号';
comment on column H_CLRCUSTOMER.OCFLAG is '开户和销户标志';
comment on column H_CLRCUSTOMER.POSTALADDRESS is '通讯地址';
comment on column H_CLRCUSTOMER.AUTHORNAME is '开户授权人名称';
comment on column H_CLRCUSTOMER.TRADEDATE is '日期';
comment on column H_CLRCUSTOMER.LEGALPERSON is '法定代表人、执行事务合伙人或负责人';
comment on column H_CLRCUSTOMER.IDENTITYNUM is '身份证';
comment on column H_CLRCUSTOMER.COUNTRY is '国籍/地区 ';
comment on column H_CLRCUSTOMER.ADDRESS is '所在地';
comment on column H_CLRCUSTOMER.CUSTOMERTYPE is '客户类型';
comment on column H_CLRCUSTOMER.UPLOADDATE is '上报日期';
comment on column H_CLRCUSTOMER.IDDEADLINE is '身份证明文件有效期截止日期';
comment on column H_CLRCUSTOMER.OVERSEASFLAG is '境外客户标识';
comment on column H_CLRCUSTOMER.CUSTOMERNAME is '名称';
comment on column H_CLRCUSTOMER.PASSPORT is '护照号码，港澳台通行证号码, 或外国永久居留证号码';
comment on column H_CLRCUSTOMER.DERIVATIVENUM is '客户衍生品合约账户';
comment on column H_CLRCUSTOMER.CHECKTAG is '检查标识';
comment on column H_CLRCUSTOMER.CONTACTADDR is '经办人联系地址';
comment on column H_CLRCUSTOMER.ACCOUNTSTATE is '账户休眠状态';
comment on column H_CLRCUSTOMER.MAILADDRESS is '电子邮件地址及网址';
comment on column H_CLRCUSTOMER.AUTHORIDENTITY is '开户授权人有效身份证明文件号码';
	
create table H_CLRFIRMFUND (
		FREEZFUNDS NUMBER(20,3)  
		,DELIVERYMARGIN NUMBER(20,3)  
		,OFFSETCHANGEAMOUNT NUMBER(15,3)  
		,TOTALFEE NUMBER(20,3)  
		,ACCOUNTNUM VARCHAR2(25)  
		,TODAYPROFIT NUMBER(15,3)  
		,LOWSETTLEMENTS NUMBER(20,3)  
		,TOTALRIGHTS NUMBER(20,3)  
		,TODAYFUNDS NUMBER(20,3)  
		,MENBERNUM VARCHAR2(5)  
		,MONERYOUT NUMBER(20,3)  
		,NONCHANGEAMOUNT NUMBER(20,3)  
		,SETTLEMENT NUMBER(20,3)  
		,TRADEDATE VARCHAR2(10)  
		,CURRENCYFUND NUMBER(20,3)  
		,CONVERAMOUNT NUMBER(15,3)  
		,OTHERSETTLEFUNDS NUMBER(20,3)  
		,TODAYTOTALRIGHTS NUMBER(20,3)  
		,UPLOADDATE CHAR(10)  
		,TRADEMARGIN NUMBER(20,3)  
		,EXSETTLEFUNDS NUMBER(20,3)  
		,CHECKTAG CHAR(4)  
		,CURRENCY CHAR(3)  
		,ACCOUNTTYPE CHAR(1)  
		,MONERYIN NUMBER(20,3)  
		,OFFSETAMOUNT NUMBER(15,3)  
		,YESTERDAYRIGHTS NUMBER(20,3)  
		,NONAMOUNT NUMBER(20,3)  
);


comment on table H_CLRFIRMFUND is '衍生品资金文件';
comment on column H_CLRFIRMFUND.FREEZFUNDS is '冻结资金';
comment on column H_CLRFIRMFUND.DELIVERYMARGIN is '交割保证金';
comment on column H_CLRFIRMFUND.OFFSETCHANGEAMOUNT is '货币充抵变动额';
comment on column H_CLRFIRMFUND.TOTALFEE is '各类手续费清算值合计';
comment on column H_CLRFIRMFUND.ACCOUNTNUM is '资金账户号码';
comment on column H_CLRFIRMFUND.TODAYPROFIT is '当日总盈亏';
comment on column H_CLRFIRMFUND.LOWSETTLEMENTS is '最低结算准备金';
comment on column H_CLRFIRMFUND.TOTALRIGHTS is '会员权益总额';
comment on column H_CLRFIRMFUND.TODAYFUNDS is '当日资金交收合计';
comment on column H_CLRFIRMFUND.MENBERNUM is '会员号';
comment on column H_CLRFIRMFUND.MONERYOUT is '出金';
comment on column H_CLRFIRMFUND.NONCHANGEAMOUNT is '非货币充抵变动额';
comment on column H_CLRFIRMFUND.SETTLEMENT is '结算准备金';
comment on column H_CLRFIRMFUND.TRADEDATE is '日期 ';
comment on column H_CLRFIRMFUND.CURRENCYFUND is '实有货币资金';
comment on column H_CLRFIRMFUND.CONVERAMOUNT is '货币折抵金额';
comment on column H_CLRFIRMFUND.OTHERSETTLEFUNDS is '其它交收资金清算值合计';
comment on column H_CLRFIRMFUND.TODAYTOTALRIGHTS is '当日总权利金';
comment on column H_CLRFIRMFUND.UPLOADDATE is '上报日期';
comment on column H_CLRFIRMFUND.TRADEMARGIN is '交易保证金';
comment on column H_CLRFIRMFUND.EXSETTLEFUNDS is '行权交收资金清算值合计';
comment on column H_CLRFIRMFUND.CHECKTAG is '检查标识';
comment on column H_CLRFIRMFUND.CURRENCY is '币种';
comment on column H_CLRFIRMFUND.ACCOUNTTYPE is '资金账户类型';
comment on column H_CLRFIRMFUND.MONERYIN is '入金';
comment on column H_CLRFIRMFUND.OFFSETAMOUNT is '货币充抵金额';
comment on column H_CLRFIRMFUND.YESTERDAYRIGHTS is '上日会员权益总额';
comment on column H_CLRFIRMFUND.NONAMOUNT is '非货币充抵金额';
	
create table H_CLRFUNDCHG (
		INOUTDATE VARCHAR2(10)  
		,CHECKTAG CHAR(4)  
		,ACCOUNTNUM VARCHAR2(25)  
		,CURRENCY CHAR(3)  
		,INOUTACCOUNTTYPE CHAR(1)  
		,BANKID CHAR(2)  
		,INOUTTYPE CHAR(1)  
		,ACCOUNTTYPE CHAR(1)  
		,FUNDCHGAMOUNT NUMBER(20,3)  
		,MEMBERNUM VARCHAR2(5)  
		,UPLOADDATE CHAR(10)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table H_CLRFUNDCHG is '期货公司出入金文件';
comment on column H_CLRFUNDCHG.INOUTDATE is '出入金发生日期';
comment on column H_CLRFUNDCHG.CHECKTAG is '检查标识';
comment on column H_CLRFUNDCHG.ACCOUNTNUM is '资金账户号码';
comment on column H_CLRFUNDCHG.CURRENCY is '币种';
comment on column H_CLRFUNDCHG.INOUTACCOUNTTYPE is '出入金账户类型';
comment on column H_CLRFUNDCHG.BANKID is '银行统一标识';
comment on column H_CLRFUNDCHG.INOUTTYPE is '出入金类型';
comment on column H_CLRFUNDCHG.ACCOUNTTYPE is '资金账户类型';
comment on column H_CLRFUNDCHG.FUNDCHGAMOUNT is '资金变动额';
comment on column H_CLRFUNDCHG.MEMBERNUM is '会员号';
comment on column H_CLRFUNDCHG.UPLOADDATE is '上报日期';
comment on column H_CLRFUNDCHG.TRADEDATE is '日期';
	
create table H_CLRCUSFUND (
		FUNDAMOUNT NUMBER(20,3)  
		,DERIVATIVENUM VARCHAR2(13)  
		,CHECKTAG CHAR(4)  
		,ACCOUNTNUM VARCHAR2(25)  
		,CURRENCY CHAR(3)  
		,FUNDNUM VARCHAR2(4)  
		,MEMBERNUM VARCHAR2(5)  
		,UPLOADDATE CHAR(10)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table H_CLRCUSFUND is '衍生品分项资金文件';
comment on column H_CLRCUSFUND.FUNDAMOUNT is '资金金额';
comment on column H_CLRCUSFUND.DERIVATIVENUM is '客户衍生品合约账户';
comment on column H_CLRCUSFUND.CHECKTAG is '检查标识';
comment on column H_CLRCUSFUND.ACCOUNTNUM is '资金账户号码';
comment on column H_CLRCUSFUND.CURRENCY is '币种';
comment on column H_CLRCUSFUND.FUNDNUM is '资金项目编号';
comment on column H_CLRCUSFUND.MEMBERNUM is '会员号';
comment on column H_CLRCUSFUND.UPLOADDATE is '上报日期';
comment on column H_CLRCUSFUND.TRADEDATE is '日期';
	
create table H_CLROPTTRDDATA (
		BSFLAG CHAR(1)  
		,OPTIONMONEY NUMBER(20,3)  
		,CUFLAG CHAR(1)  
		,TRANSDATE VARCHAR2(10)  
		,CPTYPE CHAR(1)  
		,CLOSETIME VARCHAR2(10)  
		,OLFLAG CHAR(1)  
		,UPLOADDATE CHAR(10)  
		,DERIVATIVENUM VARCHAR2(13)  
		,CHECKTAG CHAR(4)  
		,VHFLAG CHAR(1)  
		,CURRENCY CHAR(3)  
		,VOLUMN NUMBER(16)  
		,OPTIONPRICE NUMBER(17,9)  
		,INSTRUMENTID VARCHAR2(30)  
		,STRICKPRICE NUMBER(20,9)  
		,TRANSNUM VARCHAR2(16)  
		,MEMBERNUM VARCHAR2(5)  
		,BASEPRODUCTID VARCHAR2(6)  
		,BASECONTRACTID VARCHAR2(30)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table H_CLROPTTRDDATA is '衍生品分项资金文件';
comment on column H_CLROPTTRDDATA.BSFLAG is '买卖标志';
comment on column H_CLROPTTRDDATA.OPTIONMONEY is '权利金';
comment on column H_CLROPTTRDDATA.CUFLAG is '备兑标志';
comment on column H_CLROPTTRDDATA.TRANSDATE is '成交日期';
comment on column H_CLROPTTRDDATA.CPTYPE is '期权类型';
comment on column H_CLROPTTRDDATA.CLOSETIME is '成交时间';
comment on column H_CLROPTTRDDATA.OLFLAG is '开平仓标志';
comment on column H_CLROPTTRDDATA.UPLOADDATE is '上报日期';
comment on column H_CLROPTTRDDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column H_CLROPTTRDDATA.CHECKTAG is '检查标识';
comment on column H_CLROPTTRDDATA.VHFLAG is '投机套保标志';
comment on column H_CLROPTTRDDATA.CURRENCY is '币种';
comment on column H_CLROPTTRDDATA.VOLUMN is '成交量';
comment on column H_CLROPTTRDDATA.OPTIONPRICE is '权利金单价';
comment on column H_CLROPTTRDDATA.INSTRUMENTID is '品种合约';
comment on column H_CLROPTTRDDATA.STRICKPRICE is '执行价';
comment on column H_CLROPTTRDDATA.TRANSNUM is '成交流水号';
comment on column H_CLROPTTRDDATA.MEMBERNUM is '会员号';
comment on column H_CLROPTTRDDATA.BASEPRODUCTID is '标的品种';
comment on column H_CLROPTTRDDATA.BASECONTRACTID is '标的合约';
comment on column H_CLROPTTRDDATA.TRADEDATE is '日期';
	
create table H_CLROPTHOLDDATA (
		BSFLAG CHAR(1)  
		,TODSETTLEPRICE NUMBER(20,3)  
		,CUFLAG CHAR(1)  
		,CPTYPE CHAR(1)  
		,POSPROFIT NUMBER(15,3)  
		,UPLOADDATE CHAR(10)  
		,TRADEMARGIN NUMBER(20,3)  
		,DERIVATIVENUM VARCHAR2(13)  
		,CHECKTAG CHAR(4)  
		,VHFLAG CHAR(1)  
		,CURRENCY CHAR(3)  
		,INSTRUMENTID VARCHAR2(30)  
		,STRICKPRICE NUMBER(20,9)  
		,MEMBERNUM VARCHAR2(5)  
		,BASEPRODUCTID VARCHAR2(6)  
		,POSITION NUMBER(16)  
		,BASECONTRACTID VARCHAR2(30)  
		,TRADEDATE VARCHAR2(10)  
		,YESSETTLEPRICE NUMBER(20,3)  
);


comment on table H_CLROPTHOLDDATA is '衍生品持仓明细文件';
comment on column H_CLROPTHOLDDATA.BSFLAG is '买卖标志';
comment on column H_CLROPTHOLDDATA.TODSETTLEPRICE is '今结算价';
comment on column H_CLROPTHOLDDATA.CUFLAG is '备兑标志';
comment on column H_CLROPTHOLDDATA.CPTYPE is '期权类型';
comment on column H_CLROPTHOLDDATA.POSPROFIT is '持仓盈亏';
comment on column H_CLROPTHOLDDATA.UPLOADDATE is '上报日期';
comment on column H_CLROPTHOLDDATA.TRADEMARGIN is '交易保证金';
comment on column H_CLROPTHOLDDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column H_CLROPTHOLDDATA.CHECKTAG is '检查标识';
comment on column H_CLROPTHOLDDATA.VHFLAG is '投机套保标志';
comment on column H_CLROPTHOLDDATA.CURRENCY is '币种';
comment on column H_CLROPTHOLDDATA.INSTRUMENTID is '品种合约';
comment on column H_CLROPTHOLDDATA.STRICKPRICE is '执行价';
comment on column H_CLROPTHOLDDATA.MEMBERNUM is '会员号';
comment on column H_CLROPTHOLDDATA.BASEPRODUCTID is '标的品种';
comment on column H_CLROPTHOLDDATA.POSITION is '持仓量';
comment on column H_CLROPTHOLDDATA.BASECONTRACTID is '标的合约';
comment on column H_CLROPTHOLDDATA.TRADEDATE is '日期';
comment on column H_CLROPTHOLDDATA.YESSETTLEPRICE is '昨结算价';
	
create table H_CLROPTEXERDATA (
		BSFLAG CHAR(1)  
		,EXECDATE VARCHAR2(10)  
		,FREEZFUNDS NUMBER(20,3)  
		,CPTYPE CHAR(1)  
		,UPLOADDATE CHAR(10)  
		,EXECTIME VARCHAR2(10)  
		,DERIVATIVENUM VARCHAR2(13)  
		,CHECKTAG CHAR(4)  
		,EXECFIXFUND NUMBER(20,3)  
		,VHFLAG CHAR(1)  
		,EXECPRICE NUMBER(20,9)  
		,CURRENCY CHAR(3)  
		,EXECFEE NUMBER(20,3)  
		,EXECNUM NUMBER(16)  
		,INSTRUMENTID VARCHAR2(30)  
		,TRANSNUM VARCHAR2(16)  
		,MEMBERNUM VARCHAR2(5)  
		,EXECPROFIT NUMBER(15,3)  
		,BASEPRODUCTID VARCHAR2(6)  
		,BASECONTRACTID VARCHAR2(30)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table H_CLROPTEXERDATA is '衍生品行权明细文件';
comment on column H_CLROPTEXERDATA.BSFLAG is '买卖标志';
comment on column H_CLROPTEXERDATA.EXECDATE is '执行日期';
comment on column H_CLROPTEXERDATA.FREEZFUNDS is '冻结资金';
comment on column H_CLROPTEXERDATA.CPTYPE is '期权类型';
comment on column H_CLROPTEXERDATA.UPLOADDATE is '上报日期';
comment on column H_CLROPTEXERDATA.EXECTIME is '执行时间';
comment on column H_CLROPTEXERDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column H_CLROPTEXERDATA.CHECKTAG is '检查标识';
comment on column H_CLROPTEXERDATA.EXECFIXFUND is '行权锁定保证金';
comment on column H_CLROPTEXERDATA.VHFLAG is '投机套保标志';
comment on column H_CLROPTEXERDATA.EXECPRICE is '执行价';
comment on column H_CLROPTEXERDATA.CURRENCY is '币种';
comment on column H_CLROPTEXERDATA.EXECFEE is '行权结算费（手续费）';
comment on column H_CLROPTEXERDATA.EXECNUM is '执行手数';
comment on column H_CLROPTEXERDATA.INSTRUMENTID is '品种合约';
comment on column H_CLROPTEXERDATA.TRANSNUM is '流水号';
comment on column H_CLROPTEXERDATA.MEMBERNUM is '会员号';
comment on column H_CLROPTEXERDATA.EXECPROFIT is '行权盈亏';
comment on column H_CLROPTEXERDATA.BASEPRODUCTID is '标的品种';
comment on column H_CLROPTEXERDATA.BASECONTRACTID is '标的合约';
comment on column H_CLROPTEXERDATA.TRADEDATE is '日期';
	
create table H_CLRSEFUND (
		SETTLEDATE VARCHAR2(10)  
		,SELLAMOUNT NUMBER(20,3)  
		,HANDFEE NUMBER(18,3)  
		,MEMBERDATE VARCHAR2(8)  
		,SECFEE NUMBER(18,3)  
		,NOTE VARCHAR2(40)  
		,UPLOADDATE CHAR(10)  
		,CLEARDATE VARCHAR2(10)  
		,CLEARAMOUNT NUMBER(20,3)  
		,TRANSFERFEE NUMBER(18,3)  
		,STAMPTAX NUMBER(18,3)  
		,CHECKTAG CHAR(4)  
		,ACCOUNTNUM VARCHAR2(25)  
		,CURRENCY CHAR(3)  
		,BUYAMOUNT NUMBER(20,3)  
		,TODAYFUNDS NUMBER(20,3)  
		,ACTUALPAY NUMBER(20,3)  
		,LOWSETTLEMENT NUMBER(20,3)  
		,OTHERFEES NUMBER(18,3)  
		,TRADEDATE VARCHAR2(10)  
		,FEE NUMBER(18,3)  
);


comment on table H_CLRSEFUND is '现货资金文件';
comment on column H_CLRSEFUND.SETTLEDATE is '交收日期';
comment on column H_CLRSEFUND.SELLAMOUNT is '净卖金额';
comment on column H_CLRSEFUND.HANDFEE is '经手费';
comment on column H_CLRSEFUND.MEMBERDATE is '会员号';
comment on column H_CLRSEFUND.SECFEE is '证管费';
comment on column H_CLRSEFUND.NOTE is '备注';
comment on column H_CLRSEFUND.UPLOADDATE is '上报日期';
comment on column H_CLRSEFUND.CLEARDATE is '清算日期';
comment on column H_CLRSEFUND.CLEARAMOUNT is '清算金额';
comment on column H_CLRSEFUND.TRANSFERFEE is '过户费';
comment on column H_CLRSEFUND.STAMPTAX is '印花税';
comment on column H_CLRSEFUND.CHECKTAG is '检查标识';
comment on column H_CLRSEFUND.ACCOUNTNUM is '资金账户';
comment on column H_CLRSEFUND.CURRENCY is '币种';
comment on column H_CLRSEFUND.BUYAMOUNT is '净买金额';
comment on column H_CLRSEFUND.TODAYFUNDS is '当日资金余额';
comment on column H_CLRSEFUND.ACTUALPAY is '实际收付';
comment on column H_CLRSEFUND.LOWSETTLEMENT is '最低结算备付金';
comment on column H_CLRSEFUND.OTHERFEES is '其他费用';
comment on column H_CLRSEFUND.TRADEDATE is '日期';
comment on column H_CLRSEFUND.FEE is '手续费';
	
create table H_CLRSETRDDATA (
		CHANGETYPE VARCHAR2(3)  
		,PRICE NUMBER(17,9)  
		,SECURIACCOUNTID VARCHAR2(10)  
		,TRANSDATE VARCHAR2(10)  
		,ACCOUNTNUM VARCHAR2(25)  
		,VOLUMN NUMBER(16)  
		,RIGHTTYPE CHAR(2)  
		,EXCHANGEID CHAR(2)  
		,TRADEDATE VARCHAR2(10)  
		,CIRCUTYPE CHAR(1)  
		,FEE NUMBER(18,3)  
		,BSFLAG CHAR(1)  
		,HANDFEE NUMBER(18,3)  
		,MEMBERDATE VARCHAR2(8)  
		,SETTLEVOLUMN NUMBER(16)  
		,SECFEE NUMBER(18,3)  
		,TRADETRANSNUM VARCHAR2(16)  
		,SECURICODE VARCHAR2(6)  
		,SECURITYPE CHAR(2)  
		,UPLOADDATE CHAR(10)  
		,CLEARAMOUNT NUMBER(20,3)  
		,TRANSFERFEE NUMBER(18,3)  
		,SECURINAME VARCHAR2(30)  
		,STAMPTAX NUMBER(18,3)  
		,CHECKTAG CHAR(4)  
		,CURRENCY CHAR(3)  
		,TRANSTIME VARCHAR2(10)  
		,OTHERFEES NUMBER(18,3)  
		,HANGYEAR VARCHAR2(4)  
);


comment on table H_CLRSETRDDATA is '现货资金文件';
comment on column H_CLRSETRDDATA.CHANGETYPE is '变动类型';
comment on column H_CLRSETRDDATA.PRICE is '成交价格';
comment on column H_CLRSETRDDATA.SECURIACCOUNTID is '客户证券账户';
comment on column H_CLRSETRDDATA.TRANSDATE is '成交日期';
comment on column H_CLRSETRDDATA.ACCOUNTNUM is '资金账户号码';
comment on column H_CLRSETRDDATA.VOLUMN is '成交数量';
comment on column H_CLRSETRDDATA.RIGHTTYPE is '权益类别';
comment on column H_CLRSETRDDATA.EXCHANGEID is '交易所统一标识';
comment on column H_CLRSETRDDATA.TRADEDATE is '日期';
comment on column H_CLRSETRDDATA.CIRCUTYPE is '流通类型';
comment on column H_CLRSETRDDATA.FEE is '手续费';
comment on column H_CLRSETRDDATA.BSFLAG is '买卖标志';
comment on column H_CLRSETRDDATA.HANDFEE is '经手费';
comment on column H_CLRSETRDDATA.MEMBERDATE is '会员号';
comment on column H_CLRSETRDDATA.SETTLEVOLUMN is '交收数量';
comment on column H_CLRSETRDDATA.SECFEE is '证管费';
comment on column H_CLRSETRDDATA.TRADETRANSNUM is '成交流水号';
comment on column H_CLRSETRDDATA.SECURICODE is '证券代码';
comment on column H_CLRSETRDDATA.SECURITYPE is '证券类别';
comment on column H_CLRSETRDDATA.UPLOADDATE is '上报日期';
comment on column H_CLRSETRDDATA.CLEARAMOUNT is '清算金额';
comment on column H_CLRSETRDDATA.TRANSFERFEE is '过户费';
comment on column H_CLRSETRDDATA.SECURINAME is '证券的中文简称';
comment on column H_CLRSETRDDATA.STAMPTAX is '印花税';
comment on column H_CLRSETRDDATA.CHECKTAG is '检查标识';
comment on column H_CLRSETRDDATA.CURRENCY is '币种';
comment on column H_CLRSETRDDATA.TRANSTIME is '成交时间';
comment on column H_CLRSETRDDATA.OTHERFEES is '其他费用';
comment on column H_CLRSETRDDATA.HANGYEAR is '挂牌年份';
	
create table H_CLRSEPOSDATA (
		SECURIACCOUNTID VARCHAR2(10)  
		,SECURICODE VARCHAR2(6)  
		,SECURITYPE CHAR(2)  
		,UPLOADDATE CHAR(10)  
		,SECURINAME VARCHAR2(30)  
		,CHECKTAG CHAR(4)  
		,HPFLAG CHAR(2)  
		,RIGHTTYPE CHAR(2)  
		,MEMBERNUM VARCHAR2(8)  
		,POSITION NUMBER(16)  
		,TRADEDATE VARCHAR2(10)  
		,CIRCUTYPE CHAR(1)  
		,HANGYEAR VARCHAR2(4)  
);


comment on table H_CLRSEPOSDATA is '现货持仓明细文件';
comment on column H_CLRSEPOSDATA.SECURIACCOUNTID is '客户证券账户';
comment on column H_CLRSEPOSDATA.SECURICODE is '证券代码';
comment on column H_CLRSEPOSDATA.SECURITYPE is '证券类别';
comment on column H_CLRSEPOSDATA.UPLOADDATE is '上报日期';
comment on column H_CLRSEPOSDATA.SECURINAME is '证券的中文简称';
comment on column H_CLRSEPOSDATA.CHECKTAG is '检查标识';
comment on column H_CLRSEPOSDATA.HPFLAG is '交易所统一标识';
comment on column H_CLRSEPOSDATA.RIGHTTYPE is '权益类别';
comment on column H_CLRSEPOSDATA.MEMBERNUM is '会员号';
comment on column H_CLRSEPOSDATA.POSITION is '持仓量';
comment on column H_CLRSEPOSDATA.TRADEDATE is '日期';
comment on column H_CLRSEPOSDATA.CIRCUTYPE is '流通类型';
comment on column H_CLRSEPOSDATA.HANGYEAR is '挂牌年份';
	
alter table H_COMPCLIENTOPTEXERCISE add column EXECMARGIN NUMBER(15,3)  ;
alter table H_COMPCLIENTOPTEXERCISE add column FREEZFUNDS NUMBER(20,3)  ;
alter table H_COMPCLIENTOPTEXERCISE modify TRADESEQ null;				
alter table H_COMPCLIENTOPTEXERCISE modify(BASEPRODUCTID VARCHAR2(6));
	
create table D_CLRMEMBER (
		CHECKTAG CHAR(4)  
		,MENBERNAME VARCHAR2(40)  
		,TRADETYPE CHAR(1)  
		,SHORTNAME VARCHAR2(10)  
		,SETTLETYPE CHAR(1)  
		,MEMBERNUM VARCHAR2(5)  
		,UPLOADDATE CHAR(10)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table D_CLRMEMBER is '会员基本资料文件';
comment on column D_CLRMEMBER.CHECKTAG is '检查标识';
comment on column D_CLRMEMBER.MENBERNAME is '会员名称';
comment on column D_CLRMEMBER.TRADETYPE is '会员交易类型';
comment on column D_CLRMEMBER.SHORTNAME is '会员简称';
comment on column D_CLRMEMBER.SETTLETYPE is '会员结算类型';
comment on column D_CLRMEMBER.MEMBERNUM is '会员号';
comment on column D_CLRMEMBER.UPLOADDATE is '上报日期';
comment on column D_CLRMEMBER.TRADEDATE is '日期';
	
create table D_CLRCUSTOMER (
		ORGNUMBER VARCHAR2(40)  
		,SECURIACCOUNTID VARCHAR2(10)  
		,SUBNUMBER VARCHAR2(10)  
		,TRADETYPE CHAR(1)  
		,CONTACTS VARCHAR2(40)  
		,AUTHORTYPE CHAR(1)  
		,OPENDATE VARCHAR2(10)  
		,ORGDEADLINE VARCHAR2(10)  
		,PHONE VARCHAR2(40)  
		,BUSINESSNUM VARCHAR2(40)  
		,CONTACTCOUNTRY CHAR(3)  
		,POSTALCODE VARCHAR2(6)  
		,READDRESS VARCHAR2(200)  
		,VALIDIDENTITY VARCHAR2(40)  
		,MENBERNUM VARCHAR2(5)  
		,OCFLAG CHAR(1)  
		,POSTALADDRESS VARCHAR2(200)  
		,AUTHORNAME VARCHAR2(40)  
		,TRADEDATE VARCHAR2(10)  
		,LEGALPERSON VARCHAR2(40)  
		,IDENTITYNUM VARCHAR2(40)  
		,COUNTRY CHAR(3)  
		,ADDRESS VARCHAR2(40)  
		,CUSTOMERTYPE CHAR(1)  
		,UPLOADDATE CHAR(10)  
		,IDDEADLINE VARCHAR2(10)  
		,OVERSEASFLAG CHAR(1)  
		,CUSTOMERNAME VARCHAR2(200)  
		,PASSPORT VARCHAR2(50)  
		,DERIVATIVENUM VARCHAR2(13)  
		,CHECKTAG CHAR(4)  
		,CONTACTADDR VARCHAR2(200)  
		,ACCOUNTSTATE CHAR(1)  
		,MAILADDRESS VARCHAR2(100)  
		,AUTHORIDENTITY VARCHAR2(40)  
);


comment on table D_CLRCUSTOMER is '客户基本资料文件';
comment on column D_CLRCUSTOMER.ORGNUMBER is '组织机构代码证号';
comment on column D_CLRCUSTOMER.SECURIACCOUNTID is '客户证券账户';
comment on column D_CLRCUSTOMER.SUBNUMBER is '二级代理商编号';
comment on column D_CLRCUSTOMER.TRADETYPE is '交易编码类型';
comment on column D_CLRCUSTOMER.CONTACTS is '联系人';
comment on column D_CLRCUSTOMER.AUTHORTYPE is '有效身份证明文件类别';
comment on column D_CLRCUSTOMER.OPENDATE is '客户开户日期';
comment on column D_CLRCUSTOMER.ORGDEADLINE is '组织机构代码证有效期截止日期';
comment on column D_CLRCUSTOMER.PHONE is '联系电话';
comment on column D_CLRCUSTOMER.BUSINESSNUM is '商业登记证号';
comment on column D_CLRCUSTOMER.CONTACTCOUNTRY is '经办人国籍/地区';
comment on column D_CLRCUSTOMER.POSTALCODE is '邮政编码';
comment on column D_CLRCUSTOMER.READDRESS is '注册地址';
comment on column D_CLRCUSTOMER.VALIDIDENTITY is '有效身份证明文件号码';
comment on column D_CLRCUSTOMER.MENBERNUM is '所属会员号';
comment on column D_CLRCUSTOMER.OCFLAG is '开户和销户标志';
comment on column D_CLRCUSTOMER.POSTALADDRESS is '通讯地址';
comment on column D_CLRCUSTOMER.AUTHORNAME is '开户授权人名称';
comment on column D_CLRCUSTOMER.TRADEDATE is '日期';
comment on column D_CLRCUSTOMER.LEGALPERSON is '法定代表人、执行事务合伙人或负责人';
comment on column D_CLRCUSTOMER.IDENTITYNUM is '身份证';
comment on column D_CLRCUSTOMER.COUNTRY is '国籍/地区 ';
comment on column D_CLRCUSTOMER.ADDRESS is '所在地';
comment on column D_CLRCUSTOMER.CUSTOMERTYPE is '客户类型';
comment on column D_CLRCUSTOMER.UPLOADDATE is '上报日期';
comment on column D_CLRCUSTOMER.IDDEADLINE is '身份证明文件有效期截止日期';
comment on column D_CLRCUSTOMER.OVERSEASFLAG is '境外客户标识';
comment on column D_CLRCUSTOMER.CUSTOMERNAME is '名称';
comment on column D_CLRCUSTOMER.PASSPORT is '护照号码，港澳台通行证号码, 或外国永久居留证号码';
comment on column D_CLRCUSTOMER.DERIVATIVENUM is '客户衍生品合约账户';
comment on column D_CLRCUSTOMER.CHECKTAG is '检查标识';
comment on column D_CLRCUSTOMER.CONTACTADDR is '经办人联系地址';
comment on column D_CLRCUSTOMER.ACCOUNTSTATE is '账户休眠状态';
comment on column D_CLRCUSTOMER.MAILADDRESS is '电子邮件地址及网址';
comment on column D_CLRCUSTOMER.AUTHORIDENTITY is '开户授权人有效身份证明文件号码';
	
create table D_CLRFIRMFUND (
		FREEZFUNDS NUMBER(20,3)  
		,DELIVERYMARGIN NUMBER(20,3)  
		,OFFSETCHANGEAMOUNT NUMBER(15,3)  
		,TOTALFEE NUMBER(20,3)  
		,ACCOUNTNUM VARCHAR2(25)  
		,TODAYPROFIT NUMBER(15,3)  
		,LOWSETTLEMENTS NUMBER(20,3)  
		,TOTALRIGHTS NUMBER(20,3)  
		,TODAYFUNDS NUMBER(20,3)  
		,MENBERNUM VARCHAR2(5)  
		,MONERYOUT NUMBER(20,3)  
		,NONCHANGEAMOUNT NUMBER(20,3)  
		,SETTLEMENT NUMBER(20,3)  
		,TRADEDATE VARCHAR2(10)  
		,CURRENCYFUND NUMBER(20,3)  
		,CONVERAMOUNT NUMBER(15,3)  
		,OTHERSETTLEFUNDS NUMBER(20,3)  
		,TODAYTOTALRIGHTS NUMBER(20,3)  
		,UPLOADDATE CHAR(10)  
		,TRADEMARGIN NUMBER(20,3)  
		,EXSETTLEFUNDS NUMBER(20,3)  
		,CHECKTAG CHAR(4)  
		,CURRENCY CHAR(3)  
		,ACCOUNTTYPE CHAR(1)  
		,MONERYIN NUMBER(20,3)  
		,OFFSETAMOUNT NUMBER(15,3)  
		,YESTERDAYRIGHTS NUMBER(20,3)  
		,NONAMOUNT NUMBER(20,3)  
);


comment on table D_CLRFIRMFUND is '衍生品资金文件';
comment on column D_CLRFIRMFUND.FREEZFUNDS is '冻结资金';
comment on column D_CLRFIRMFUND.DELIVERYMARGIN is '交割保证金';
comment on column D_CLRFIRMFUND.OFFSETCHANGEAMOUNT is '货币充抵变动额';
comment on column D_CLRFIRMFUND.TOTALFEE is '各类手续费清算值合计';
comment on column D_CLRFIRMFUND.ACCOUNTNUM is '资金账户号码';
comment on column D_CLRFIRMFUND.TODAYPROFIT is '当日总盈亏';
comment on column D_CLRFIRMFUND.LOWSETTLEMENTS is '最低结算准备金';
comment on column D_CLRFIRMFUND.TOTALRIGHTS is '会员权益总额';
comment on column D_CLRFIRMFUND.TODAYFUNDS is '当日资金交收合计';
comment on column D_CLRFIRMFUND.MENBERNUM is '会员号';
comment on column D_CLRFIRMFUND.MONERYOUT is '出金';
comment on column D_CLRFIRMFUND.NONCHANGEAMOUNT is '非货币充抵变动额';
comment on column D_CLRFIRMFUND.SETTLEMENT is '结算准备金';
comment on column D_CLRFIRMFUND.TRADEDATE is '日期 ';
comment on column D_CLRFIRMFUND.CURRENCYFUND is '实有货币资金';
comment on column D_CLRFIRMFUND.CONVERAMOUNT is '货币折抵金额';
comment on column D_CLRFIRMFUND.OTHERSETTLEFUNDS is '其它交收资金清算值合计';
comment on column D_CLRFIRMFUND.TODAYTOTALRIGHTS is '当日总权利金';
comment on column D_CLRFIRMFUND.UPLOADDATE is '上报日期';
comment on column D_CLRFIRMFUND.TRADEMARGIN is '交易保证金';
comment on column D_CLRFIRMFUND.EXSETTLEFUNDS is '行权交收资金清算值合计';
comment on column D_CLRFIRMFUND.CHECKTAG is '检查标识';
comment on column D_CLRFIRMFUND.CURRENCY is '币种';
comment on column D_CLRFIRMFUND.ACCOUNTTYPE is '资金账户类型';
comment on column D_CLRFIRMFUND.MONERYIN is '入金';
comment on column D_CLRFIRMFUND.OFFSETAMOUNT is '货币充抵金额';
comment on column D_CLRFIRMFUND.YESTERDAYRIGHTS is '上日会员权益总额';
comment on column D_CLRFIRMFUND.NONAMOUNT is '非货币充抵金额';
	
create table D_CLRFUNDCHG (
		INOUTDATE VARCHAR2(10)  
		,CHECKTAG CHAR(4)  
		,ACCOUNTNUM VARCHAR2(25)  
		,CURRENCY CHAR(3)  
		,INOUTACCOUNTTYPE CHAR(1)  
		,BANKID CHAR(2)  
		,INOUTTYPE CHAR(1)  
		,ACCOUNTTYPE CHAR(1)  
		,FUNDCHGAMOUNT NUMBER(20,3)  
		,MEMBERNUM VARCHAR2(5)  
		,UPLOADDATE CHAR(10)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table D_CLRFUNDCHG is '期货公司出入金文件';
comment on column D_CLRFUNDCHG.INOUTDATE is '出入金发生日期';
comment on column D_CLRFUNDCHG.CHECKTAG is '检查标识';
comment on column D_CLRFUNDCHG.ACCOUNTNUM is '资金账户号码';
comment on column D_CLRFUNDCHG.CURRENCY is '币种';
comment on column D_CLRFUNDCHG.INOUTACCOUNTTYPE is '出入金账户类型';
comment on column D_CLRFUNDCHG.BANKID is '银行统一标识';
comment on column D_CLRFUNDCHG.INOUTTYPE is '出入金类型';
comment on column D_CLRFUNDCHG.ACCOUNTTYPE is '资金账户类型';
comment on column D_CLRFUNDCHG.FUNDCHGAMOUNT is '资金变动额';
comment on column D_CLRFUNDCHG.MEMBERNUM is '会员号';
comment on column D_CLRFUNDCHG.UPLOADDATE is '上报日期';
comment on column D_CLRFUNDCHG.TRADEDATE is '日期';
	
create table D_CLRCUSFUND (
		FUNDAMOUNT NUMBER(20,3)  
		,DERIVATIVENUM VARCHAR2(13)  
		,CHECKTAG CHAR(4)  
		,ACCOUNTNUM VARCHAR2(25)  
		,CURRENCY CHAR(3)  
		,FUNDNUM VARCHAR2(4)  
		,MEMBERNUM VARCHAR2(5)  
		,UPLOADDATE CHAR(10)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table D_CLRCUSFUND is '衍生品分项资金文件';
comment on column D_CLRCUSFUND.FUNDAMOUNT is '资金金额';
comment on column D_CLRCUSFUND.DERIVATIVENUM is '客户衍生品合约账户';
comment on column D_CLRCUSFUND.CHECKTAG is '检查标识';
comment on column D_CLRCUSFUND.ACCOUNTNUM is '资金账户号码';
comment on column D_CLRCUSFUND.CURRENCY is '币种';
comment on column D_CLRCUSFUND.FUNDNUM is '资金项目编号';
comment on column D_CLRCUSFUND.MEMBERNUM is '会员号';
comment on column D_CLRCUSFUND.UPLOADDATE is '上报日期';
comment on column D_CLRCUSFUND.TRADEDATE is '日期';
	
create table D_CLROPTTRDDATA (
		BSFLAG CHAR(1)  
		,OPTIONMONEY NUMBER(20,3)  
		,CUFLAG CHAR(1)  
		,TRANSDATE VARCHAR2(10)  
		,CPTYPE CHAR(1)  
		,CLOSETIME VARCHAR2(10)  
		,OLFLAG CHAR(1)  
		,UPLOADDATE CHAR(10)  
		,DERIVATIVENUM VARCHAR2(13)  
		,CHECKTAG CHAR(4)  
		,VHFLAG CHAR(1)  
		,CURRENCY CHAR(3)  
		,VOLUMN NUMBER(16)  
		,OPTIONPRICE NUMBER(17,9)  
		,INSTRUMENTID VARCHAR2(30)  
		,STRICKPRICE NUMBER(20,9)  
		,TRANSNUM VARCHAR2(16)  
		,MEMBERNUM VARCHAR2(5)  
		,BASEPRODUCTID VARCHAR2(6)  
		,BASECONTRACTID VARCHAR2(30)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table D_CLROPTTRDDATA is '衍生品分项资金文件';
comment on column D_CLROPTTRDDATA.BSFLAG is '买卖标志';
comment on column D_CLROPTTRDDATA.OPTIONMONEY is '权利金';
comment on column D_CLROPTTRDDATA.CUFLAG is '备兑标志';
comment on column D_CLROPTTRDDATA.TRANSDATE is '成交日期';
comment on column D_CLROPTTRDDATA.CPTYPE is '期权类型';
comment on column D_CLROPTTRDDATA.CLOSETIME is '成交时间';
comment on column D_CLROPTTRDDATA.OLFLAG is '开平仓标志';
comment on column D_CLROPTTRDDATA.UPLOADDATE is '上报日期';
comment on column D_CLROPTTRDDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column D_CLROPTTRDDATA.CHECKTAG is '检查标识';
comment on column D_CLROPTTRDDATA.VHFLAG is '投机套保标志';
comment on column D_CLROPTTRDDATA.CURRENCY is '币种';
comment on column D_CLROPTTRDDATA.VOLUMN is '成交量';
comment on column D_CLROPTTRDDATA.OPTIONPRICE is '权利金单价';
comment on column D_CLROPTTRDDATA.INSTRUMENTID is '品种合约';
comment on column D_CLROPTTRDDATA.STRICKPRICE is '执行价';
comment on column D_CLROPTTRDDATA.TRANSNUM is '成交流水号';
comment on column D_CLROPTTRDDATA.MEMBERNUM is '会员号';
comment on column D_CLROPTTRDDATA.BASEPRODUCTID is '标的品种';
comment on column D_CLROPTTRDDATA.BASECONTRACTID is '标的合约';
comment on column D_CLROPTTRDDATA.TRADEDATE is '日期';
	
create table D_CLROPTHOLDDATA (
		BSFLAG CHAR(1)  
		,TODSETTLEPRICE NUMBER(20,3)  
		,CUFLAG CHAR(1)  
		,CPTYPE CHAR(1)  
		,POSPROFIT NUMBER(15,3)  
		,UPLOADDATE CHAR(10)  
		,TRADEMARGIN NUMBER(20,3)  
		,DERIVATIVENUM VARCHAR2(13)  
		,CHECKTAG CHAR(4)  
		,VHFLAG CHAR(1)  
		,CURRENCY CHAR(3)  
		,INSTRUMENTID VARCHAR2(30)  
		,STRICKPRICE NUMBER(20,9)  
		,MEMBERNUM VARCHAR2(5)  
		,BASEPRODUCTID VARCHAR2(6)  
		,POSITION NUMBER(16)  
		,BASECONTRACTID VARCHAR2(30)  
		,TRADEDATE VARCHAR2(10)  
		,YESSETTLEPRICE NUMBER(20,3)  
);


comment on table D_CLROPTHOLDDATA is '衍生品持仓明细文件';
comment on column D_CLROPTHOLDDATA.BSFLAG is '买卖标志';
comment on column D_CLROPTHOLDDATA.TODSETTLEPRICE is '今结算价';
comment on column D_CLROPTHOLDDATA.CUFLAG is '备兑标志';
comment on column D_CLROPTHOLDDATA.CPTYPE is '期权类型';
comment on column D_CLROPTHOLDDATA.POSPROFIT is '持仓盈亏';
comment on column D_CLROPTHOLDDATA.UPLOADDATE is '上报日期';
comment on column D_CLROPTHOLDDATA.TRADEMARGIN is '交易保证金';
comment on column D_CLROPTHOLDDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column D_CLROPTHOLDDATA.CHECKTAG is '检查标识';
comment on column D_CLROPTHOLDDATA.VHFLAG is '投机套保标志';
comment on column D_CLROPTHOLDDATA.CURRENCY is '币种';
comment on column D_CLROPTHOLDDATA.INSTRUMENTID is '品种合约';
comment on column D_CLROPTHOLDDATA.STRICKPRICE is '执行价';
comment on column D_CLROPTHOLDDATA.MEMBERNUM is '会员号';
comment on column D_CLROPTHOLDDATA.BASEPRODUCTID is '标的品种';
comment on column D_CLROPTHOLDDATA.POSITION is '持仓量';
comment on column D_CLROPTHOLDDATA.BASECONTRACTID is '标的合约';
comment on column D_CLROPTHOLDDATA.TRADEDATE is '日期';
comment on column D_CLROPTHOLDDATA.YESSETTLEPRICE is '昨结算价';
	
create table D_CLROPTEXERDATA (
		BSFLAG CHAR(1)  
		,EXECDATE VARCHAR2(10)  
		,FREEZFUNDS NUMBER(20,3)  
		,CPTYPE CHAR(1)  
		,UPLOADDATE CHAR(10)  
		,EXECTIME VARCHAR2(10)  
		,DERIVATIVENUM VARCHAR2(13)  
		,CHECKTAG CHAR(4)  
		,EXECFIXFUND NUMBER(20,3)  
		,VHFLAG CHAR(1)  
		,EXECPRICE NUMBER(20,9)  
		,CURRENCY CHAR(3)  
		,EXECFEE NUMBER(20,3)  
		,EXECNUM NUMBER(16)  
		,INSTRUMENTID VARCHAR2(30)  
		,TRANSNUM VARCHAR2(16)  
		,MEMBERNUM VARCHAR2(5)  
		,EXECPROFIT NUMBER(15,3)  
		,BASEPRODUCTID VARCHAR2(6)  
		,BASECONTRACTID VARCHAR2(30)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table D_CLROPTEXERDATA is '衍生品行权明细文件';
comment on column D_CLROPTEXERDATA.BSFLAG is '买卖标志';
comment on column D_CLROPTEXERDATA.EXECDATE is '执行日期';
comment on column D_CLROPTEXERDATA.FREEZFUNDS is '冻结资金';
comment on column D_CLROPTEXERDATA.CPTYPE is '期权类型';
comment on column D_CLROPTEXERDATA.UPLOADDATE is '上报日期';
comment on column D_CLROPTEXERDATA.EXECTIME is '执行时间';
comment on column D_CLROPTEXERDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column D_CLROPTEXERDATA.CHECKTAG is '检查标识';
comment on column D_CLROPTEXERDATA.EXECFIXFUND is '行权锁定保证金';
comment on column D_CLROPTEXERDATA.VHFLAG is '投机套保标志';
comment on column D_CLROPTEXERDATA.EXECPRICE is '执行价';
comment on column D_CLROPTEXERDATA.CURRENCY is '币种';
comment on column D_CLROPTEXERDATA.EXECFEE is '行权结算费（手续费）';
comment on column D_CLROPTEXERDATA.EXECNUM is '执行手数';
comment on column D_CLROPTEXERDATA.INSTRUMENTID is '品种合约';
comment on column D_CLROPTEXERDATA.TRANSNUM is '流水号';
comment on column D_CLROPTEXERDATA.MEMBERNUM is '会员号';
comment on column D_CLROPTEXERDATA.EXECPROFIT is '行权盈亏';
comment on column D_CLROPTEXERDATA.BASEPRODUCTID is '标的品种';
comment on column D_CLROPTEXERDATA.BASECONTRACTID is '标的合约';
comment on column D_CLROPTEXERDATA.TRADEDATE is '日期';
	
create table D_CLRSEFUND (
		SETTLEDATE VARCHAR2(10)  
		,SELLAMOUNT NUMBER(20,3)  
		,HANDFEE NUMBER(18,3)  
		,MEMBERDATE VARCHAR2(8)  
		,SECFEE NUMBER(18,3)  
		,NOTE VARCHAR2(40)  
		,UPLOADDATE CHAR(10)  
		,CLEARDATE VARCHAR2(10)  
		,CLEARAMOUNT NUMBER(20,3)  
		,TRANSFERFEE NUMBER(18,3)  
		,STAMPTAX NUMBER(18,3)  
		,CHECKTAG CHAR(4)  
		,ACCOUNTNUM VARCHAR2(25)  
		,CURRENCY CHAR(3)  
		,BUYAMOUNT NUMBER(20,3)  
		,TODAYFUNDS NUMBER(20,3)  
		,ACTUALPAY NUMBER(20,3)  
		,LOWSETTLEMENT NUMBER(20,3)  
		,OTHERFEES NUMBER(18,3)  
		,TRADEDATE VARCHAR2(10)  
		,FEE NUMBER(18,3)  
);


comment on table D_CLRSEFUND is '现货资金文件';
comment on column D_CLRSEFUND.SETTLEDATE is '交收日期';
comment on column D_CLRSEFUND.SELLAMOUNT is '净卖金额';
comment on column D_CLRSEFUND.HANDFEE is '经手费';
comment on column D_CLRSEFUND.MEMBERDATE is '会员号';
comment on column D_CLRSEFUND.SECFEE is '证管费';
comment on column D_CLRSEFUND.NOTE is '备注';
comment on column D_CLRSEFUND.UPLOADDATE is '上报日期';
comment on column D_CLRSEFUND.CLEARDATE is '清算日期';
comment on column D_CLRSEFUND.CLEARAMOUNT is '清算金额';
comment on column D_CLRSEFUND.TRANSFERFEE is '过户费';
comment on column D_CLRSEFUND.STAMPTAX is '印花税';
comment on column D_CLRSEFUND.CHECKTAG is '检查标识';
comment on column D_CLRSEFUND.ACCOUNTNUM is '资金账户';
comment on column D_CLRSEFUND.CURRENCY is '币种';
comment on column D_CLRSEFUND.BUYAMOUNT is '净买金额';
comment on column D_CLRSEFUND.TODAYFUNDS is '当日资金余额';
comment on column D_CLRSEFUND.ACTUALPAY is '实际收付';
comment on column D_CLRSEFUND.LOWSETTLEMENT is '最低结算备付金';
comment on column D_CLRSEFUND.OTHERFEES is '其他费用';
comment on column D_CLRSEFUND.TRADEDATE is '日期';
comment on column D_CLRSEFUND.FEE is '手续费';
	
create table D_CLRSETRDDATA (
		CHANGETYPE VARCHAR2(3)  
		,PRICE NUMBER(17,9)  
		,SECURIACCOUNTID VARCHAR2(10)  
		,TRANSDATE VARCHAR2(10)  
		,ACCOUNTNUM VARCHAR2(25)  
		,VOLUMN NUMBER(16)  
		,RIGHTTYPE CHAR(2)  
		,EXCHANGEID CHAR(2)  
		,TRADEDATE VARCHAR2(10)  
		,CIRCUTYPE CHAR(1)  
		,FEE NUMBER(18,3)  
		,BSFLAG CHAR(1)  
		,HANDFEE NUMBER(18,3)  
		,MEMBERDATE VARCHAR2(8)  
		,SETTLEVOLUMN NUMBER(16)  
		,SECFEE NUMBER(18,3)  
		,TRADETRANSNUM VARCHAR2(16)  
		,SECURICODE VARCHAR2(6)  
		,SECURITYPE CHAR(2)  
		,UPLOADDATE CHAR(10)  
		,CLEARAMOUNT NUMBER(20,3)  
		,TRANSFERFEE NUMBER(18,3)  
		,SECURINAME VARCHAR2(30)  
		,STAMPTAX NUMBER(18,3)  
		,CHECKTAG CHAR(4)  
		,CURRENCY CHAR(3)  
		,TRANSTIME VARCHAR2(10)  
		,OTHERFEES NUMBER(18,3)  
		,HANGYEAR VARCHAR2(4)  
);


comment on table D_CLRSETRDDATA is '现货资金文件';
comment on column D_CLRSETRDDATA.CHANGETYPE is '变动类型';
comment on column D_CLRSETRDDATA.PRICE is '成交价格';
comment on column D_CLRSETRDDATA.SECURIACCOUNTID is '客户证券账户';
comment on column D_CLRSETRDDATA.TRANSDATE is '成交日期';
comment on column D_CLRSETRDDATA.ACCOUNTNUM is '资金账户号码';
comment on column D_CLRSETRDDATA.VOLUMN is '成交数量';
comment on column D_CLRSETRDDATA.RIGHTTYPE is '权益类别';
comment on column D_CLRSETRDDATA.EXCHANGEID is '交易所统一标识';
comment on column D_CLRSETRDDATA.TRADEDATE is '日期';
comment on column D_CLRSETRDDATA.CIRCUTYPE is '流通类型';
comment on column D_CLRSETRDDATA.FEE is '手续费';
comment on column D_CLRSETRDDATA.BSFLAG is '买卖标志';
comment on column D_CLRSETRDDATA.HANDFEE is '经手费';
comment on column D_CLRSETRDDATA.MEMBERDATE is '会员号';
comment on column D_CLRSETRDDATA.SETTLEVOLUMN is '交收数量';
comment on column D_CLRSETRDDATA.SECFEE is '证管费';
comment on column D_CLRSETRDDATA.TRADETRANSNUM is '成交流水号';
comment on column D_CLRSETRDDATA.SECURICODE is '证券代码';
comment on column D_CLRSETRDDATA.SECURITYPE is '证券类别';
comment on column D_CLRSETRDDATA.UPLOADDATE is '上报日期';
comment on column D_CLRSETRDDATA.CLEARAMOUNT is '清算金额';
comment on column D_CLRSETRDDATA.TRANSFERFEE is '过户费';
comment on column D_CLRSETRDDATA.SECURINAME is '证券的中文简称';
comment on column D_CLRSETRDDATA.STAMPTAX is '印花税';
comment on column D_CLRSETRDDATA.CHECKTAG is '检查标识';
comment on column D_CLRSETRDDATA.CURRENCY is '币种';
comment on column D_CLRSETRDDATA.TRANSTIME is '成交时间';
comment on column D_CLRSETRDDATA.OTHERFEES is '其他费用';
comment on column D_CLRSETRDDATA.HANGYEAR is '挂牌年份';
	
create table D_CLRSEPOSDATA (
		SECURIACCOUNTID VARCHAR2(10)  
		,SECURICODE VARCHAR2(6)  
		,SECURITYPE CHAR(2)  
		,UPLOADDATE CHAR(10)  
		,SECURINAME VARCHAR2(30)  
		,CHECKTAG CHAR(4)  
		,HPFLAG CHAR(2)  
		,RIGHTTYPE CHAR(2)  
		,MEMBERNUM VARCHAR2(8)  
		,POSITION NUMBER(16)  
		,TRADEDATE VARCHAR2(10)  
		,CIRCUTYPE CHAR(1)  
		,HANGYEAR VARCHAR2(4)  
);


comment on table D_CLRSEPOSDATA is '现货持仓明细文件';
comment on column D_CLRSEPOSDATA.SECURIACCOUNTID is '客户证券账户';
comment on column D_CLRSEPOSDATA.SECURICODE is '证券代码';
comment on column D_CLRSEPOSDATA.SECURITYPE is '证券类别';
comment on column D_CLRSEPOSDATA.UPLOADDATE is '上报日期';
comment on column D_CLRSEPOSDATA.SECURINAME is '证券的中文简称';
comment on column D_CLRSEPOSDATA.CHECKTAG is '检查标识';
comment on column D_CLRSEPOSDATA.HPFLAG is '交易所统一标识';
comment on column D_CLRSEPOSDATA.RIGHTTYPE is '权益类别';
comment on column D_CLRSEPOSDATA.MEMBERNUM is '会员号';
comment on column D_CLRSEPOSDATA.POSITION is '持仓量';
comment on column D_CLRSEPOSDATA.TRADEDATE is '日期';
comment on column D_CLRSEPOSDATA.CIRCUTYPE is '流通类型';
comment on column D_CLRSEPOSDATA.HANGYEAR is '挂牌年份';
	
create table H_COMPAMASSETSDETAILS (
		COMPCLIENTID VARCHAR2(18)  
		,CHECKTAG CHAR(4)  
		,TODAYPROFIT NUMBER(15,3)  
		,CURRENCY CHAR(3)  
		,TODAYNETVALUE NUMBER(15,3)  
		,INVESTYPE CHAR(4)  
		,MORETYPE CHAR(1)  
		,UPLOADDATE CHAR(10)  
		,NOTES VARCHAR2(40)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table H_COMPAMASSETSDETAILS is '资产管理非本公司经纪业务资金明细文件';
comment on column H_COMPAMASSETSDETAILS.COMPCLIENTID is '客户内部资金账户';
comment on column H_COMPAMASSETSDETAILS.CHECKTAG is '检查标识';
comment on column H_COMPAMASSETSDETAILS.TODAYPROFIT is '当日盈亏';
comment on column H_COMPAMASSETSDETAILS.CURRENCY is '币种';
comment on column H_COMPAMASSETSDETAILS.TODAYNETVALUE is '当日净值';
comment on column H_COMPAMASSETSDETAILS.INVESTYPE is '投资标的类型';
comment on column H_COMPAMASSETSDETAILS.MORETYPE is '是否为特定多个客户资产管理计划';
comment on column H_COMPAMASSETSDETAILS.UPLOADDATE is '上报日期';
comment on column H_COMPAMASSETSDETAILS.NOTES is '备注';
comment on column H_COMPAMASSETSDETAILS.TRADEDATE is '日期';
	
create table H_COMPSEFUND (
		HANDFEE NUMBER(15,3)  
		,COMPSTOCKSPOTID VARCHAR2(18)  
		,SECFEE NUMBER(15,3)  
		,MONEYIN NUMBER(15,3)  
		,TRANSFERFEE NUMBER(15,3)  
		,UPLOADDATE CHAR(10)  
		,INTEREST NUMBER(15,3)  
		,STAMPTAX NUMBER(15,3)  
		,SSTOCKTOTAL NUMBER(15,3)  
		,CHECKTAG CHAR(4)  
		,CURRENCY CHAR(3)  
		,MARKETVALUE NUMBER(15,3)  
		,TODAYFUNDS NUMBER(15,3)  
		,ACTUALPAY NUMBER(15,3)  
		,BSTOCKTOTAL NUMBER(15,3)  
		,YESTODAYFUNDS NUMBER(15,3)  
		,TOTALASSETS NUMBER(15,3)  
		,OTHERFEES NUMBER(15,3)  
		,TODATAVALIFUNDS NUMBER(15,3)  
		,NOTES VARCHAR2(40)  
		,TRADEDATE VARCHAR2(10)  
		,FEE NUMBER(15,3)  
		,MONEYOUT NUMBER(15,3)  
);


comment on table H_COMPSEFUND is '客户证券现货资金文件';
comment on column H_COMPSEFUND.HANDFEE is '经手费';
comment on column H_COMPSEFUND.COMPSTOCKSPOTID is '客户证券现货内部资金账号';
comment on column H_COMPSEFUND.SECFEE is '证管费';
comment on column H_COMPSEFUND.MONEYIN is '入金合计';
comment on column H_COMPSEFUND.TRANSFERFEE is '过户费';
comment on column H_COMPSEFUND.UPLOADDATE is '上报日期';
comment on column H_COMPSEFUND.INTEREST is '利息';
comment on column H_COMPSEFUND.STAMPTAX is '印花税';
comment on column H_COMPSEFUND.SSTOCKTOTAL is '卖券金额合计';
comment on column H_COMPSEFUND.CHECKTAG is '检查标识';
comment on column H_COMPSEFUND.CURRENCY is '币种';
comment on column H_COMPSEFUND.MARKETVALUE is '股票市值';
comment on column H_COMPSEFUND.TODAYFUNDS is '当日资金余额';
comment on column H_COMPSEFUND.ACTUALPAY is '实际收付';
comment on column H_COMPSEFUND.BSTOCKTOTAL is '买券金额合计';
comment on column H_COMPSEFUND.YESTODAYFUNDS is '上日资金余额';
comment on column H_COMPSEFUND.TOTALASSETS is '总资产';
comment on column H_COMPSEFUND.OTHERFEES is '其他费用';
comment on column H_COMPSEFUND.TODATAVALIFUNDS is '当日可用资金';
comment on column H_COMPSEFUND.NOTES is '备注';
comment on column H_COMPSEFUND.TRADEDATE is '日期';
comment on column H_COMPSEFUND.FEE is '手续费';
comment on column H_COMPSEFUND.MONEYOUT is '出金合计';
	
create table H_COMPSETRDDATA (
		COMPSTOCKSPOTID VARCHAR2(18)  
		,CHANGETYPE CHAR(3)  
		,PRICE NUMBER(17,9)  
		,SECURIACCOUNTID VARCHAR2(13)  
		,TRANSDATE CHAR(10)  
		,VOLUMN NUMBER(16)  
		,HPFLAG CHAR(2)  
		,RIGHTTYPE CHAR(2)  
		,TRADEDATE CHAR(10)  
		,CIRCUTYPE CHAR(1)  
		,FEE NUMBER(18,3)  
		,BSFLAG CHAR(1)  
		,HANDFEE NUMBER(18,3)  
		,SECFEE NUMBER(18,3)  
		,SECURICODE VARCHAR2(6)  
		,SECURITYPE CHAR(2)  
		,AMOUNT NUMBER(20,3)  
		,UPLOADDATE CHAR(10)  
		,TRANSFERFEE NUMBER(18,3)  
		,STAMPTAX NUMBER(18,3)  
		,CHECKTAG CHAR(4)  
		,CURRENCY CHAR(3)  
		,SECUTINAME VARCHAR2(30)  
		,TRANSNUM VARCHAR2(16)  
		,TRANSTIME CHAR(10)  
		,OTHERFEES NUMBER(20,3)  
		,HANGYEAR CHAR(4)  
);


comment on table H_COMPSETRDDATA is '客户证券现货成交明细文件';
comment on column H_COMPSETRDDATA.COMPSTOCKSPOTID is '客户证券现货内部资金账户';
comment on column H_COMPSETRDDATA.CHANGETYPE is '变动类型';
comment on column H_COMPSETRDDATA.PRICE is '成交价格';
comment on column H_COMPSETRDDATA.SECURIACCOUNTID is '客户证券账户';
comment on column H_COMPSETRDDATA.TRANSDATE is '成交日期';
comment on column H_COMPSETRDDATA.VOLUMN is '成交数量';
comment on column H_COMPSETRDDATA.HPFLAG is '交易所统一标识';
comment on column H_COMPSETRDDATA.RIGHTTYPE is '权益类别';
comment on column H_COMPSETRDDATA.TRADEDATE is '日期';
comment on column H_COMPSETRDDATA.CIRCUTYPE is '流通类型';
comment on column H_COMPSETRDDATA.FEE is '手续费';
comment on column H_COMPSETRDDATA.BSFLAG is '买卖标志';
comment on column H_COMPSETRDDATA.HANDFEE is '经手费';
comment on column H_COMPSETRDDATA.SECFEE is '证管费';
comment on column H_COMPSETRDDATA.SECURICODE is '证券代码';
comment on column H_COMPSETRDDATA.SECURITYPE is '证券类别';
comment on column H_COMPSETRDDATA.AMOUNT is '成交金额';
comment on column H_COMPSETRDDATA.UPLOADDATE is '上报日期';
comment on column H_COMPSETRDDATA.TRANSFERFEE is '过户费';
comment on column H_COMPSETRDDATA.STAMPTAX is '印花税';
comment on column H_COMPSETRDDATA.CHECKTAG is '检查标识';
comment on column H_COMPSETRDDATA.CURRENCY is '币种';
comment on column H_COMPSETRDDATA.SECUTINAME is '证券的中文简称';
comment on column H_COMPSETRDDATA.TRANSNUM is '成交流水号';
comment on column H_COMPSETRDDATA.TRANSTIME is '成交时间';
comment on column H_COMPSETRDDATA.OTHERFEES is '其他费用';
comment on column H_COMPSETRDDATA.HANGYEAR is '挂牌年份';
	
create table H_COMPSEPOSDATA (
		POSPRICE NUMBER(20,3)  
		,COMPSTOCKSPOTID VARCHAR2(18)  
		,SECURIACCOUNTID VARCHAR2(13)  
		,SECURICODE VARCHAR2(6)  
		,POSPROFIT NUMBER(20,3)  
		,SECURITYPE CHAR(2)  
		,UPLOADDATE CHAR(10)  
		,AVAILABLEPOS NUMBER(16)  
		,CHECKTAG CHAR(4)  
		,MARKETVALUE NUMBER(20,3)  
		,SECUTINAME VARCHAR2(30)  
		,HPFLAG CHAR(2)  
		,RIGHTTYPE CHAR(2)  
		,POSITION NUMBER(16)  
		,TRADEDATE CHAR(10)  
		,POSNEWPIRCE NUMBER(20,3)  
		,CIRCUTYPE CHAR(1)  
		,HANGYEAR CHAR(4)  
);


comment on table H_COMPSEPOSDATA is '客户现货持仓明细文件';
comment on column H_COMPSEPOSDATA.POSPRICE is '持仓成本价';
comment on column H_COMPSEPOSDATA.COMPSTOCKSPOTID is '客户内部资金账号（证券现货账户）';
comment on column H_COMPSEPOSDATA.SECURIACCOUNTID is '客户证券账户';
comment on column H_COMPSEPOSDATA.SECURICODE is '证券代码';
comment on column H_COMPSEPOSDATA.POSPROFIT is '持仓浮动盈亏';
comment on column H_COMPSEPOSDATA.SECURITYPE is '证券类别';
comment on column H_COMPSEPOSDATA.UPLOADDATE is '上报日期';
comment on column H_COMPSEPOSDATA.AVAILABLEPOS is '持仓可用量';
comment on column H_COMPSEPOSDATA.CHECKTAG is '检查标识';
comment on column H_COMPSEPOSDATA.MARKETVALUE is '市值';
comment on column H_COMPSEPOSDATA.SECUTINAME is '证券的中文简称';
comment on column H_COMPSEPOSDATA.HPFLAG is '交易所统一标识';
comment on column H_COMPSEPOSDATA.RIGHTTYPE is '权益类别';
comment on column H_COMPSEPOSDATA.POSITION is '当日持仓量';
comment on column H_COMPSEPOSDATA.TRADEDATE is '日期';
comment on column H_COMPSEPOSDATA.POSNEWPIRCE is '持仓最新价';
comment on column H_COMPSEPOSDATA.CIRCUTYPE is '流通类型';
comment on column H_COMPSEPOSDATA.HANGYEAR is '挂牌年份';
	
create table D_COMPAMASSETSDETAILS (
		COMPCLIENTID VARCHAR2(18)  
		,CHECKTAG CHAR(4)  
		,TODAYPROFIT NUMBER(15,3)  
		,CURRENCY CHAR(3)  
		,TODAYNETVALUE NUMBER(15,3)  
		,INVESTYPE CHAR(4)  
		,MORETYPE CHAR(1)  
		,UPLOADDATE CHAR(10)  
		,NOTES VARCHAR2(40)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table D_COMPAMASSETSDETAILS is '资产管理非本公司经纪业务资金明细文件';
comment on column D_COMPAMASSETSDETAILS.COMPCLIENTID is '客户内部资金账户';
comment on column D_COMPAMASSETSDETAILS.CHECKTAG is '检查标识';
comment on column D_COMPAMASSETSDETAILS.TODAYPROFIT is '当日盈亏';
comment on column D_COMPAMASSETSDETAILS.CURRENCY is '币种';
comment on column D_COMPAMASSETSDETAILS.TODAYNETVALUE is '当日净值';
comment on column D_COMPAMASSETSDETAILS.INVESTYPE is '投资标的类型';
comment on column D_COMPAMASSETSDETAILS.MORETYPE is '是否为特定多个客户资产管理计划';
comment on column D_COMPAMASSETSDETAILS.UPLOADDATE is '上报日期';
comment on column D_COMPAMASSETSDETAILS.NOTES is '备注';
comment on column D_COMPAMASSETSDETAILS.TRADEDATE is '日期';
	
create table D_COMPSEFUND (
		HANDFEE NUMBER(15,3)  
		,COMPSTOCKSPOTID VARCHAR2(18)  
		,SECFEE NUMBER(15,3)  
		,MONEYIN NUMBER(15,3)  
		,TRANSFERFEE NUMBER(15,3)  
		,UPLOADDATE CHAR(10)  
		,INTEREST NUMBER(15,3)  
		,STAMPTAX NUMBER(15,3)  
		,SSTOCKTOTAL NUMBER(15,3)  
		,CHECKTAG CHAR(4)  
		,CURRENCY CHAR(3)  
		,MARKETVALUE NUMBER(15,3)  
		,TODAYFUNDS NUMBER(15,3)  
		,ACTUALPAY NUMBER(15,3)  
		,BSTOCKTOTAL NUMBER(15,3)  
		,YESTODAYFUNDS NUMBER(15,3)  
		,TOTALASSETS NUMBER(15,3)  
		,OTHERFEES NUMBER(15,3)  
		,TODATAVALIFUNDS NUMBER(15,3)  
		,NOTES VARCHAR2(40)  
		,TRADEDATE VARCHAR2(10)  
		,FEE NUMBER(15,3)  
		,MONEYOUT NUMBER(15,3)  
);


comment on table D_COMPSEFUND is '客户证券现货资金文件';
comment on column D_COMPSEFUND.HANDFEE is '经手费';
comment on column D_COMPSEFUND.COMPSTOCKSPOTID is '客户证券现货内部资金账号';
comment on column D_COMPSEFUND.SECFEE is '证管费';
comment on column D_COMPSEFUND.MONEYIN is '入金合计';
comment on column D_COMPSEFUND.TRANSFERFEE is '过户费';
comment on column D_COMPSEFUND.UPLOADDATE is '上报日期';
comment on column D_COMPSEFUND.INTEREST is '利息';
comment on column D_COMPSEFUND.STAMPTAX is '印花税';
comment on column D_COMPSEFUND.SSTOCKTOTAL is '卖券金额合计';
comment on column D_COMPSEFUND.CHECKTAG is '检查标识';
comment on column D_COMPSEFUND.CURRENCY is '币种';
comment on column D_COMPSEFUND.MARKETVALUE is '股票市值';
comment on column D_COMPSEFUND.TODAYFUNDS is '当日资金余额';
comment on column D_COMPSEFUND.ACTUALPAY is '实际收付';
comment on column D_COMPSEFUND.BSTOCKTOTAL is '买券金额合计';
comment on column D_COMPSEFUND.YESTODAYFUNDS is '上日资金余额';
comment on column D_COMPSEFUND.TOTALASSETS is '总资产';
comment on column D_COMPSEFUND.OTHERFEES is '其他费用';
comment on column D_COMPSEFUND.TODATAVALIFUNDS is '当日可用资金';
comment on column D_COMPSEFUND.NOTES is '备注';
comment on column D_COMPSEFUND.TRADEDATE is '日期';
comment on column D_COMPSEFUND.FEE is '手续费';
comment on column D_COMPSEFUND.MONEYOUT is '出金合计';
	
create table D_COMPSETRDDATA (
		COMPSTOCKSPOTID VARCHAR2(18)  
		,CHANGETYPE CHAR(3)  
		,PRICE NUMBER(17,9)  
		,SECURIACCOUNTID VARCHAR2(13)  
		,TRANSDATE CHAR(10)  
		,VOLUMN NUMBER(16)  
		,HPFLAG CHAR(2)  
		,RIGHTTYPE CHAR(2)  
		,TRADEDATE CHAR(10)  
		,CIRCUTYPE CHAR(1)  
		,FEE NUMBER(18,3)  
		,BSFLAG CHAR(1)  
		,HANDFEE NUMBER(18,3)  
		,SECFEE NUMBER(18,3)  
		,SECURICODE VARCHAR2(6)  
		,SECURITYPE CHAR(2)  
		,AMOUNT NUMBER(20,3)  
		,UPLOADDATE CHAR(10)  
		,TRANSFERFEE NUMBER(18,3)  
		,STAMPTAX NUMBER(18,3)  
		,CHECKTAG CHAR(4)  
		,CURRENCY CHAR(3)  
		,SECUTINAME VARCHAR2(30)  
		,TRANSNUM VARCHAR2(16)  
		,TRANSTIME CHAR(10)  
		,OTHERFEES NUMBER(20,3)  
		,HANGYEAR CHAR(4)  
);


comment on table D_COMPSETRDDATA is '客户证券现货成交明细文件';
comment on column D_COMPSETRDDATA.COMPSTOCKSPOTID is '客户证券现货内部资金账户';
comment on column D_COMPSETRDDATA.CHANGETYPE is '变动类型';
comment on column D_COMPSETRDDATA.PRICE is '成交价格';
comment on column D_COMPSETRDDATA.SECURIACCOUNTID is '客户证券账户';
comment on column D_COMPSETRDDATA.TRANSDATE is '成交日期';
comment on column D_COMPSETRDDATA.VOLUMN is '成交数量';
comment on column D_COMPSETRDDATA.HPFLAG is '交易所统一标识';
comment on column D_COMPSETRDDATA.RIGHTTYPE is '权益类别';
comment on column D_COMPSETRDDATA.TRADEDATE is '日期';
comment on column D_COMPSETRDDATA.CIRCUTYPE is '流通类型';
comment on column D_COMPSETRDDATA.FEE is '手续费';
comment on column D_COMPSETRDDATA.BSFLAG is '买卖标志';
comment on column D_COMPSETRDDATA.HANDFEE is '经手费';
comment on column D_COMPSETRDDATA.SECFEE is '证管费';
comment on column D_COMPSETRDDATA.SECURICODE is '证券代码';
comment on column D_COMPSETRDDATA.SECURITYPE is '证券类别';
comment on column D_COMPSETRDDATA.AMOUNT is '成交金额';
comment on column D_COMPSETRDDATA.UPLOADDATE is '上报日期';
comment on column D_COMPSETRDDATA.TRANSFERFEE is '过户费';
comment on column D_COMPSETRDDATA.STAMPTAX is '印花税';
comment on column D_COMPSETRDDATA.CHECKTAG is '检查标识';
comment on column D_COMPSETRDDATA.CURRENCY is '币种';
comment on column D_COMPSETRDDATA.SECUTINAME is '证券的中文简称';
comment on column D_COMPSETRDDATA.TRANSNUM is '成交流水号';
comment on column D_COMPSETRDDATA.TRANSTIME is '成交时间';
comment on column D_COMPSETRDDATA.OTHERFEES is '其他费用';
comment on column D_COMPSETRDDATA.HANGYEAR is '挂牌年份';
	
create table D_COMPSEPOSDATA (
		POSPRICE NUMBER(20,3)  
		,COMPSTOCKSPOTID VARCHAR2(18)  
		,SECURIACCOUNTID VARCHAR2(13)  
		,SECURICODE VARCHAR2(6)  
		,POSPROFIT NUMBER(20,3)  
		,SECURITYPE CHAR(2)  
		,UPLOADDATE CHAR(10)  
		,AVAILABLEPOS NUMBER(16)  
		,CHECKTAG CHAR(4)  
		,MARKETVALUE NUMBER(20,3)  
		,SECUTINAME VARCHAR2(30)  
		,HPFLAG CHAR(2)  
		,RIGHTTYPE CHAR(2)  
		,POSITION NUMBER(16)  
		,TRADEDATE CHAR(10)  
		,POSNEWPIRCE NUMBER(20,3)  
		,CIRCUTYPE CHAR(1)  
		,HANGYEAR CHAR(4)  
);


comment on table D_COMPSEPOSDATA is '客户现货持仓明细文件';
comment on column D_COMPSEPOSDATA.POSPRICE is '持仓成本价';
comment on column D_COMPSEPOSDATA.COMPSTOCKSPOTID is '客户内部资金账号（证券现货账户）';
comment on column D_COMPSEPOSDATA.SECURIACCOUNTID is '客户证券账户';
comment on column D_COMPSEPOSDATA.SECURICODE is '证券代码';
comment on column D_COMPSEPOSDATA.POSPROFIT is '持仓浮动盈亏';
comment on column D_COMPSEPOSDATA.SECURITYPE is '证券类别';
comment on column D_COMPSEPOSDATA.UPLOADDATE is '上报日期';
comment on column D_COMPSEPOSDATA.AVAILABLEPOS is '持仓可用量';
comment on column D_COMPSEPOSDATA.CHECKTAG is '检查标识';
comment on column D_COMPSEPOSDATA.MARKETVALUE is '市值';
comment on column D_COMPSEPOSDATA.SECUTINAME is '证券的中文简称';
comment on column D_COMPSEPOSDATA.HPFLAG is '交易所统一标识';
comment on column D_COMPSEPOSDATA.RIGHTTYPE is '权益类别';
comment on column D_COMPSEPOSDATA.POSITION is '当日持仓量';
comment on column D_COMPSEPOSDATA.TRADEDATE is '日期';
comment on column D_COMPSEPOSDATA.POSNEWPIRCE is '持仓最新价';
comment on column D_COMPSEPOSDATA.CIRCUTYPE is '流通类型';
comment on column D_COMPSEPOSDATA.HANGYEAR is '挂牌年份';
	
