
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
	
create table H_EXZHMEMBER (
		CHECKTAG CHAR(4)  
		,MENBERNAME VARCHAR2(40)  
		,TRADETYPE CHAR(1)  
		,SHORTNAME VARCHAR2(10)  
		,SETTLETYPE CHAR(1)  
		,MEMBERNUM VARCHAR2(5)  
		,UPLOADDATE CHAR(10)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table H_EXZHMEMBER is '会员基本资料文件';
comment on column H_EXZHMEMBER.CHECKTAG is '检查标识';
comment on column H_EXZHMEMBER.MENBERNAME is '会员名称';
comment on column H_EXZHMEMBER.TRADETYPE is '会员交易类型';
comment on column H_EXZHMEMBER.SHORTNAME is '会员简称';
comment on column H_EXZHMEMBER.SETTLETYPE is '会员结算类型';
comment on column H_EXZHMEMBER.MEMBERNUM is '会员号';
comment on column H_EXZHMEMBER.UPLOADDATE is '上报日期';
comment on column H_EXZHMEMBER.TRADEDATE is '日期';
	
create table H_EXCUSTOMER (
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


comment on table H_EXCUSTOMER is '客户基本资料文件';
comment on column H_EXCUSTOMER.ORGNUMBER is '组织机构代码证号';
comment on column H_EXCUSTOMER.SUBNUMBER is '二级代理商编号';
comment on column H_EXCUSTOMER.TRADETYPE is '交易编码类型';
comment on column H_EXCUSTOMER.CONTACTS is '联系人';
comment on column H_EXCUSTOMER.AUTHORTYPE is '有效身份证明文件类别';
comment on column H_EXCUSTOMER.OPENDATE is '客户开户日期';
comment on column H_EXCUSTOMER.ORGDEADLINE is '组织机构代码证有效期截止日期';
comment on column H_EXCUSTOMER.SECURITIESID is '客户证券账户';
comment on column H_EXCUSTOMER.PHONE is '联系电话';
comment on column H_EXCUSTOMER.BUSINESSNUM is '商业登记证号';
comment on column H_EXCUSTOMER.CONTACTCOUNTRY is '经办人国籍/地区';
comment on column H_EXCUSTOMER.POSTALCODE is '邮政编码';
comment on column H_EXCUSTOMER.READDRESS is '注册地址';
comment on column H_EXCUSTOMER.VALIDIDENTITY is '有效身份证明文件号码';
comment on column H_EXCUSTOMER.MENBERNUM is '所属会员号';
comment on column H_EXCUSTOMER.OCFLAG is '开户和销户标志';
comment on column H_EXCUSTOMER.POSTALADDRESS is '通讯地址';
comment on column H_EXCUSTOMER.AUTHORNAME is '开户授权人名称';
comment on column H_EXCUSTOMER.TRADEDATE is '日期';
comment on column H_EXCUSTOMER.LEGALPERSON is '法定代表人、执行事务合伙人或负责人';
comment on column H_EXCUSTOMER.IDENTITYNUM is '身份证';
comment on column H_EXCUSTOMER.COUNTRY is '国籍/地区 ';
comment on column H_EXCUSTOMER.ADDRESS is '所在地';
comment on column H_EXCUSTOMER.CUSTOMERTYPE is '客户类型';
comment on column H_EXCUSTOMER.UPLOADDATE is '上报日期';
comment on column H_EXCUSTOMER.IDDEADLINE is '身份证明文件有效期截止日期';
comment on column H_EXCUSTOMER.OVERSEASFLAG is '境外客户标识';
comment on column H_EXCUSTOMER.CUSTOMERNAME is '名称';
comment on column H_EXCUSTOMER.PASSPORT is '护照号码，港澳台通行证号码, 或外国永久居留证号码';
comment on column H_EXCUSTOMER.DERIVATIVENUM is '客户衍生品合约账户';
comment on column H_EXCUSTOMER.CHECKTAG is '检查标识';
comment on column H_EXCUSTOMER.CONTACTADDR is '经办人联系地址';
comment on column H_EXCUSTOMER.ACCOUNTSTATE is '账户休眠状态';
comment on column H_EXCUSTOMER.MAILADDRESS is '电子邮件地址及网址';
comment on column H_EXCUSTOMER.AUTHORIDENTITY is '开户授权人有效身份证明文件号码';
	
create table H_EXFIRMFUND (
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


comment on table H_EXFIRMFUND is '衍生品资金文件';
comment on column H_EXFIRMFUND.FREEZFUNDS is '冻结资金';
comment on column H_EXFIRMFUND.DELIVERYMARGIN is '交割保证金';
comment on column H_EXFIRMFUND.OFFSETCHANGEAMOUNT is '货币充抵变动额';
comment on column H_EXFIRMFUND.TOTALFEE is '各类手续费清算值合计';
comment on column H_EXFIRMFUND.ACCOUNTNUM is '资金账户号码';
comment on column H_EXFIRMFUND.TODAYPROFIT is '当日总盈亏';
comment on column H_EXFIRMFUND.LOWSETTLEMENTS is '最低结算准备金';
comment on column H_EXFIRMFUND.TOTALRIGHTS is '会员权益总额';
comment on column H_EXFIRMFUND.TODAYFUNDS is '当日资金交收合计';
comment on column H_EXFIRMFUND.MENBERNUM is '会员号';
comment on column H_EXFIRMFUND.MONERYOUT is '出金';
comment on column H_EXFIRMFUND.NONCHANGEAMOUNT is '非货币充抵变动额';
comment on column H_EXFIRMFUND.SETTLEMENT is '结算准备金';
comment on column H_EXFIRMFUND.TRADEDATE is '日期 ';
comment on column H_EXFIRMFUND.CURRENCYFUND is '实有货币资金';
comment on column H_EXFIRMFUND.CONVERAMOUNT is '货币折抵金额';
comment on column H_EXFIRMFUND.OTHERSETTLEFUNDS is '其它交收资金清算值合计';
comment on column H_EXFIRMFUND.TODAYTOTALRIGHTS is '当日总权利金';
comment on column H_EXFIRMFUND.UPLOADDATE is '上报日期';
comment on column H_EXFIRMFUND.TRADEMARGIN is '交易保证金';
comment on column H_EXFIRMFUND.EXSETTLEFUNDS is '行权交收资金清算值合计';
comment on column H_EXFIRMFUND.CHECKTAG is '检查标识';
comment on column H_EXFIRMFUND.CURRENCY is '币种';
comment on column H_EXFIRMFUND.ACCOUNTTYPE is '资金账户类型';
comment on column H_EXFIRMFUND.MONERYIN is '入金';
comment on column H_EXFIRMFUND.OFFSETAMOUNT is '货币充抵金额';
comment on column H_EXFIRMFUND.YESTERDAYRIGHTS is '上日会员权益总额';
comment on column H_EXFIRMFUND.NONAMOUNT is '非货币充抵金额';
	
create table H_EXFUNDCHG (
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


comment on table H_EXFUNDCHG is '期货公司出入金文件';
comment on column H_EXFUNDCHG.INOUTDATE is '出入金发生日期';
comment on column H_EXFUNDCHG.CHECKTAG is '检查标识';
comment on column H_EXFUNDCHG.ACCOUNTNUM is '资金账户号码';
comment on column H_EXFUNDCHG.CURRENCY is '币种';
comment on column H_EXFUNDCHG.INOUTACCOUNTTYPE is '出入金账户类型';
comment on column H_EXFUNDCHG.BANKID is '银行统一标识';
comment on column H_EXFUNDCHG.INOUTTYPE is '出入金类型';
comment on column H_EXFUNDCHG.ACCOUNTTYPE is '资金账户类型';
comment on column H_EXFUNDCHG.FUNDCHGAMOUNT is '资金变动额';
comment on column H_EXFUNDCHG.MEMBERNUM is '会员号';
comment on column H_EXFUNDCHG.UPLOADDATE is '上报日期';
comment on column H_EXFUNDCHG.TRADEDATE is '日期';
	
create table H_EXCUSFUND (
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


comment on table H_EXCUSFUND is '衍生品分项资金文件';
comment on column H_EXCUSFUND.FUNDAMOUNT is '资金金额';
comment on column H_EXCUSFUND.DERIVATIVENUM is '客户衍生品合约账户';
comment on column H_EXCUSFUND.CHECKTAG is '检查标识';
comment on column H_EXCUSFUND.ACCOUNTNUM is '资金账户号码';
comment on column H_EXCUSFUND.CURRENCY is '币种';
comment on column H_EXCUSFUND.FUNDNUM is '资金项目编号';
comment on column H_EXCUSFUND.MEMBERNUM is '会员号';
comment on column H_EXCUSFUND.UPLOADDATE is '上报日期';
comment on column H_EXCUSFUND.TRADEDATE is '日期';
	
create table H_EXOPTTRDDATA (
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


comment on table H_EXOPTTRDDATA is '衍生品分项资金文件';
comment on column H_EXOPTTRDDATA.BSFLAG is '买卖标志';
comment on column H_EXOPTTRDDATA.OPTIONMONEY is '权利金';
comment on column H_EXOPTTRDDATA.CUFLAG is '备兑标志';
comment on column H_EXOPTTRDDATA.TRANSDATE is '成交日期';
comment on column H_EXOPTTRDDATA.CPTYPE is '期权类型';
comment on column H_EXOPTTRDDATA.CLOSETIME is '成交时间';
comment on column H_EXOPTTRDDATA.OLFLAG is '开平仓标志';
comment on column H_EXOPTTRDDATA.UPLOADDATE is '上报日期';
comment on column H_EXOPTTRDDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column H_EXOPTTRDDATA.CHECKTAG is '检查标识';
comment on column H_EXOPTTRDDATA.VHFLAG is '投机套保标志';
comment on column H_EXOPTTRDDATA.CURRENCY is '币种';
comment on column H_EXOPTTRDDATA.VOLUMN is '成交量';
comment on column H_EXOPTTRDDATA.OPTIONPRICE is '权利金单价';
comment on column H_EXOPTTRDDATA.INSTRUMENTID is '品种合约';
comment on column H_EXOPTTRDDATA.STRICKPRICE is '执行价';
comment on column H_EXOPTTRDDATA.TRANSNUM is '成交流水号';
comment on column H_EXOPTTRDDATA.MEMBERNUM is '会员号';
comment on column H_EXOPTTRDDATA.BASEPRODUCTID is '标的品种';
comment on column H_EXOPTTRDDATA.BASECONTRACTID is '标的合约';
comment on column H_EXOPTTRDDATA.TRADEDATE is '日期';
	
create table H_EXOPTHOLDDATA (
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


comment on table H_EXOPTHOLDDATA is '衍生品持仓明细文件';
comment on column H_EXOPTHOLDDATA.BSFLAG is '买卖标志';
comment on column H_EXOPTHOLDDATA.TODSETTLEPRICE is '今结算价';
comment on column H_EXOPTHOLDDATA.CUFLAG is '备兑标志';
comment on column H_EXOPTHOLDDATA.CPTYPE is '期权类型';
comment on column H_EXOPTHOLDDATA.POSPROFIT is '持仓盈亏';
comment on column H_EXOPTHOLDDATA.UPLOADDATE is '上报日期';
comment on column H_EXOPTHOLDDATA.TRADEMARGIN is '交易保证金';
comment on column H_EXOPTHOLDDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column H_EXOPTHOLDDATA.CHECKTAG is '检查标识';
comment on column H_EXOPTHOLDDATA.VHFLAG is '投机套保标志';
comment on column H_EXOPTHOLDDATA.CURRENCY is '币种';
comment on column H_EXOPTHOLDDATA.INSTRUMENTID is '品种合约';
comment on column H_EXOPTHOLDDATA.STRICKPRICE is '执行价';
comment on column H_EXOPTHOLDDATA.MEMBERNUM is '会员号';
comment on column H_EXOPTHOLDDATA.BASEPRODUCTID is '标的品种';
comment on column H_EXOPTHOLDDATA.POSITION is '持仓量';
comment on column H_EXOPTHOLDDATA.BASECONTRACTID is '标的合约';
comment on column H_EXOPTHOLDDATA.TRADEDATE is '日期';
comment on column H_EXOPTHOLDDATA.YESSETTLEPRICE is '昨结算价';
	
create table H_EXOPTEXERDATA (
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


comment on table H_EXOPTEXERDATA is '衍生品行权明细文件';
comment on column H_EXOPTEXERDATA.BSFLAG is '买卖标志';
comment on column H_EXOPTEXERDATA.EXECDATE is '执行日期';
comment on column H_EXOPTEXERDATA.FREEZFUNDS is '冻结资金';
comment on column H_EXOPTEXERDATA.CPTYPE is '期权类型';
comment on column H_EXOPTEXERDATA.UPLOADDATE is '上报日期';
comment on column H_EXOPTEXERDATA.EXECTIME is '执行时间';
comment on column H_EXOPTEXERDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column H_EXOPTEXERDATA.CHECKTAG is '检查标识';
comment on column H_EXOPTEXERDATA.EXECFIXFUND is '行权锁定保证金';
comment on column H_EXOPTEXERDATA.VHFLAG is '投机套保标志';
comment on column H_EXOPTEXERDATA.EXECPRICE is '执行价';
comment on column H_EXOPTEXERDATA.CURRENCY is '币种';
comment on column H_EXOPTEXERDATA.EXECFEE is '行权结算费（手续费）';
comment on column H_EXOPTEXERDATA.EXECNUM is '执行手数';
comment on column H_EXOPTEXERDATA.INSTRUMENTID is '品种合约';
comment on column H_EXOPTEXERDATA.TRANSNUM is '流水号';
comment on column H_EXOPTEXERDATA.MEMBERNUM is '会员号';
comment on column H_EXOPTEXERDATA.EXECPROFIT is '行权盈亏';
comment on column H_EXOPTEXERDATA.BASEPRODUCTID is '标的品种';
comment on column H_EXOPTEXERDATA.BASECONTRACTID is '标的合约';
comment on column H_EXOPTEXERDATA.TRADEDATE is '日期';
	
create table H_EXSEFUND (
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


comment on table H_EXSEFUND is '现货资金文件';
comment on column H_EXSEFUND.SETTLEDATE is '交收日期';
comment on column H_EXSEFUND.SELLAMOUNT is '净卖金额';
comment on column H_EXSEFUND.HANDFEE is '经手费';
comment on column H_EXSEFUND.MEMBERDATE is '会员号';
comment on column H_EXSEFUND.SECFEE is '证管费';
comment on column H_EXSEFUND.NOTE is '备注';
comment on column H_EXSEFUND.UPLOADDATE is '上报日期';
comment on column H_EXSEFUND.CLEARDATE is '清算日期';
comment on column H_EXSEFUND.CLEARAMOUNT is '清算金额';
comment on column H_EXSEFUND.TRANSFERFEE is '过户费';
comment on column H_EXSEFUND.STAMPTAX is '印花税';
comment on column H_EXSEFUND.CHECKTAG is '检查标识';
comment on column H_EXSEFUND.ACCOUNTNUM is '资金账户';
comment on column H_EXSEFUND.CURRENCY is '币种';
comment on column H_EXSEFUND.BUYAMOUNT is '净买金额';
comment on column H_EXSEFUND.TODAYFUNDS is '当日资金余额';
comment on column H_EXSEFUND.ACTUALPAY is '实际收付';
comment on column H_EXSEFUND.LOWSETTLEMENT is '最低结算备付金';
comment on column H_EXSEFUND.OTHERFEES is '其他费用';
comment on column H_EXSEFUND.TRADEDATE is '日期';
comment on column H_EXSEFUND.FEE is '手续费';
	
create table H_EXSETRDDATA (
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


comment on table H_EXSETRDDATA is '现货资金文件';
comment on column H_EXSETRDDATA.CHANGETYPE is '变动类型';
comment on column H_EXSETRDDATA.PRICE is '成交价格';
comment on column H_EXSETRDDATA.SECURIACCOUNTID is '客户证券账户';
comment on column H_EXSETRDDATA.TRANSDATE is '成交日期';
comment on column H_EXSETRDDATA.ACCOUNTNUM is '资金账户号码';
comment on column H_EXSETRDDATA.VOLUMN is '成交数量';
comment on column H_EXSETRDDATA.RIGHTTYPE is '权益类别';
comment on column H_EXSETRDDATA.EXCHANGEID is '交易所统一标识';
comment on column H_EXSETRDDATA.TRADEDATE is '日期';
comment on column H_EXSETRDDATA.CIRCUTYPE is '流通类型';
comment on column H_EXSETRDDATA.FEE is '手续费';
comment on column H_EXSETRDDATA.BSFLAG is '买卖标志';
comment on column H_EXSETRDDATA.HANDFEE is '经手费';
comment on column H_EXSETRDDATA.MEMBERDATE is '会员号';
comment on column H_EXSETRDDATA.SETTLEVOLUMN is '交收数量';
comment on column H_EXSETRDDATA.SECFEE is '证管费';
comment on column H_EXSETRDDATA.TRADETRANSNUM is '成交流水号';
comment on column H_EXSETRDDATA.SECURICODE is '证券代码';
comment on column H_EXSETRDDATA.SECURITYPE is '证券类别';
comment on column H_EXSETRDDATA.UPLOADDATE is '上报日期';
comment on column H_EXSETRDDATA.CLEARAMOUNT is '清算金额';
comment on column H_EXSETRDDATA.TRANSFERFEE is '过户费';
comment on column H_EXSETRDDATA.SECURINAME is '证券的中文简称';
comment on column H_EXSETRDDATA.STAMPTAX is '印花税';
comment on column H_EXSETRDDATA.CHECKTAG is '检查标识';
comment on column H_EXSETRDDATA.CURRENCY is '币种';
comment on column H_EXSETRDDATA.TRANSTIME is '成交时间';
comment on column H_EXSETRDDATA.OTHERFEES is '其他费用';
comment on column H_EXSETRDDATA.HANGYEAR is '挂牌年份';
	
create table H_EXSEPOSDATA (
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


comment on table H_EXSEPOSDATA is '现货持仓明细文件';
comment on column H_EXSEPOSDATA.SECURIACCOUNTID is '客户证券账户';
comment on column H_EXSEPOSDATA.SECURICODE is '证券代码';
comment on column H_EXSEPOSDATA.SECURITYPE is '证券类别';
comment on column H_EXSEPOSDATA.UPLOADDATE is '上报日期';
comment on column H_EXSEPOSDATA.SECURINAME is '证券的中文简称';
comment on column H_EXSEPOSDATA.CHECKTAG is '检查标识';
comment on column H_EXSEPOSDATA.HPFLAG is '交易所统一标识';
comment on column H_EXSEPOSDATA.RIGHTTYPE is '权益类别';
comment on column H_EXSEPOSDATA.MEMBERNUM is '会员号';
comment on column H_EXSEPOSDATA.POSITION is '持仓量';
comment on column H_EXSEPOSDATA.TRADEDATE is '日期';
comment on column H_EXSEPOSDATA.CIRCUTYPE is '流通类型';
comment on column H_EXSEPOSDATA.HANGYEAR is '挂牌年份';
	
alter table H_COMPCLIENTOPTEXERCISE add column EXECMARGIN NUMBER(15,3)  ;
alter table H_COMPCLIENTOPTEXERCISE add column FREEZFUNDS NUMBER(20,3)  ;
	
create table D_EXZHMEMBER (
		CHECKTAG CHAR(4)  
		,MENBERNAME VARCHAR2(40)  
		,TRADETYPE CHAR(1)  
		,SHORTNAME VARCHAR2(10)  
		,SETTLETYPE CHAR(1)  
		,MEMBERNUM VARCHAR2(5)  
		,UPLOADDATE CHAR(10)  
		,TRADEDATE VARCHAR2(10)  
);


comment on table D_EXZHMEMBER is '会员基本资料文件';
comment on column D_EXZHMEMBER.CHECKTAG is '检查标识';
comment on column D_EXZHMEMBER.MENBERNAME is '会员名称';
comment on column D_EXZHMEMBER.TRADETYPE is '会员交易类型';
comment on column D_EXZHMEMBER.SHORTNAME is '会员简称';
comment on column D_EXZHMEMBER.SETTLETYPE is '会员结算类型';
comment on column D_EXZHMEMBER.MEMBERNUM is '会员号';
comment on column D_EXZHMEMBER.UPLOADDATE is '上报日期';
comment on column D_EXZHMEMBER.TRADEDATE is '日期';
	
create table D_EXCUSTOMER (
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


comment on table D_EXCUSTOMER is '客户基本资料文件';
comment on column D_EXCUSTOMER.ORGNUMBER is '组织机构代码证号';
comment on column D_EXCUSTOMER.SECURIACCOUNTID is '客户证券账户';
comment on column D_EXCUSTOMER.SUBNUMBER is '二级代理商编号';
comment on column D_EXCUSTOMER.TRADETYPE is '交易编码类型';
comment on column D_EXCUSTOMER.CONTACTS is '联系人';
comment on column D_EXCUSTOMER.AUTHORTYPE is '有效身份证明文件类别';
comment on column D_EXCUSTOMER.OPENDATE is '客户开户日期';
comment on column D_EXCUSTOMER.ORGDEADLINE is '组织机构代码证有效期截止日期';
comment on column D_EXCUSTOMER.PHONE is '联系电话';
comment on column D_EXCUSTOMER.BUSINESSNUM is '商业登记证号';
comment on column D_EXCUSTOMER.CONTACTCOUNTRY is '经办人国籍/地区';
comment on column D_EXCUSTOMER.POSTALCODE is '邮政编码';
comment on column D_EXCUSTOMER.READDRESS is '注册地址';
comment on column D_EXCUSTOMER.VALIDIDENTITY is '有效身份证明文件号码';
comment on column D_EXCUSTOMER.MENBERNUM is '所属会员号';
comment on column D_EXCUSTOMER.OCFLAG is '开户和销户标志';
comment on column D_EXCUSTOMER.POSTALADDRESS is '通讯地址';
comment on column D_EXCUSTOMER.AUTHORNAME is '开户授权人名称';
comment on column D_EXCUSTOMER.TRADEDATE is '日期';
comment on column D_EXCUSTOMER.LEGALPERSON is '法定代表人、执行事务合伙人或负责人';
comment on column D_EXCUSTOMER.IDENTITYNUM is '身份证';
comment on column D_EXCUSTOMER.COUNTRY is '国籍/地区 ';
comment on column D_EXCUSTOMER.ADDRESS is '所在地';
comment on column D_EXCUSTOMER.CUSTOMERTYPE is '客户类型';
comment on column D_EXCUSTOMER.UPLOADDATE is '上报日期';
comment on column D_EXCUSTOMER.IDDEADLINE is '身份证明文件有效期截止日期';
comment on column D_EXCUSTOMER.OVERSEASFLAG is '境外客户标识';
comment on column D_EXCUSTOMER.CUSTOMERNAME is '名称';
comment on column D_EXCUSTOMER.PASSPORT is '护照号码，港澳台通行证号码, 或外国永久居留证号码';
comment on column D_EXCUSTOMER.DERIVATIVENUM is '客户衍生品合约账户';
comment on column D_EXCUSTOMER.CHECKTAG is '检查标识';
comment on column D_EXCUSTOMER.CONTACTADDR is '经办人联系地址';
comment on column D_EXCUSTOMER.ACCOUNTSTATE is '账户休眠状态';
comment on column D_EXCUSTOMER.MAILADDRESS is '电子邮件地址及网址';
comment on column D_EXCUSTOMER.AUTHORIDENTITY is '开户授权人有效身份证明文件号码';
	
create table D_EXFIRMFUND (
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


comment on table D_EXFIRMFUND is '衍生品资金文件';
comment on column D_EXFIRMFUND.FREEZFUNDS is '冻结资金';
comment on column D_EXFIRMFUND.DELIVERYMARGIN is '交割保证金';
comment on column D_EXFIRMFUND.OFFSETCHANGEAMOUNT is '货币充抵变动额';
comment on column D_EXFIRMFUND.TOTALFEE is '各类手续费清算值合计';
comment on column D_EXFIRMFUND.ACCOUNTNUM is '资金账户号码';
comment on column D_EXFIRMFUND.TODAYPROFIT is '当日总盈亏';
comment on column D_EXFIRMFUND.LOWSETTLEMENTS is '最低结算准备金';
comment on column D_EXFIRMFUND.TOTALRIGHTS is '会员权益总额';
comment on column D_EXFIRMFUND.TODAYFUNDS is '当日资金交收合计';
comment on column D_EXFIRMFUND.MENBERNUM is '会员号';
comment on column D_EXFIRMFUND.MONERYOUT is '出金';
comment on column D_EXFIRMFUND.NONCHANGEAMOUNT is '非货币充抵变动额';
comment on column D_EXFIRMFUND.SETTLEMENT is '结算准备金';
comment on column D_EXFIRMFUND.TRADEDATE is '日期 ';
comment on column D_EXFIRMFUND.CURRENCYFUND is '实有货币资金';
comment on column D_EXFIRMFUND.CONVERAMOUNT is '货币折抵金额';
comment on column D_EXFIRMFUND.OTHERSETTLEFUNDS is '其它交收资金清算值合计';
comment on column D_EXFIRMFUND.TODAYTOTALRIGHTS is '当日总权利金';
comment on column D_EXFIRMFUND.UPLOADDATE is '上报日期';
comment on column D_EXFIRMFUND.TRADEMARGIN is '交易保证金';
comment on column D_EXFIRMFUND.EXSETTLEFUNDS is '行权交收资金清算值合计';
comment on column D_EXFIRMFUND.CHECKTAG is '检查标识';
comment on column D_EXFIRMFUND.CURRENCY is '币种';
comment on column D_EXFIRMFUND.ACCOUNTTYPE is '资金账户类型';
comment on column D_EXFIRMFUND.MONERYIN is '入金';
comment on column D_EXFIRMFUND.OFFSETAMOUNT is '货币充抵金额';
comment on column D_EXFIRMFUND.YESTERDAYRIGHTS is '上日会员权益总额';
comment on column D_EXFIRMFUND.NONAMOUNT is '非货币充抵金额';
	
create table D_EXFUNDCHG (
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


comment on table D_EXFUNDCHG is '期货公司出入金文件';
comment on column D_EXFUNDCHG.INOUTDATE is '出入金发生日期';
comment on column D_EXFUNDCHG.CHECKTAG is '检查标识';
comment on column D_EXFUNDCHG.ACCOUNTNUM is '资金账户号码';
comment on column D_EXFUNDCHG.CURRENCY is '币种';
comment on column D_EXFUNDCHG.INOUTACCOUNTTYPE is '出入金账户类型';
comment on column D_EXFUNDCHG.BANKID is '银行统一标识';
comment on column D_EXFUNDCHG.INOUTTYPE is '出入金类型';
comment on column D_EXFUNDCHG.ACCOUNTTYPE is '资金账户类型';
comment on column D_EXFUNDCHG.FUNDCHGAMOUNT is '资金变动额';
comment on column D_EXFUNDCHG.MEMBERNUM is '会员号';
comment on column D_EXFUNDCHG.UPLOADDATE is '上报日期';
comment on column D_EXFUNDCHG.TRADEDATE is '日期';
	
create table D_EXCUSFUND (
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


comment on table D_EXCUSFUND is '衍生品分项资金文件';
comment on column D_EXCUSFUND.FUNDAMOUNT is '资金金额';
comment on column D_EXCUSFUND.DERIVATIVENUM is '客户衍生品合约账户';
comment on column D_EXCUSFUND.CHECKTAG is '检查标识';
comment on column D_EXCUSFUND.ACCOUNTNUM is '资金账户号码';
comment on column D_EXCUSFUND.CURRENCY is '币种';
comment on column D_EXCUSFUND.FUNDNUM is '资金项目编号';
comment on column D_EXCUSFUND.MEMBERNUM is '会员号';
comment on column D_EXCUSFUND.UPLOADDATE is '上报日期';
comment on column D_EXCUSFUND.TRADEDATE is '日期';
	
create table D_EXOPTTRDDATA (
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


comment on table D_EXOPTTRDDATA is '衍生品分项资金文件';
comment on column D_EXOPTTRDDATA.BSFLAG is '买卖标志';
comment on column D_EXOPTTRDDATA.OPTIONMONEY is '权利金';
comment on column D_EXOPTTRDDATA.CUFLAG is '备兑标志';
comment on column D_EXOPTTRDDATA.TRANSDATE is '成交日期';
comment on column D_EXOPTTRDDATA.CPTYPE is '期权类型';
comment on column D_EXOPTTRDDATA.CLOSETIME is '成交时间';
comment on column D_EXOPTTRDDATA.OLFLAG is '开平仓标志';
comment on column D_EXOPTTRDDATA.UPLOADDATE is '上报日期';
comment on column D_EXOPTTRDDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column D_EXOPTTRDDATA.CHECKTAG is '检查标识';
comment on column D_EXOPTTRDDATA.VHFLAG is '投机套保标志';
comment on column D_EXOPTTRDDATA.CURRENCY is '币种';
comment on column D_EXOPTTRDDATA.VOLUMN is '成交量';
comment on column D_EXOPTTRDDATA.OPTIONPRICE is '权利金单价';
comment on column D_EXOPTTRDDATA.INSTRUMENTID is '品种合约';
comment on column D_EXOPTTRDDATA.STRICKPRICE is '执行价';
comment on column D_EXOPTTRDDATA.TRANSNUM is '成交流水号';
comment on column D_EXOPTTRDDATA.MEMBERNUM is '会员号';
comment on column D_EXOPTTRDDATA.BASEPRODUCTID is '标的品种';
comment on column D_EXOPTTRDDATA.BASECONTRACTID is '标的合约';
comment on column D_EXOPTTRDDATA.TRADEDATE is '日期';
	
create table D_EXOPTHOLDDATA (
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


comment on table D_EXOPTHOLDDATA is '衍生品持仓明细文件';
comment on column D_EXOPTHOLDDATA.BSFLAG is '买卖标志';
comment on column D_EXOPTHOLDDATA.TODSETTLEPRICE is '今结算价';
comment on column D_EXOPTHOLDDATA.CUFLAG is '备兑标志';
comment on column D_EXOPTHOLDDATA.CPTYPE is '期权类型';
comment on column D_EXOPTHOLDDATA.POSPROFIT is '持仓盈亏';
comment on column D_EXOPTHOLDDATA.UPLOADDATE is '上报日期';
comment on column D_EXOPTHOLDDATA.TRADEMARGIN is '交易保证金';
comment on column D_EXOPTHOLDDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column D_EXOPTHOLDDATA.CHECKTAG is '检查标识';
comment on column D_EXOPTHOLDDATA.VHFLAG is '投机套保标志';
comment on column D_EXOPTHOLDDATA.CURRENCY is '币种';
comment on column D_EXOPTHOLDDATA.INSTRUMENTID is '品种合约';
comment on column D_EXOPTHOLDDATA.STRICKPRICE is '执行价';
comment on column D_EXOPTHOLDDATA.MEMBERNUM is '会员号';
comment on column D_EXOPTHOLDDATA.BASEPRODUCTID is '标的品种';
comment on column D_EXOPTHOLDDATA.POSITION is '持仓量';
comment on column D_EXOPTHOLDDATA.BASECONTRACTID is '标的合约';
comment on column D_EXOPTHOLDDATA.TRADEDATE is '日期';
comment on column D_EXOPTHOLDDATA.YESSETTLEPRICE is '昨结算价';
	
create table D_EXOPTEXERDATA (
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


comment on table D_EXOPTEXERDATA is '衍生品行权明细文件';
comment on column D_EXOPTEXERDATA.BSFLAG is '买卖标志';
comment on column D_EXOPTEXERDATA.EXECDATE is '执行日期';
comment on column D_EXOPTEXERDATA.FREEZFUNDS is '冻结资金';
comment on column D_EXOPTEXERDATA.CPTYPE is '期权类型';
comment on column D_EXOPTEXERDATA.UPLOADDATE is '上报日期';
comment on column D_EXOPTEXERDATA.EXECTIME is '执行时间';
comment on column D_EXOPTEXERDATA.DERIVATIVENUM is '客户衍生品合约账户';
comment on column D_EXOPTEXERDATA.CHECKTAG is '检查标识';
comment on column D_EXOPTEXERDATA.EXECFIXFUND is '行权锁定保证金';
comment on column D_EXOPTEXERDATA.VHFLAG is '投机套保标志';
comment on column D_EXOPTEXERDATA.EXECPRICE is '执行价';
comment on column D_EXOPTEXERDATA.CURRENCY is '币种';
comment on column D_EXOPTEXERDATA.EXECFEE is '行权结算费（手续费）';
comment on column D_EXOPTEXERDATA.EXECNUM is '执行手数';
comment on column D_EXOPTEXERDATA.INSTRUMENTID is '品种合约';
comment on column D_EXOPTEXERDATA.TRANSNUM is '流水号';
comment on column D_EXOPTEXERDATA.MEMBERNUM is '会员号';
comment on column D_EXOPTEXERDATA.EXECPROFIT is '行权盈亏';
comment on column D_EXOPTEXERDATA.BASEPRODUCTID is '标的品种';
comment on column D_EXOPTEXERDATA.BASECONTRACTID is '标的合约';
comment on column D_EXOPTEXERDATA.TRADEDATE is '日期';
	
create table D_EXSEFUND (
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


comment on table D_EXSEFUND is '现货资金文件';
comment on column D_EXSEFUND.SETTLEDATE is '交收日期';
comment on column D_EXSEFUND.SELLAMOUNT is '净卖金额';
comment on column D_EXSEFUND.HANDFEE is '经手费';
comment on column D_EXSEFUND.MEMBERDATE is '会员号';
comment on column D_EXSEFUND.SECFEE is '证管费';
comment on column D_EXSEFUND.NOTE is '备注';
comment on column D_EXSEFUND.UPLOADDATE is '上报日期';
comment on column D_EXSEFUND.CLEARDATE is '清算日期';
comment on column D_EXSEFUND.CLEARAMOUNT is '清算金额';
comment on column D_EXSEFUND.TRANSFERFEE is '过户费';
comment on column D_EXSEFUND.STAMPTAX is '印花税';
comment on column D_EXSEFUND.CHECKTAG is '检查标识';
comment on column D_EXSEFUND.ACCOUNTNUM is '资金账户';
comment on column D_EXSEFUND.CURRENCY is '币种';
comment on column D_EXSEFUND.BUYAMOUNT is '净买金额';
comment on column D_EXSEFUND.TODAYFUNDS is '当日资金余额';
comment on column D_EXSEFUND.ACTUALPAY is '实际收付';
comment on column D_EXSEFUND.LOWSETTLEMENT is '最低结算备付金';
comment on column D_EXSEFUND.OTHERFEES is '其他费用';
comment on column D_EXSEFUND.TRADEDATE is '日期';
comment on column D_EXSEFUND.FEE is '手续费';
	
create table D_EXSETRDDATA (
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


comment on table D_EXSETRDDATA is '现货资金文件';
comment on column D_EXSETRDDATA.CHANGETYPE is '变动类型';
comment on column D_EXSETRDDATA.PRICE is '成交价格';
comment on column D_EXSETRDDATA.SECURIACCOUNTID is '客户证券账户';
comment on column D_EXSETRDDATA.TRANSDATE is '成交日期';
comment on column D_EXSETRDDATA.ACCOUNTNUM is '资金账户号码';
comment on column D_EXSETRDDATA.VOLUMN is '成交数量';
comment on column D_EXSETRDDATA.RIGHTTYPE is '权益类别';
comment on column D_EXSETRDDATA.EXCHANGEID is '交易所统一标识';
comment on column D_EXSETRDDATA.TRADEDATE is '日期';
comment on column D_EXSETRDDATA.CIRCUTYPE is '流通类型';
comment on column D_EXSETRDDATA.FEE is '手续费';
comment on column D_EXSETRDDATA.BSFLAG is '买卖标志';
comment on column D_EXSETRDDATA.HANDFEE is '经手费';
comment on column D_EXSETRDDATA.MEMBERDATE is '会员号';
comment on column D_EXSETRDDATA.SETTLEVOLUMN is '交收数量';
comment on column D_EXSETRDDATA.SECFEE is '证管费';
comment on column D_EXSETRDDATA.TRADETRANSNUM is '成交流水号';
comment on column D_EXSETRDDATA.SECURICODE is '证券代码';
comment on column D_EXSETRDDATA.SECURITYPE is '证券类别';
comment on column D_EXSETRDDATA.UPLOADDATE is '上报日期';
comment on column D_EXSETRDDATA.CLEARAMOUNT is '清算金额';
comment on column D_EXSETRDDATA.TRANSFERFEE is '过户费';
comment on column D_EXSETRDDATA.SECURINAME is '证券的中文简称';
comment on column D_EXSETRDDATA.STAMPTAX is '印花税';
comment on column D_EXSETRDDATA.CHECKTAG is '检查标识';
comment on column D_EXSETRDDATA.CURRENCY is '币种';
comment on column D_EXSETRDDATA.TRANSTIME is '成交时间';
comment on column D_EXSETRDDATA.OTHERFEES is '其他费用';
comment on column D_EXSETRDDATA.HANGYEAR is '挂牌年份';
	
create table D_EXSEPOSDATA (
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


comment on table D_EXSEPOSDATA is '现货持仓明细文件';
comment on column D_EXSEPOSDATA.SECURIACCOUNTID is '客户证券账户';
comment on column D_EXSEPOSDATA.SECURICODE is '证券代码';
comment on column D_EXSEPOSDATA.SECURITYPE is '证券类别';
comment on column D_EXSEPOSDATA.UPLOADDATE is '上报日期';
comment on column D_EXSEPOSDATA.SECURINAME is '证券的中文简称';
comment on column D_EXSEPOSDATA.CHECKTAG is '检查标识';
comment on column D_EXSEPOSDATA.HPFLAG is '交易所统一标识';
comment on column D_EXSEPOSDATA.RIGHTTYPE is '权益类别';
comment on column D_EXSEPOSDATA.MEMBERNUM is '会员号';
comment on column D_EXSEPOSDATA.POSITION is '持仓量';
comment on column D_EXSEPOSDATA.TRADEDATE is '日期';
comment on column D_EXSEPOSDATA.CIRCUTYPE is '流通类型';
comment on column D_EXSEPOSDATA.HANGYEAR is '挂牌年份';
	
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
	
