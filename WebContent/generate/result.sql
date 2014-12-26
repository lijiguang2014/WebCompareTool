spool CreateTable.log
--******************************
--创建仓单文件
--******************************
drop table H_EXWARRANT;

create table H_EXWARRANT
(
	WAREHOUSEID varchar2(10) not null
	,EXCOMPANYID char(4) not null
	,COMMODITYID varchar2(2) not null
	,EXCHANGEID varchar2(2) not null
	,EXCLIENTID varchar2(8) not null
	,UPLOADDATE char(10) not null
	,WARRANTAMOUNT number(10) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXWARRANT is '仓单文件';
	comment on column H_EXWARRANT.WAREHOUSEID is '仓库编号';
	comment on column H_EXWARRANT.EXCOMPANYID is '会员号';
	comment on column H_EXWARRANT.COMMODITYID is '品种';
	comment on column H_EXWARRANT.EXCHANGEID is '交易所代码';
	comment on column H_EXWARRANT.EXCLIENTID is '客户编码';
	comment on column H_EXWARRANT.UPLOADDATE is '上报日期';
	comment on column H_EXWARRANT.WARRANTAMOUNT is '仓单数量';
	comment on column H_EXWARRANT.TRADEDATE is '交易日';


--******************************
--创建客户基本资料文件
--******************************
drop table H_EXCLIENT;

create table H_EXCLIENT
(
	CLIENTSTATE char(1) not null
	,EXCLIENTIDTYPE char(1) not null
	,NAME varchar2(100) not null
	,REALOPENDATE char(10) not null
	,IDENTITY varchar2(40) 
	,ADDRESS varchar2(200) not null
	,POSTCODE char(6) not null
	,LOCATE varchar2(40) not null
	,OPENDATE char(10) not null
	,DEPUTYIDENTITY varchar2(40) 
	,TELEPHONE varchar2(40) not null
	,UPLOADDATE char(10) not null
	,CLIENTTYPE char(1) not null
	,EXCOMPANYID char(4) not null
	,DEPUTYNAME varchar2(40) 
	,BUSINESSCODE varchar2(40) 
	,EXCHANGEID varchar2(2) not null
	,EXCLIENTID varchar2(8) not null
	,ORGANCODE varchar2(40) 
);

comment on table H_EXCLIENT is '客户基本资料文件';
	comment on column H_EXCLIENT.CLIENTSTATE is '账户休眠状态';
	comment on column H_EXCLIENT.EXCLIENTIDTYPE is '交易编码类型';
	comment on column H_EXCLIENT.NAME is '客户名称';
	comment on column H_EXCLIENT.REALOPENDATE is '客户开户日期';
	comment on column H_EXCLIENT.IDENTITY is '身份证';
	comment on column H_EXCLIENT.ADDRESS is '通讯地址';
	comment on column H_EXCLIENT.POSTCODE is '邮政编码';
	comment on column H_EXCLIENT.LOCATE is '所在地';
	comment on column H_EXCLIENT.OPENDATE is '交易日期';
	comment on column H_EXCLIENT.DEPUTYIDENTITY is '开户授权人身份证';
	comment on column H_EXCLIENT.TELEPHONE is '联系电话';
	comment on column H_EXCLIENT.UPLOADDATE is '上报日期';
	comment on column H_EXCLIENT.CLIENTTYPE is '客户类型';
	comment on column H_EXCLIENT.EXCOMPANYID is '所属会员号';
	comment on column H_EXCLIENT.DEPUTYNAME is '开户授权人名称';
	comment on column H_EXCLIENT.BUSINESSCODE is '组织机构代码证号';
	comment on column H_EXCLIENT.EXCHANGEID is '交易所代码';
	comment on column H_EXCLIENT.EXCLIENTID is '客户编码';
	comment on column H_EXCLIENT.ORGANCODE is '营业执照号';


--******************************
--创建待交割结算合约文件
--******************************
drop table H_EXDELIVCONTRACTDATA;

create table H_EXDELIVCONTRACTDATA
(
	DELIVTYPE char(1) not null
	,OPENPRICE number(15,3) not null
	,DELIVSETTLEPRICE number(15,3) not null
	,CONTRACTID varchar2(6) not null
	,DELIVMARGIN number(15,3) not null
	,UPLOADDATE char(10) not null
	,TRADESEQ varchar2(8) 
	,CURRENCY char(3) not null
	,EXCOMPANYID char(4) not null
	,BSTAG char(1) not null
	,EXCHANGEID varchar2(2) not null
	,EXCLIENTID varchar2(8) not null
	,POSITION number(10) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXDELIVCONTRACTDATA is '待交割结算合约文件';
	comment on column H_EXDELIVCONTRACTDATA.DELIVTYPE is '交割类型';
	comment on column H_EXDELIVCONTRACTDATA.OPENPRICE is '开仓价';
	comment on column H_EXDELIVCONTRACTDATA.DELIVSETTLEPRICE is '交割结算价';
	comment on column H_EXDELIVCONTRACTDATA.CONTRACTID is '品种合约';
	comment on column H_EXDELIVCONTRACTDATA.DELIVMARGIN is '交割保证金';
	comment on column H_EXDELIVCONTRACTDATA.UPLOADDATE is '上报日期';
	comment on column H_EXDELIVCONTRACTDATA.TRADESEQ is '成交流水号';
	comment on column H_EXDELIVCONTRACTDATA.CURRENCY is '币种';
	comment on column H_EXDELIVCONTRACTDATA.EXCOMPANYID is '会员号';
	comment on column H_EXDELIVCONTRACTDATA.BSTAG is '买卖标志';
	comment on column H_EXDELIVCONTRACTDATA.EXCHANGEID is '交易所代码';
	comment on column H_EXDELIVCONTRACTDATA.EXCLIENTID is '客户编码';
	comment on column H_EXDELIVCONTRACTDATA.POSITION is '待交割持仓量';
	comment on column H_EXDELIVCONTRACTDATA.TRADEDATE is '交易日';


--******************************
--创建委托响应数据
--******************************
drop table H_EXORDER;

create table H_EXORDER
(
	CONTRACTCODE varchar2(30) not null
	,TRADEUSERCODE varchar2(15) not null
	,TRIGGERCONDITION char(1) not null
	,DECLAREDPRICE number(12,3) not null
	,ORDERSOURCE char(1) not null
	,VOLUMNED number(19,3) not null
	,REPORTNUM varchar2(12) not null
	,DECLAREDAMOUNT number(19,3) not null
	,EXCOMPANYCODE varchar2(10) not null
	,LASTMODIFYTIME char(8) not null
	,VHFLAG char(1) not null
	,BSTAG char(1) not null
	,VOLUMNTYPE char(1) not null
	,NUMBERCODE varchar2(10) not null
	,ORDERTYPE char(1) not null
	,EXCHANGEID varchar2(2) not null
	,SQUAREREASON char(1) not null
	,ACTIVATIONTIME char(8) not null
	,ORDERDATE char(10) not null
	,TRADEDATE char(10) not null
	,MINVOLUMN number(19,3) 
	,EXCLIENTCODE varchar2(10) not null
	,ORDERSTATE char(1) not null
	,LOCALNUM varchar2(12) not null
	,REMAINING number(19,3) not null
	,PVTYPE char(1) not null
	,MODIFYUSERCODE varchar2(15) not null
	,TRIGGERPRICE number(12,3) 
	,ORDERTIME char(8) not null
	,UPLOADDATE char(10) not null
	,PRICECONDITION char(1) not null
	,HANGTIME char(8) not null
	,CANCLETIME char(8) not null
	,OCTAG char(1) not null
	,BUSINESSDATE char(10) not null
);

comment on table H_EXORDER is '委托响应数据';
	comment on column H_EXORDER.CONTRACTCODE is '合约代码';
	comment on column H_EXORDER.TRADEUSERCODE is '交易用户代码';
	comment on column H_EXORDER.TRIGGERCONDITION is '触发条件';
	comment on column H_EXORDER.DECLAREDPRICE is '申报价格';
	comment on column H_EXORDER.ORDERSOURCE is '报单来源';
	comment on column H_EXORDER.VOLUMNED is '已成交数量';
	comment on column H_EXORDER.REPORTNUM is '报单编号';
	comment on column H_EXORDER.DECLAREDAMOUNT is '申报数量';
	comment on column H_EXORDER.EXCOMPANYCODE is '会员代码';
	comment on column H_EXORDER.LASTMODIFYTIME is '最后修改时间';
	comment on column H_EXORDER.VHFLAG is '投机套保标志';
	comment on column H_EXORDER.BSTAG is '买卖方向';
	comment on column H_EXORDER.VOLUMNTYPE is '成交量类型 ';
	comment on column H_EXORDER.NUMBERCODE is '结算会员代码';
	comment on column H_EXORDER.ORDERTYPE is '报单类型';
	comment on column H_EXORDER.EXCHANGEID is '交易所代码';
	comment on column H_EXORDER.SQUAREREASON is '强平原因';
	comment on column H_EXORDER.ACTIVATIONTIME is '激活时间';
	comment on column H_EXORDER.ORDERDATE is '报单日期';
	comment on column H_EXORDER.TRADEDATE is '交易日期';
	comment on column H_EXORDER.MINVOLUMN is '最小成交量';
	comment on column H_EXORDER.EXCLIENTCODE is '客户代码';
	comment on column H_EXORDER.ORDERSTATE is '报单状态';
	comment on column H_EXORDER.LOCALNUM is '本地报单编号';
	comment on column H_EXORDER.REMAINING is '剩余数量';
	comment on column H_EXORDER.PVTYPE is '有效期类型';
	comment on column H_EXORDER.MODIFYUSERCODE is '最后修改交易用户代码';
	comment on column H_EXORDER.TRIGGERPRICE is '触发价格';
	comment on column H_EXORDER.ORDERTIME is '报单时间';
	comment on column H_EXORDER.UPLOADDATE is '上报日期';
	comment on column H_EXORDER.PRICECONDITION is '报单价格条件';
	comment on column H_EXORDER.HANGTIME is '挂起时间';
	comment on column H_EXORDER.CANCLETIME is '撤销时间';
	comment on column H_EXORDER.OCTAG is '开平标志';
	comment on column H_EXORDER.BUSINESSDATE is '业务发生日期';


--******************************
--创建成交明细文件
--******************************
drop table H_EXCLITRDDETAIL;

create table H_EXCLITRDDETAIL
(
	PRICE number(15,3) not null
	,TRANSDATE char(10) not null
	,CONTRACTID varchar2(6) not null
	,AMOUNT number(15,3) not null
	,UPLOADDATE char(10) not null
	,TRADESEQ varchar2(8) not null
	,VHFLAG char(1) not null
	,CURRENCY char(3) not null
	,EXCOMPANYID char(4) not null
	,BSTAG char(1) not null
	,VOLUMN number(10) not null
	,EXCHANGEID varchar2(2) not null
	,TRADETIME char(8) not null
	,EXCLIENTID varchar2(8) not null
	,CLOSEPROFIT number(15,3) 
	,OCTAG char(1) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXCLITRDDETAIL is '成交明细文件';
	comment on column H_EXCLITRDDETAIL.PRICE is '成交价';
	comment on column H_EXCLITRDDETAIL.TRANSDATE is '成交日期';
	comment on column H_EXCLITRDDETAIL.CONTRACTID is '品种合约';
	comment on column H_EXCLITRDDETAIL.AMOUNT is '成交额';
	comment on column H_EXCLITRDDETAIL.UPLOADDATE is '上报日期';
	comment on column H_EXCLITRDDETAIL.TRADESEQ is '成交流水号';
	comment on column H_EXCLITRDDETAIL.VHFLAG is '投机套保标志';
	comment on column H_EXCLITRDDETAIL.CURRENCY is '币种';
	comment on column H_EXCLITRDDETAIL.EXCOMPANYID is '会员号';
	comment on column H_EXCLITRDDETAIL.BSTAG is '买卖标志';
	comment on column H_EXCLITRDDETAIL.VOLUMN is '成交量';
	comment on column H_EXCLITRDDETAIL.EXCHANGEID is '交易所代码';
	comment on column H_EXCLITRDDETAIL.TRADETIME is '成交时间';
	comment on column H_EXCLITRDDETAIL.EXCLIENTID is '客户编码';
	comment on column H_EXCLITRDDETAIL.CLOSEPROFIT is '平仓盈亏';
	comment on column H_EXCLITRDDETAIL.OCTAG is '开平仓标志';
	comment on column H_EXCLITRDDETAIL.TRADEDATE is '交易日';


--******************************
--创建持仓明细文件
--******************************
drop table H_EXCLIPOSDETAIL;

create table H_EXCLIPOSDETAIL
(
	LASTSETTLEPRICE number(15,3) not null
	,CONTRACTID varchar2(6) not null
	,TRADEMARGIN number(15,3) not null
	,POSITIONPROFIT number(15,3) 
	,UPLOADDATE char(10) not null
	,VHFLAG char(1) not null
	,CURRENCY char(3) not null
	,EXCOMPANYID char(4) not null
	,BSTAG char(1) not null
	,TODAYSETTLEPRICE number(15,3) not null
	,EXCHANGEID varchar2(2) not null
	,EXCLIENTID varchar2(8) not null
	,POSITION number(10) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXCLIPOSDETAIL is '持仓明细文件';
	comment on column H_EXCLIPOSDETAIL.LASTSETTLEPRICE is '昨结算价';
	comment on column H_EXCLIPOSDETAIL.CONTRACTID is '品种合约';
	comment on column H_EXCLIPOSDETAIL.TRADEMARGIN is '交易保证金';
	comment on column H_EXCLIPOSDETAIL.POSITIONPROFIT is '持仓盈亏';
	comment on column H_EXCLIPOSDETAIL.UPLOADDATE is '上报日期';
	comment on column H_EXCLIPOSDETAIL.VHFLAG is '投机套保标志';
	comment on column H_EXCLIPOSDETAIL.CURRENCY is '币种';
	comment on column H_EXCLIPOSDETAIL.EXCOMPANYID is '会员号';
	comment on column H_EXCLIPOSDETAIL.BSTAG is '买卖标志';
	comment on column H_EXCLIPOSDETAIL.TODAYSETTLEPRICE is '今结算价';
	comment on column H_EXCLIPOSDETAIL.EXCHANGEID is '交易所代码';
	comment on column H_EXCLIPOSDETAIL.EXCLIENTID is '客户编码';
	comment on column H_EXCLIPOSDETAIL.POSITION is '持仓量';
	comment on column H_EXCLIPOSDETAIL.TRADEDATE is '交易日期';


--******************************
--创建套期保值额度数据
--******************************
drop table H_EXHEDGEVOLUME;

create table H_EXHEDGEVOLUME
(
	CONTRACTCODE varchar2(30) not null
	,EFFECTIVEDATE char(10) not null
	,SHORTHEDGAMOUNT number(18) not null
	,UPLOADDATE char(10) not null
	,EXCOMPANYCODE varchar2(10) not null
	,SHORTLIMIT number(18) not null
	,CLOSINGDATE char(10) 
	,HEDGINGTYPE char(10) not null
	,APPROVALDATE char(10) not null
	,LONGHEDGAMOUNT number(18) not null
	,EXCHANGEID varchar2(2) not null
	,LONGLIMIT number(18) not null
	,TRADEDATE char(10) not null
	,EXCLIENTCODE varchar2(10) not null
);

comment on table H_EXHEDGEVOLUME is '套期保值额度数据';
	comment on column H_EXHEDGEVOLUME.CONTRACTCODE is '合约代码';
	comment on column H_EXHEDGEVOLUME.EFFECTIVEDATE is '生效日期';
	comment on column H_EXHEDGEVOLUME.SHORTHEDGAMOUNT is '空头保值额度最初申请量';
	comment on column H_EXHEDGEVOLUME.UPLOADDATE is '上报日期';
	comment on column H_EXHEDGEVOLUME.EXCOMPANYCODE is '会员代码';
	comment on column H_EXHEDGEVOLUME.SHORTLIMIT is '空头限额';
	comment on column H_EXHEDGEVOLUME.CLOSINGDATE is '截止日期';
	comment on column H_EXHEDGEVOLUME.HEDGINGTYPE is '套保额度使用类型';
	comment on column H_EXHEDGEVOLUME.APPROVALDATE is '审批日期';
	comment on column H_EXHEDGEVOLUME.LONGHEDGAMOUNT is '多头保值额度最初申请量';
	comment on column H_EXHEDGEVOLUME.EXCHANGEID is '交易所代码';
	comment on column H_EXHEDGEVOLUME.LONGLIMIT is '多头限额';
	comment on column H_EXHEDGEVOLUME.TRADEDATE is '交易日期';
	comment on column H_EXHEDGEVOLUME.EXCLIENTCODE is '客户代码';


--******************************
--创建客户合约限仓数据
--******************************
drop table H_EXCLIENTPOSILIMIT;

create table H_EXCLIENTPOSILIMIT
(
	ROUNDMODE char(10) not null
	,SHORTLIMIT number(19,3) not null
	,CONTRACTCODE varchar2(30) not null
	,CLIENTTYPE char(1) not null
	,SHORTLIMITRATE number(10,4) not null
	,LIMITPOINT number(19,3) not null
	,LONGLIMIT number(19,3) not null
	,EXCHANGEID varchar2(2) not null
	,UPLOADDATE char(10) not null
	,LONGLIMITRATE number(10,4) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXCLIENTPOSILIMIT is '客户合约限仓数据';
	comment on column H_EXCLIENTPOSILIMIT.ROUNDMODE is '取整方式';
	comment on column H_EXCLIENTPOSILIMIT.SHORTLIMIT is '空头绝对限仓量';
	comment on column H_EXCLIENTPOSILIMIT.CONTRACTCODE is '合约代码';
	comment on column H_EXCLIENTPOSILIMIT.CLIENTTYPE is '客户类型';
	comment on column H_EXCLIENTPOSILIMIT.SHORTLIMITRATE is '空头限仓比例';
	comment on column H_EXCLIENTPOSILIMIT.LIMITPOINT is '限仓起点';
	comment on column H_EXCLIENTPOSILIMIT.LONGLIMIT is '多头绝对限仓量';
	comment on column H_EXCLIENTPOSILIMIT.EXCHANGEID is '交易所代码';
	comment on column H_EXCLIENTPOSILIMIT.UPLOADDATE is '上报日期';
	comment on column H_EXCLIENTPOSILIMIT.LONGLIMITRATE is '多头限仓比例';
	comment on column H_EXCLIENTPOSILIMIT.TRADEDATE is '交易日期';


--******************************
--创建会员出入金文件
--******************************
drop table H_EXEXIOFUND;

create table H_EXEXIOFUND
(
	FUNDAMOUNT number(15,3) not null
	,CURRENCY char(3) not null
	,EXCOMPANYID char(4) not null
	,TRANSDATE char(10) not null
	,BANKACCOUNTNO varchar2(8) not null
	,BANKID char(2) not null
	,ACCOUNTTYPE char(1) not null
	,EXCHANGEID varchar2(2) not null
	,UPLOADDATE char(10) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXEXIOFUND is '会员出入金文件';
	comment on column H_EXEXIOFUND.FUNDAMOUNT is '资金变动额';
	comment on column H_EXEXIOFUND.CURRENCY is '币种';
	comment on column H_EXEXIOFUND.EXCOMPANYID is '会员号';
	comment on column H_EXEXIOFUND.TRANSDATE is '出入金发生日期';
	comment on column H_EXEXIOFUND.BANKACCOUNTNO is '资金账户号码';
	comment on column H_EXEXIOFUND.BANKID is '银行统一标识';
	comment on column H_EXEXIOFUND.ACCOUNTTYPE is '资金账户类型';
	comment on column H_EXEXIOFUND.EXCHANGEID is '交易所代码';
	comment on column H_EXEXIOFUND.UPLOADDATE is '上报日期';
	comment on column H_EXEXIOFUND.TRADEDATE is '交易日';


--******************************
--创建会员资料文件
--******************************
drop table H_EXMEMBER;

create table H_EXMEMBER
(
	NAME varchar2(40) not null
	,EXCOMPANYID char(4) not null
	,TRADETYPE char(1) not null
	,SHORTNAME varchar2(10) not null
	,EXCHANGEID varchar2(2) not null
	,UPLOADDATE char(10) not null
	,SETTLEMENTTYPE char(1) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXMEMBER is '会员资料文件';
	comment on column H_EXMEMBER.NAME is '会员名称';
	comment on column H_EXMEMBER.EXCOMPANYID is '客户编码';
	comment on column H_EXMEMBER.TRADETYPE is '会员交易类型';
	comment on column H_EXMEMBER.SHORTNAME is '会员简称';
	comment on column H_EXMEMBER.EXCHANGEID is '交易所代码';
	comment on column H_EXMEMBER.UPLOADDATE is '上报日期';
	comment on column H_EXMEMBER.SETTLEMENTTYPE is '会员结算类型';
	comment on column H_EXMEMBER.TRADEDATE is '交易日';


--******************************
--创建客户分项资金文件
--******************************
drop table H_EXCOMPOTHERFUND;

create table H_EXCOMPOTHERFUND
(
	CURRENCY char(3) not null
	,EXCOMPANYID char(4) not null
	,EXCHANGEID varchar2(2) not null
	,EXCLIENTID varchar2(8) 
	,AMOUNT number(15,3) not null
	,ACCOUNT varchar2(8) not null
	,UPLOADDATE char(10) not null
	,TRADEDATE char(10) not null
	,FUNDTYPE char(4) not null
);

comment on table H_EXCOMPOTHERFUND is '客户分项资金文件';
	comment on column H_EXCOMPOTHERFUND.CURRENCY is '币种';
	comment on column H_EXCOMPOTHERFUND.EXCOMPANYID is '会员号';
	comment on column H_EXCOMPOTHERFUND.EXCHANGEID is '交易所代码';
	comment on column H_EXCOMPOTHERFUND.EXCLIENTID is '客户编码';
	comment on column H_EXCOMPOTHERFUND.AMOUNT is '资金金额';
	comment on column H_EXCOMPOTHERFUND.ACCOUNT is '资金账户号码';
	comment on column H_EXCOMPOTHERFUND.UPLOADDATE is '上报日期';
	comment on column H_EXCOMPOTHERFUND.TRADEDATE is '交易日';
	comment on column H_EXCOMPOTHERFUND.FUNDTYPE is '资金项目编号';


--******************************
--创建合约属性数据
--******************************
drop table H_EXINSTRUMENTPROPERTY;

create table H_EXINSTRUMENTPROPERTY
(
	CONTRACTCODE varchar2(30) not null
	,FEEREDCUTRATE number(15,8) not null
	,MINCHANGEPRICE number(9,3) not null
	,PEROFUP number(12,3) not null
	,DELIVERYMANNER char(10) not null
	,FEEMETHOD char(10) not null
	,BEGINDATE char(10) not null
	,CONTRACTNAME varchar2(30) not null
	,FEEREDCUT char(10) not null
	,DOWNPRICE number(12,3) not null
	,EXCHANGEID varchar2(2) not null
	,UPAMP number(12,3) not null
	,PRODUCTTYPE char(10) not null
	,REFERENCEPRICE number(12,3) not null
	,TRADEDATE char(10) not null
	,ENDDATE char(10) not null
	,LIMITTYPE char(10) not null
	,TRADEDATEFLAG char(10) not null
	,PRODUCTCODE varchar2(8) not null
	,FEEPRICE number(15,8) not null
	,PEROFDOWN number(12,3) not null
	,UPLOADDATE char(10) not null
	,FEEERDCUTPRICE number(15,8) not null
	,DELIVFEERATE number(15,8) not null
	,UPPRICE number(12,3) not null
	,TRADEUNIT number(18) not null
	,DELIVERYUNIT number(18) not null
	,FEERATE number(15,8) not null
	,DELIVERFEE char(10) not null
	,DOWNAMP number(12,3) not null
	,DELIVFEEPRICE number(15,8) not null
	,AHEADMONTH number(18) not null
);

comment on table H_EXINSTRUMENTPROPERTY is '合约属性数据';
	comment on column H_EXINSTRUMENTPROPERTY.CONTRACTCODE is '合约代码';
	comment on column H_EXINSTRUMENTPROPERTY.FEEREDCUTRATE is '手续费减免率';
	comment on column H_EXINSTRUMENTPROPERTY.MINCHANGEPRICE is '最小变动价';
	comment on column H_EXINSTRUMENTPROPERTY.PEROFUP is '涨停百分比';
	comment on column H_EXINSTRUMENTPROPERTY.DELIVERYMANNER is '交割方式';
	comment on column H_EXINSTRUMENTPROPERTY.FEEMETHOD is '交易手续费取值方式';
	comment on column H_EXINSTRUMENTPROPERTY.BEGINDATE is '开始交割日';
	comment on column H_EXINSTRUMENTPROPERTY.CONTRACTNAME is '合约名称';
	comment on column H_EXINSTRUMENTPROPERTY.FEEREDCUT is '手续费减免取值方式';
	comment on column H_EXINSTRUMENTPROPERTY.DOWNPRICE is '跌停价';
	comment on column H_EXINSTRUMENTPROPERTY.EXCHANGEID is '交易所代码';
	comment on column H_EXINSTRUMENTPROPERTY.UPAMP is '涨停幅度';
	comment on column H_EXINSTRUMENTPROPERTY.PRODUCTTYPE is '产品类型';
	comment on column H_EXINSTRUMENTPROPERTY.REFERENCEPRICE is '挂牌基准价';
	comment on column H_EXINSTRUMENTPROPERTY.TRADEDATE is '交易日期';
	comment on column H_EXINSTRUMENTPROPERTY.ENDDATE is '最后交割日';
	comment on column H_EXINSTRUMENTPROPERTY.LIMITTYPE is '涨跌停板取值方式';
	comment on column H_EXINSTRUMENTPROPERTY.TRADEDATEFLAG is '是否首交易日';
	comment on column H_EXINSTRUMENTPROPERTY.PRODUCTCODE is '产品代码';
	comment on column H_EXINSTRUMENTPROPERTY.FEEPRICE is '交易手续费单价';
	comment on column H_EXINSTRUMENTPROPERTY.PEROFDOWN is '跌停百分比';
	comment on column H_EXINSTRUMENTPROPERTY.UPLOADDATE is '上报日期';
	comment on column H_EXINSTRUMENTPROPERTY.FEEERDCUTPRICE is '手续费减免单价';
	comment on column H_EXINSTRUMENTPROPERTY.DELIVFEERATE is '交割手续费率';
	comment on column H_EXINSTRUMENTPROPERTY.UPPRICE is '涨停价';
	comment on column H_EXINSTRUMENTPROPERTY.TRADEUNIT is '合约数量乘数';
	comment on column H_EXINSTRUMENTPROPERTY.DELIVERYUNIT is '交割单位';
	comment on column H_EXINSTRUMENTPROPERTY.FEERATE is '交易手续费率';
	comment on column H_EXINSTRUMENTPROPERTY.DELIVERFEE is '交割手续费取值方式';
	comment on column H_EXINSTRUMENTPROPERTY.DOWNAMP is '跌停幅度';
	comment on column H_EXINSTRUMENTPROPERTY.DELIVFEEPRICE is '交割手续费';
	comment on column H_EXINSTRUMENTPROPERTY.AHEADMONTH is '提前月份';


--******************************
--创建交割明细文件
--******************************
drop table H_EXDELIVDATA;

create table H_EXDELIVDATA
(
	DELIVTYPE char(1) not null
	,DELIV_PRICE number(15,3) not null
	,CURRENCY char(3) not null
	,BSTAG char(1) not null
	,EXCOMPANYID char(4) not null
	,DELIV_AMOUNT number(15,3) not null
	,EXCHANGEID varchar2(2) not null
	,CONTRACTID varchar2(6) not null
	,EXCLIENTID varchar2(8) not null
	,POSITION number(10) not null
	,UPLOADDATE char(10) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXDELIVDATA is '交割明细文件';
	comment on column H_EXDELIVDATA.DELIVTYPE is '交割类型';
	comment on column H_EXDELIVDATA.DELIV_PRICE is '交割结算价';
	comment on column H_EXDELIVDATA.CURRENCY is '币种';
	comment on column H_EXDELIVDATA.BSTAG is '买卖标志';
	comment on column H_EXDELIVDATA.EXCOMPANYID is '会员号';
	comment on column H_EXDELIVDATA.DELIV_AMOUNT is '交割货款';
	comment on column H_EXDELIVDATA.EXCHANGEID is '交易所代码';
	comment on column H_EXDELIVDATA.CONTRACTID is '品种合约';
	comment on column H_EXDELIVDATA.EXCLIENTID is '客户编码';
	comment on column H_EXDELIVDATA.POSITION is '交割量';
	comment on column H_EXDELIVDATA.UPLOADDATE is '上报日期';
	comment on column H_EXDELIVDATA.TRADEDATE is '交易日';


--******************************
--创建特别客户合约限仓数据
--******************************
drop table H_EXSPECIALPOSILIMIT;

create table H_EXSPECIALPOSILIMIT
(
	ROUNDMODE char(10) not null
	,SHORTLIMIT number(19,3) not null
	,CONTRACTCODE varchar2(30) not null
	,SHORTLIMITRATE number(10,4) not null
	,LIMITPOINT number(19,3) not null
	,LONGLIMIT number(19,3) not null
	,EXCHANGEID varchar2(2) not null
	,UPLOADDATE char(10) not null
	,LONGLIMITRATE number(10,4) not null
	,TRADEDATE char(10) not null
	,EXCLIENTCODE varchar2(10) not null
);

comment on table H_EXSPECIALPOSILIMIT is '特别客户合约限仓数据';
	comment on column H_EXSPECIALPOSILIMIT.ROUNDMODE is '取整方式';
	comment on column H_EXSPECIALPOSILIMIT.SHORTLIMIT is '空头绝对限仓量';
	comment on column H_EXSPECIALPOSILIMIT.CONTRACTCODE is '合约代码';
	comment on column H_EXSPECIALPOSILIMIT.SHORTLIMITRATE is '空头限仓比例';
	comment on column H_EXSPECIALPOSILIMIT.LIMITPOINT is '限仓起点';
	comment on column H_EXSPECIALPOSILIMIT.LONGLIMIT is '多头绝对限仓量';
	comment on column H_EXSPECIALPOSILIMIT.EXCHANGEID is '交易所代码';
	comment on column H_EXSPECIALPOSILIMIT.UPLOADDATE is '上报日期';
	comment on column H_EXSPECIALPOSILIMIT.LONGLIMITRATE is '多头限仓比例';
	comment on column H_EXSPECIALPOSILIMIT.TRADEDATE is '交易日期';
	comment on column H_EXSPECIALPOSILIMIT.EXCLIENTCODE is '客户代码';


--******************************
--创建会员合约限仓数据
--******************************
drop table H_EXPARTPOSILIMIT;

create table H_EXPARTPOSILIMIT
(
	CONTRACTCODE varchar2(30) not null
	,TRADEROLE char(10) not null
	,LIMITPOINT number(19,3) not null
	,UPLOADDATE char(10) not null
	,CREDITRATIO number(10,4) not null
	,LONGLIMITRATE number(10,4) not null
	,BUSINESSRATIO number(10,4) not null
	,EXCOMPANYCODE varchar2(10) not null
	,SHORTLIMIT number(19,3) not null
	,ROUNDMODE char(10) not null
	,SHORTLIMITRATE number(10,4) not null
	,EXCHANGEID varchar2(2) not null
	,LONGLIMIT number(19,3) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXPARTPOSILIMIT is '会员合约限仓数据';
	comment on column H_EXPARTPOSILIMIT.CONTRACTCODE is '合约代码';
	comment on column H_EXPARTPOSILIMIT.TRADEROLE is '交易角色';
	comment on column H_EXPARTPOSILIMIT.LIMITPOINT is '限仓起点';
	comment on column H_EXPARTPOSILIMIT.UPLOADDATE is '上报日期';
	comment on column H_EXPARTPOSILIMIT.CREDITRATIO is '信用系数';
	comment on column H_EXPARTPOSILIMIT.LONGLIMITRATE is '多头限仓比例';
	comment on column H_EXPARTPOSILIMIT.BUSINESSRATIO is '业务系数';
	comment on column H_EXPARTPOSILIMIT.EXCOMPANYCODE is '会员代码';
	comment on column H_EXPARTPOSILIMIT.SHORTLIMIT is '空头绝对限仓量';
	comment on column H_EXPARTPOSILIMIT.ROUNDMODE is '取整方式';
	comment on column H_EXPARTPOSILIMIT.SHORTLIMITRATE is '空头限仓比例';
	comment on column H_EXPARTPOSILIMIT.EXCHANGEID is '交易所代码';
	comment on column H_EXPARTPOSILIMIT.LONGLIMIT is '多头绝对限仓量';
	comment on column H_EXPARTPOSILIMIT.TRADEDATE is '交易日期';


--******************************
--创建现货价格文件
--******************************
drop table H_EXSPOTPRICE;

create table H_EXSPOTPRICE
(
	MEMO varchar2(200) 
	,PRICE number(15,3) 
	,CURRENCY char(10) 
	,SOURCENAME varchar2(100) 
	,COMMODITYID varchar2(2) not null
	,EXCHANGEID varchar2(2) not null
	,MARKETPLACE varchar2(40) 
	,COMMODITYNAME varchar2(40) 
	,SOURCEID varchar2(10) not null
	,UPLOADDATE char(10) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXSPOTPRICE is '现货价格文件';
	comment on column H_EXSPOTPRICE.MEMO is '备注';
	comment on column H_EXSPOTPRICE.PRICE is '价格';
	comment on column H_EXSPOTPRICE.CURRENCY is '币种';
	comment on column H_EXSPOTPRICE.SOURCENAME is '现货价格来源';
	comment on column H_EXSPOTPRICE.COMMODITYID is '品种';
	comment on column H_EXSPOTPRICE.EXCHANGEID is '交易所代码';
	comment on column H_EXSPOTPRICE.MARKETPLACE is '产地/市场';
	comment on column H_EXSPOTPRICE.COMMODITYNAME is '现货名称';
	comment on column H_EXSPOTPRICE.SOURCEID is '现货价格编号';
	comment on column H_EXSPOTPRICE.UPLOADDATE is '上报日期';
	comment on column H_EXSPOTPRICE.TRADEDATE is '交易日';


--******************************
--创建仓库文件
--******************************
drop table H_EXWAREHOUSE;

create table H_EXWAREHOUSE
(
	INVENTORY number(16,3) 
	,WAREHOUSEID varchar2(10) not null
	,CAPACITY number(16,3) 
	,COMMODITYID varchar2(2) not null
	,EXCHANGEID varchar2(2) not null
	,UPLOADDATE char(10) not null
	,WAREHOUSENAME varchar2(50) not null
	,TRADEDATE char(10) not null
);

comment on table H_EXWAREHOUSE is '仓库文件';
	comment on column H_EXWAREHOUSE.INVENTORY is '库存量';
	comment on column H_EXWAREHOUSE.WAREHOUSEID is '仓库编号';
	comment on column H_EXWAREHOUSE.CAPACITY is '库容量';
	comment on column H_EXWAREHOUSE.COMMODITYID is '品种';
	comment on column H_EXWAREHOUSE.EXCHANGEID is '交易所代码';
	comment on column H_EXWAREHOUSE.UPLOADDATE is '上报日期';
	comment on column H_EXWAREHOUSE.WAREHOUSENAME is '仓库名称';
	comment on column H_EXWAREHOUSE.TRADEDATE is '交易日';


--******************************
--创建会员合约交易保证金率数据
--******************************
drop table H_EXMARGINRATE;

create table H_EXMARGINRATE
(
	EXCOMPANYCODE varchar2(10) not null
	,CONTRACTCODE varchar2(30) not null
	,VHFLAG char(1) not null
	,TRADEROLE char(10) not null
	,EXCHANGEID varchar2(2) not null
	,SHORTRATE number(10,4) not null
	,UPLOADDATE char(10) not null
	,TRADEDATE char(10) not null
	,LONGRATE number(10,4) not null
);

comment on table H_EXMARGINRATE is '会员合约交易保证金率数据';
	comment on column H_EXMARGINRATE.EXCOMPANYCODE is '会员代码';
	comment on column H_EXMARGINRATE.CONTRACTCODE is '合约代码';
	comment on column H_EXMARGINRATE.VHFLAG is '投机套保标志 ';
	comment on column H_EXMARGINRATE.TRADEROLE is '交易角色';
	comment on column H_EXMARGINRATE.EXCHANGEID is '交易所代码';
	comment on column H_EXMARGINRATE.SHORTRATE is '空头保证金率';
	comment on column H_EXMARGINRATE.UPLOADDATE is '上报日期';
	comment on column H_EXMARGINRATE.TRADEDATE is '交易日期';
	comment on column H_EXMARGINRATE.LONGRATE is '多头保证金率';


--******************************
--创建客户盈亏数据
--******************************
drop table H_EXCUSPROFIT;

create table H_EXCUSPROFIT
(
	FUNDACCNUMBER varchar2(8) not null
	,PROFIT number(15,3) not null
	,VHFLAG char(1) not null
	,CURRENCY char(3) not null
	,BSTAG char(1) not null
	,EXCOMPANYID char(4) not null
	,EXCHANGEID varchar2(2) not null
	,CONTRACTID varchar2(6) not null
	,EXCLIENTID varchar2(8) 
	,UPLOADDATE char(10) not null
	,TRADEDATE char(10) not null
	,PROFITTYPE char(1) not null
);

comment on table H_EXCUSPROFIT is '客户盈亏数据';
	comment on column H_EXCUSPROFIT.FUNDACCNUMBER is '资金账户号码';
	comment on column H_EXCUSPROFIT.PROFIT is '盈亏金额';
	comment on column H_EXCUSPROFIT.VHFLAG is '投机套保标志';
	comment on column H_EXCUSPROFIT.CURRENCY is '币种';
	comment on column H_EXCUSPROFIT.BSTAG is '买卖标志';
	comment on column H_EXCUSPROFIT.EXCOMPANYID is '会员号';
	comment on column H_EXCUSPROFIT.EXCHANGEID is '交易所代码';
	comment on column H_EXCUSPROFIT.CONTRACTID is '品种合约';
	comment on column H_EXCUSPROFIT.EXCLIENTID is '客户编码';
	comment on column H_EXCUSPROFIT.UPLOADDATE is '上报日期';
	comment on column H_EXCUSPROFIT.TRADEDATE is '日期';
	comment on column H_EXCUSPROFIT.PROFITTYPE is '盈亏类型';


--******************************
--创建会员资金文件
--******************************
drop table H_EXCOMPFUND;

create table H_EXCOMPFUND
(
	PROFIT number(15,3) not null
	,MORTGAGECHANGE number(15,3) not null
	,MARGIN number(15,3) not null
	,MONEYIN number(15,3) not null
	,SETTLEMENTFUND number(15,3) not null
	,CASH number(15,3) not null
	,UPLOADDATE char(10) not null
	,TRADEMARGIN number(15,3) not null
	,DELIVMARGIN number(15,3) not null
	,FUNDACCNUMBER varchar2(8) not null
	,CURRENCY char(3) not null
	,MORTGAGE number(15,3) not null
	,EXCOMPANYID char(4) not null
	,EXCHANGEID varchar2(2) not null
	,ACCOUNTTYPE char(1) not null
	,LASTMARGIN number(15,3) not null
	,TRADEDATE char(10) not null
	,OTHERS number(15,3) not null
	,DELIVAMOUNT number(15,3) not null
	,FEE number(15,3) not null
	,MONEYOUT number(15,3) not null
);

comment on table H_EXCOMPFUND is '会员资金文件';
	comment on column H_EXCOMPFUND.PROFIT is '当日总盈亏';
	comment on column H_EXCOMPFUND.MORTGAGECHANGE is '质押变动额';
	comment on column H_EXCOMPFUND.MARGIN is '会员权益总额';
	comment on column H_EXCOMPFUND.MONEYIN is '入金';
	comment on column H_EXCOMPFUND.SETTLEMENTFUND is '结算准备金';
	comment on column H_EXCOMPFUND.CASH is '实有货币资金';
	comment on column H_EXCOMPFUND.UPLOADDATE is '上报日期';
	comment on column H_EXCOMPFUND.TRADEMARGIN is '交易保证金';
	comment on column H_EXCOMPFUND.DELIVMARGIN is '交割保证金';
	comment on column H_EXCOMPFUND.FUNDACCNUMBER is '资金账户号码';
	comment on column H_EXCOMPFUND.CURRENCY is '币种';
	comment on column H_EXCOMPFUND.MORTGAGE is '质押额';
	comment on column H_EXCOMPFUND.EXCOMPANYID is '会员号';
	comment on column H_EXCOMPFUND.EXCHANGEID is '交易所代码';
	comment on column H_EXCOMPFUND.ACCOUNTTYPE is '资金账户类型';
	comment on column H_EXCOMPFUND.LASTMARGIN is '上日保证金总额';
	comment on column H_EXCOMPFUND.TRADEDATE is '交易日期';
	comment on column H_EXCOMPFUND.OTHERS is '其它资金';
	comment on column H_EXCOMPFUND.DELIVAMOUNT is '交割货款';
	comment on column H_EXCOMPFUND.FEE is '各类手续费';
	comment on column H_EXCOMPFUND.MONEYOUT is '出金';


--******************************
--创建品种合约文件
--******************************
drop table H_EXCONTRACT;

create table H_EXCONTRACT
(
	CLOSINGPRICE number(15,3) not null
	,LASTSETTLEPRICE number(15,3) not null
	,HIGHESTPRICE number(15,3) not null
	,MARGIN number(15,3) 
	,COMMODITYID varchar2(2) not null
	,CONTRACTID varchar2(6) not null
	,AMOUNT number(16,3) not null
	,UPLOADDATE char(10) not null
	,SETTLEPRICE number(15,3) not null
	,CURRENCY char(3) not null
	,STARTDATE char(10) not null
	,OPENINGPRICE number(15,3) not null
	,LOWESTPRICE number(15,3) not null
	,FEERATE number(10,8) 
	,MARGINRATE number(6,4) 
	,VOLUMN number(10) not null
	,EXCHANGEID varchar2(2) not null
	,POSITION number(10) not null
	,TRADEDATE char(10) not null
	,ENDDATE char(10) not null
	,FEE number(15,3) 
);

comment on table H_EXCONTRACT is '品种合约文件';
	comment on column H_EXCONTRACT.CLOSINGPRICE is '收盘价';
	comment on column H_EXCONTRACT.LASTSETTLEPRICE is '昨结算价';
	comment on column H_EXCONTRACT.HIGHESTPRICE is '最高价';
	comment on column H_EXCONTRACT.MARGIN is '保证金额';
	comment on column H_EXCONTRACT.COMMODITYID is '品种';
	comment on column H_EXCONTRACT.CONTRACTID is '品种合约';
	comment on column H_EXCONTRACT.AMOUNT is '成交额';
	comment on column H_EXCONTRACT.UPLOADDATE is '上报日期';
	comment on column H_EXCONTRACT.SETTLEPRICE is '今结算价';
	comment on column H_EXCONTRACT.CURRENCY is '币种';
	comment on column H_EXCONTRACT.STARTDATE is '开始交易日';
	comment on column H_EXCONTRACT.OPENINGPRICE is '开盘价';
	comment on column H_EXCONTRACT.LOWESTPRICE is '最低价';
	comment on column H_EXCONTRACT.FEERATE is '手续费率';
	comment on column H_EXCONTRACT.MARGINRATE is '保证金率';
	comment on column H_EXCONTRACT.VOLUMN is '成交量';
	comment on column H_EXCONTRACT.EXCHANGEID is '交易所代码';
	comment on column H_EXCONTRACT.POSITION is '持仓量';
	comment on column H_EXCONTRACT.TRADEDATE is '交易日';
	comment on column H_EXCONTRACT.ENDDATE is '最后交易日';
	comment on column H_EXCONTRACT.FEE is '手续费额';


spool off
quit;

