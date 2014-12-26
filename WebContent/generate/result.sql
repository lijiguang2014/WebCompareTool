spool CreateTable.log
--******************************
--�����ֵ��ļ�
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

comment on table H_EXWARRANT is '�ֵ��ļ�';
	comment on column H_EXWARRANT.WAREHOUSEID is '�ֿ���';
	comment on column H_EXWARRANT.EXCOMPANYID is '��Ա��';
	comment on column H_EXWARRANT.COMMODITYID is 'Ʒ��';
	comment on column H_EXWARRANT.EXCHANGEID is '����������';
	comment on column H_EXWARRANT.EXCLIENTID is '�ͻ�����';
	comment on column H_EXWARRANT.UPLOADDATE is '�ϱ�����';
	comment on column H_EXWARRANT.WARRANTAMOUNT is '�ֵ�����';
	comment on column H_EXWARRANT.TRADEDATE is '������';


--******************************
--�����ͻ����������ļ�
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

comment on table H_EXCLIENT is '�ͻ����������ļ�';
	comment on column H_EXCLIENT.CLIENTSTATE is '�˻�����״̬';
	comment on column H_EXCLIENT.EXCLIENTIDTYPE is '���ױ�������';
	comment on column H_EXCLIENT.NAME is '�ͻ�����';
	comment on column H_EXCLIENT.REALOPENDATE is '�ͻ���������';
	comment on column H_EXCLIENT.IDENTITY is '���֤';
	comment on column H_EXCLIENT.ADDRESS is 'ͨѶ��ַ';
	comment on column H_EXCLIENT.POSTCODE is '��������';
	comment on column H_EXCLIENT.LOCATE is '���ڵ�';
	comment on column H_EXCLIENT.OPENDATE is '��������';
	comment on column H_EXCLIENT.DEPUTYIDENTITY is '������Ȩ�����֤';
	comment on column H_EXCLIENT.TELEPHONE is '��ϵ�绰';
	comment on column H_EXCLIENT.UPLOADDATE is '�ϱ�����';
	comment on column H_EXCLIENT.CLIENTTYPE is '�ͻ�����';
	comment on column H_EXCLIENT.EXCOMPANYID is '������Ա��';
	comment on column H_EXCLIENT.DEPUTYNAME is '������Ȩ������';
	comment on column H_EXCLIENT.BUSINESSCODE is '��֯��������֤��';
	comment on column H_EXCLIENT.EXCHANGEID is '����������';
	comment on column H_EXCLIENT.EXCLIENTID is '�ͻ�����';
	comment on column H_EXCLIENT.ORGANCODE is 'Ӫҵִ�պ�';


--******************************
--��������������Լ�ļ�
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

comment on table H_EXDELIVCONTRACTDATA is '����������Լ�ļ�';
	comment on column H_EXDELIVCONTRACTDATA.DELIVTYPE is '��������';
	comment on column H_EXDELIVCONTRACTDATA.OPENPRICE is '���ּ�';
	comment on column H_EXDELIVCONTRACTDATA.DELIVSETTLEPRICE is '��������';
	comment on column H_EXDELIVCONTRACTDATA.CONTRACTID is 'Ʒ�ֺ�Լ';
	comment on column H_EXDELIVCONTRACTDATA.DELIVMARGIN is '���֤��';
	comment on column H_EXDELIVCONTRACTDATA.UPLOADDATE is '�ϱ�����';
	comment on column H_EXDELIVCONTRACTDATA.TRADESEQ is '�ɽ���ˮ��';
	comment on column H_EXDELIVCONTRACTDATA.CURRENCY is '����';
	comment on column H_EXDELIVCONTRACTDATA.EXCOMPANYID is '��Ա��';
	comment on column H_EXDELIVCONTRACTDATA.BSTAG is '������־';
	comment on column H_EXDELIVCONTRACTDATA.EXCHANGEID is '����������';
	comment on column H_EXDELIVCONTRACTDATA.EXCLIENTID is '�ͻ�����';
	comment on column H_EXDELIVCONTRACTDATA.POSITION is '������ֲ���';
	comment on column H_EXDELIVCONTRACTDATA.TRADEDATE is '������';


--******************************
--����ί����Ӧ����
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

comment on table H_EXORDER is 'ί����Ӧ����';
	comment on column H_EXORDER.CONTRACTCODE is '��Լ����';
	comment on column H_EXORDER.TRADEUSERCODE is '�����û�����';
	comment on column H_EXORDER.TRIGGERCONDITION is '��������';
	comment on column H_EXORDER.DECLAREDPRICE is '�걨�۸�';
	comment on column H_EXORDER.ORDERSOURCE is '������Դ';
	comment on column H_EXORDER.VOLUMNED is '�ѳɽ�����';
	comment on column H_EXORDER.REPORTNUM is '�������';
	comment on column H_EXORDER.DECLAREDAMOUNT is '�걨����';
	comment on column H_EXORDER.EXCOMPANYCODE is '��Ա����';
	comment on column H_EXORDER.LASTMODIFYTIME is '����޸�ʱ��';
	comment on column H_EXORDER.VHFLAG is 'Ͷ���ױ���־';
	comment on column H_EXORDER.BSTAG is '��������';
	comment on column H_EXORDER.VOLUMNTYPE is '�ɽ������� ';
	comment on column H_EXORDER.NUMBERCODE is '�����Ա����';
	comment on column H_EXORDER.ORDERTYPE is '��������';
	comment on column H_EXORDER.EXCHANGEID is '����������';
	comment on column H_EXORDER.SQUAREREASON is 'ǿƽԭ��';
	comment on column H_EXORDER.ACTIVATIONTIME is '����ʱ��';
	comment on column H_EXORDER.ORDERDATE is '��������';
	comment on column H_EXORDER.TRADEDATE is '��������';
	comment on column H_EXORDER.MINVOLUMN is '��С�ɽ���';
	comment on column H_EXORDER.EXCLIENTCODE is '�ͻ�����';
	comment on column H_EXORDER.ORDERSTATE is '����״̬';
	comment on column H_EXORDER.LOCALNUM is '���ر������';
	comment on column H_EXORDER.REMAINING is 'ʣ������';
	comment on column H_EXORDER.PVTYPE is '��Ч������';
	comment on column H_EXORDER.MODIFYUSERCODE is '����޸Ľ����û�����';
	comment on column H_EXORDER.TRIGGERPRICE is '�����۸�';
	comment on column H_EXORDER.ORDERTIME is '����ʱ��';
	comment on column H_EXORDER.UPLOADDATE is '�ϱ�����';
	comment on column H_EXORDER.PRICECONDITION is '�����۸�����';
	comment on column H_EXORDER.HANGTIME is '����ʱ��';
	comment on column H_EXORDER.CANCLETIME is '����ʱ��';
	comment on column H_EXORDER.OCTAG is '��ƽ��־';
	comment on column H_EXORDER.BUSINESSDATE is 'ҵ��������';


--******************************
--�����ɽ���ϸ�ļ�
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

comment on table H_EXCLITRDDETAIL is '�ɽ���ϸ�ļ�';
	comment on column H_EXCLITRDDETAIL.PRICE is '�ɽ���';
	comment on column H_EXCLITRDDETAIL.TRANSDATE is '�ɽ�����';
	comment on column H_EXCLITRDDETAIL.CONTRACTID is 'Ʒ�ֺ�Լ';
	comment on column H_EXCLITRDDETAIL.AMOUNT is '�ɽ���';
	comment on column H_EXCLITRDDETAIL.UPLOADDATE is '�ϱ�����';
	comment on column H_EXCLITRDDETAIL.TRADESEQ is '�ɽ���ˮ��';
	comment on column H_EXCLITRDDETAIL.VHFLAG is 'Ͷ���ױ���־';
	comment on column H_EXCLITRDDETAIL.CURRENCY is '����';
	comment on column H_EXCLITRDDETAIL.EXCOMPANYID is '��Ա��';
	comment on column H_EXCLITRDDETAIL.BSTAG is '������־';
	comment on column H_EXCLITRDDETAIL.VOLUMN is '�ɽ���';
	comment on column H_EXCLITRDDETAIL.EXCHANGEID is '����������';
	comment on column H_EXCLITRDDETAIL.TRADETIME is '�ɽ�ʱ��';
	comment on column H_EXCLITRDDETAIL.EXCLIENTID is '�ͻ�����';
	comment on column H_EXCLITRDDETAIL.CLOSEPROFIT is 'ƽ��ӯ��';
	comment on column H_EXCLITRDDETAIL.OCTAG is '��ƽ�ֱ�־';
	comment on column H_EXCLITRDDETAIL.TRADEDATE is '������';


--******************************
--�����ֲ���ϸ�ļ�
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

comment on table H_EXCLIPOSDETAIL is '�ֲ���ϸ�ļ�';
	comment on column H_EXCLIPOSDETAIL.LASTSETTLEPRICE is '������';
	comment on column H_EXCLIPOSDETAIL.CONTRACTID is 'Ʒ�ֺ�Լ';
	comment on column H_EXCLIPOSDETAIL.TRADEMARGIN is '���ױ�֤��';
	comment on column H_EXCLIPOSDETAIL.POSITIONPROFIT is '�ֲ�ӯ��';
	comment on column H_EXCLIPOSDETAIL.UPLOADDATE is '�ϱ�����';
	comment on column H_EXCLIPOSDETAIL.VHFLAG is 'Ͷ���ױ���־';
	comment on column H_EXCLIPOSDETAIL.CURRENCY is '����';
	comment on column H_EXCLIPOSDETAIL.EXCOMPANYID is '��Ա��';
	comment on column H_EXCLIPOSDETAIL.BSTAG is '������־';
	comment on column H_EXCLIPOSDETAIL.TODAYSETTLEPRICE is '������';
	comment on column H_EXCLIPOSDETAIL.EXCHANGEID is '����������';
	comment on column H_EXCLIPOSDETAIL.EXCLIENTID is '�ͻ�����';
	comment on column H_EXCLIPOSDETAIL.POSITION is '�ֲ���';
	comment on column H_EXCLIPOSDETAIL.TRADEDATE is '��������';


--******************************
--�������ڱ�ֵ�������
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

comment on table H_EXHEDGEVOLUME is '���ڱ�ֵ�������';
	comment on column H_EXHEDGEVOLUME.CONTRACTCODE is '��Լ����';
	comment on column H_EXHEDGEVOLUME.EFFECTIVEDATE is '��Ч����';
	comment on column H_EXHEDGEVOLUME.SHORTHEDGAMOUNT is '��ͷ��ֵ������������';
	comment on column H_EXHEDGEVOLUME.UPLOADDATE is '�ϱ�����';
	comment on column H_EXHEDGEVOLUME.EXCOMPANYCODE is '��Ա����';
	comment on column H_EXHEDGEVOLUME.SHORTLIMIT is '��ͷ�޶�';
	comment on column H_EXHEDGEVOLUME.CLOSINGDATE is '��ֹ����';
	comment on column H_EXHEDGEVOLUME.HEDGINGTYPE is '�ױ����ʹ������';
	comment on column H_EXHEDGEVOLUME.APPROVALDATE is '��������';
	comment on column H_EXHEDGEVOLUME.LONGHEDGAMOUNT is '��ͷ��ֵ������������';
	comment on column H_EXHEDGEVOLUME.EXCHANGEID is '����������';
	comment on column H_EXHEDGEVOLUME.LONGLIMIT is '��ͷ�޶�';
	comment on column H_EXHEDGEVOLUME.TRADEDATE is '��������';
	comment on column H_EXHEDGEVOLUME.EXCLIENTCODE is '�ͻ�����';


--******************************
--�����ͻ���Լ�޲�����
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

comment on table H_EXCLIENTPOSILIMIT is '�ͻ���Լ�޲�����';
	comment on column H_EXCLIENTPOSILIMIT.ROUNDMODE is 'ȡ����ʽ';
	comment on column H_EXCLIENTPOSILIMIT.SHORTLIMIT is '��ͷ�����޲���';
	comment on column H_EXCLIENTPOSILIMIT.CONTRACTCODE is '��Լ����';
	comment on column H_EXCLIENTPOSILIMIT.CLIENTTYPE is '�ͻ�����';
	comment on column H_EXCLIENTPOSILIMIT.SHORTLIMITRATE is '��ͷ�޲ֱ���';
	comment on column H_EXCLIENTPOSILIMIT.LIMITPOINT is '�޲����';
	comment on column H_EXCLIENTPOSILIMIT.LONGLIMIT is '��ͷ�����޲���';
	comment on column H_EXCLIENTPOSILIMIT.EXCHANGEID is '����������';
	comment on column H_EXCLIENTPOSILIMIT.UPLOADDATE is '�ϱ�����';
	comment on column H_EXCLIENTPOSILIMIT.LONGLIMITRATE is '��ͷ�޲ֱ���';
	comment on column H_EXCLIENTPOSILIMIT.TRADEDATE is '��������';


--******************************
--������Ա������ļ�
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

comment on table H_EXEXIOFUND is '��Ա������ļ�';
	comment on column H_EXEXIOFUND.FUNDAMOUNT is '�ʽ�䶯��';
	comment on column H_EXEXIOFUND.CURRENCY is '����';
	comment on column H_EXEXIOFUND.EXCOMPANYID is '��Ա��';
	comment on column H_EXEXIOFUND.TRANSDATE is '�����������';
	comment on column H_EXEXIOFUND.BANKACCOUNTNO is '�ʽ��˻�����';
	comment on column H_EXEXIOFUND.BANKID is '����ͳһ��ʶ';
	comment on column H_EXEXIOFUND.ACCOUNTTYPE is '�ʽ��˻�����';
	comment on column H_EXEXIOFUND.EXCHANGEID is '����������';
	comment on column H_EXEXIOFUND.UPLOADDATE is '�ϱ�����';
	comment on column H_EXEXIOFUND.TRADEDATE is '������';


--******************************
--������Ա�����ļ�
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

comment on table H_EXMEMBER is '��Ա�����ļ�';
	comment on column H_EXMEMBER.NAME is '��Ա����';
	comment on column H_EXMEMBER.EXCOMPANYID is '�ͻ�����';
	comment on column H_EXMEMBER.TRADETYPE is '��Ա��������';
	comment on column H_EXMEMBER.SHORTNAME is '��Ա���';
	comment on column H_EXMEMBER.EXCHANGEID is '����������';
	comment on column H_EXMEMBER.UPLOADDATE is '�ϱ�����';
	comment on column H_EXMEMBER.SETTLEMENTTYPE is '��Ա��������';
	comment on column H_EXMEMBER.TRADEDATE is '������';


--******************************
--�����ͻ������ʽ��ļ�
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

comment on table H_EXCOMPOTHERFUND is '�ͻ������ʽ��ļ�';
	comment on column H_EXCOMPOTHERFUND.CURRENCY is '����';
	comment on column H_EXCOMPOTHERFUND.EXCOMPANYID is '��Ա��';
	comment on column H_EXCOMPOTHERFUND.EXCHANGEID is '����������';
	comment on column H_EXCOMPOTHERFUND.EXCLIENTID is '�ͻ�����';
	comment on column H_EXCOMPOTHERFUND.AMOUNT is '�ʽ���';
	comment on column H_EXCOMPOTHERFUND.ACCOUNT is '�ʽ��˻�����';
	comment on column H_EXCOMPOTHERFUND.UPLOADDATE is '�ϱ�����';
	comment on column H_EXCOMPOTHERFUND.TRADEDATE is '������';
	comment on column H_EXCOMPOTHERFUND.FUNDTYPE is '�ʽ���Ŀ���';


--******************************
--������Լ��������
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

comment on table H_EXINSTRUMENTPROPERTY is '��Լ��������';
	comment on column H_EXINSTRUMENTPROPERTY.CONTRACTCODE is '��Լ����';
	comment on column H_EXINSTRUMENTPROPERTY.FEEREDCUTRATE is '�����Ѽ�����';
	comment on column H_EXINSTRUMENTPROPERTY.MINCHANGEPRICE is '��С�䶯��';
	comment on column H_EXINSTRUMENTPROPERTY.PEROFUP is '��ͣ�ٷֱ�';
	comment on column H_EXINSTRUMENTPROPERTY.DELIVERYMANNER is '���ʽ';
	comment on column H_EXINSTRUMENTPROPERTY.FEEMETHOD is '����������ȡֵ��ʽ';
	comment on column H_EXINSTRUMENTPROPERTY.BEGINDATE is '��ʼ������';
	comment on column H_EXINSTRUMENTPROPERTY.CONTRACTNAME is '��Լ����';
	comment on column H_EXINSTRUMENTPROPERTY.FEEREDCUT is '�����Ѽ���ȡֵ��ʽ';
	comment on column H_EXINSTRUMENTPROPERTY.DOWNPRICE is '��ͣ��';
	comment on column H_EXINSTRUMENTPROPERTY.EXCHANGEID is '����������';
	comment on column H_EXINSTRUMENTPROPERTY.UPAMP is '��ͣ����';
	comment on column H_EXINSTRUMENTPROPERTY.PRODUCTTYPE is '��Ʒ����';
	comment on column H_EXINSTRUMENTPROPERTY.REFERENCEPRICE is '���ƻ�׼��';
	comment on column H_EXINSTRUMENTPROPERTY.TRADEDATE is '��������';
	comment on column H_EXINSTRUMENTPROPERTY.ENDDATE is '��󽻸���';
	comment on column H_EXINSTRUMENTPROPERTY.LIMITTYPE is '�ǵ�ͣ��ȡֵ��ʽ';
	comment on column H_EXINSTRUMENTPROPERTY.TRADEDATEFLAG is '�Ƿ��׽�����';
	comment on column H_EXINSTRUMENTPROPERTY.PRODUCTCODE is '��Ʒ����';
	comment on column H_EXINSTRUMENTPROPERTY.FEEPRICE is '���������ѵ���';
	comment on column H_EXINSTRUMENTPROPERTY.PEROFDOWN is '��ͣ�ٷֱ�';
	comment on column H_EXINSTRUMENTPROPERTY.UPLOADDATE is '�ϱ�����';
	comment on column H_EXINSTRUMENTPROPERTY.FEEERDCUTPRICE is '�����Ѽ��ⵥ��';
	comment on column H_EXINSTRUMENTPROPERTY.DELIVFEERATE is '������������';
	comment on column H_EXINSTRUMENTPROPERTY.UPPRICE is '��ͣ��';
	comment on column H_EXINSTRUMENTPROPERTY.TRADEUNIT is '��Լ��������';
	comment on column H_EXINSTRUMENTPROPERTY.DELIVERYUNIT is '���λ';
	comment on column H_EXINSTRUMENTPROPERTY.FEERATE is '������������';
	comment on column H_EXINSTRUMENTPROPERTY.DELIVERFEE is '����������ȡֵ��ʽ';
	comment on column H_EXINSTRUMENTPROPERTY.DOWNAMP is '��ͣ����';
	comment on column H_EXINSTRUMENTPROPERTY.DELIVFEEPRICE is '����������';
	comment on column H_EXINSTRUMENTPROPERTY.AHEADMONTH is '��ǰ�·�';


--******************************
--����������ϸ�ļ�
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

comment on table H_EXDELIVDATA is '������ϸ�ļ�';
	comment on column H_EXDELIVDATA.DELIVTYPE is '��������';
	comment on column H_EXDELIVDATA.DELIV_PRICE is '��������';
	comment on column H_EXDELIVDATA.CURRENCY is '����';
	comment on column H_EXDELIVDATA.BSTAG is '������־';
	comment on column H_EXDELIVDATA.EXCOMPANYID is '��Ա��';
	comment on column H_EXDELIVDATA.DELIV_AMOUNT is '�������';
	comment on column H_EXDELIVDATA.EXCHANGEID is '����������';
	comment on column H_EXDELIVDATA.CONTRACTID is 'Ʒ�ֺ�Լ';
	comment on column H_EXDELIVDATA.EXCLIENTID is '�ͻ�����';
	comment on column H_EXDELIVDATA.POSITION is '������';
	comment on column H_EXDELIVDATA.UPLOADDATE is '�ϱ�����';
	comment on column H_EXDELIVDATA.TRADEDATE is '������';


--******************************
--�����ر�ͻ���Լ�޲�����
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

comment on table H_EXSPECIALPOSILIMIT is '�ر�ͻ���Լ�޲�����';
	comment on column H_EXSPECIALPOSILIMIT.ROUNDMODE is 'ȡ����ʽ';
	comment on column H_EXSPECIALPOSILIMIT.SHORTLIMIT is '��ͷ�����޲���';
	comment on column H_EXSPECIALPOSILIMIT.CONTRACTCODE is '��Լ����';
	comment on column H_EXSPECIALPOSILIMIT.SHORTLIMITRATE is '��ͷ�޲ֱ���';
	comment on column H_EXSPECIALPOSILIMIT.LIMITPOINT is '�޲����';
	comment on column H_EXSPECIALPOSILIMIT.LONGLIMIT is '��ͷ�����޲���';
	comment on column H_EXSPECIALPOSILIMIT.EXCHANGEID is '����������';
	comment on column H_EXSPECIALPOSILIMIT.UPLOADDATE is '�ϱ�����';
	comment on column H_EXSPECIALPOSILIMIT.LONGLIMITRATE is '��ͷ�޲ֱ���';
	comment on column H_EXSPECIALPOSILIMIT.TRADEDATE is '��������';
	comment on column H_EXSPECIALPOSILIMIT.EXCLIENTCODE is '�ͻ�����';


--******************************
--������Ա��Լ�޲�����
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

comment on table H_EXPARTPOSILIMIT is '��Ա��Լ�޲�����';
	comment on column H_EXPARTPOSILIMIT.CONTRACTCODE is '��Լ����';
	comment on column H_EXPARTPOSILIMIT.TRADEROLE is '���׽�ɫ';
	comment on column H_EXPARTPOSILIMIT.LIMITPOINT is '�޲����';
	comment on column H_EXPARTPOSILIMIT.UPLOADDATE is '�ϱ�����';
	comment on column H_EXPARTPOSILIMIT.CREDITRATIO is '����ϵ��';
	comment on column H_EXPARTPOSILIMIT.LONGLIMITRATE is '��ͷ�޲ֱ���';
	comment on column H_EXPARTPOSILIMIT.BUSINESSRATIO is 'ҵ��ϵ��';
	comment on column H_EXPARTPOSILIMIT.EXCOMPANYCODE is '��Ա����';
	comment on column H_EXPARTPOSILIMIT.SHORTLIMIT is '��ͷ�����޲���';
	comment on column H_EXPARTPOSILIMIT.ROUNDMODE is 'ȡ����ʽ';
	comment on column H_EXPARTPOSILIMIT.SHORTLIMITRATE is '��ͷ�޲ֱ���';
	comment on column H_EXPARTPOSILIMIT.EXCHANGEID is '����������';
	comment on column H_EXPARTPOSILIMIT.LONGLIMIT is '��ͷ�����޲���';
	comment on column H_EXPARTPOSILIMIT.TRADEDATE is '��������';


--******************************
--�����ֻ��۸��ļ�
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

comment on table H_EXSPOTPRICE is '�ֻ��۸��ļ�';
	comment on column H_EXSPOTPRICE.MEMO is '��ע';
	comment on column H_EXSPOTPRICE.PRICE is '�۸�';
	comment on column H_EXSPOTPRICE.CURRENCY is '����';
	comment on column H_EXSPOTPRICE.SOURCENAME is '�ֻ��۸���Դ';
	comment on column H_EXSPOTPRICE.COMMODITYID is 'Ʒ��';
	comment on column H_EXSPOTPRICE.EXCHANGEID is '����������';
	comment on column H_EXSPOTPRICE.MARKETPLACE is '����/�г�';
	comment on column H_EXSPOTPRICE.COMMODITYNAME is '�ֻ�����';
	comment on column H_EXSPOTPRICE.SOURCEID is '�ֻ��۸���';
	comment on column H_EXSPOTPRICE.UPLOADDATE is '�ϱ�����';
	comment on column H_EXSPOTPRICE.TRADEDATE is '������';


--******************************
--�����ֿ��ļ�
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

comment on table H_EXWAREHOUSE is '�ֿ��ļ�';
	comment on column H_EXWAREHOUSE.INVENTORY is '�����';
	comment on column H_EXWAREHOUSE.WAREHOUSEID is '�ֿ���';
	comment on column H_EXWAREHOUSE.CAPACITY is '������';
	comment on column H_EXWAREHOUSE.COMMODITYID is 'Ʒ��';
	comment on column H_EXWAREHOUSE.EXCHANGEID is '����������';
	comment on column H_EXWAREHOUSE.UPLOADDATE is '�ϱ�����';
	comment on column H_EXWAREHOUSE.WAREHOUSENAME is '�ֿ�����';
	comment on column H_EXWAREHOUSE.TRADEDATE is '������';


--******************************
--������Ա��Լ���ױ�֤��������
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

comment on table H_EXMARGINRATE is '��Ա��Լ���ױ�֤��������';
	comment on column H_EXMARGINRATE.EXCOMPANYCODE is '��Ա����';
	comment on column H_EXMARGINRATE.CONTRACTCODE is '��Լ����';
	comment on column H_EXMARGINRATE.VHFLAG is 'Ͷ���ױ���־ ';
	comment on column H_EXMARGINRATE.TRADEROLE is '���׽�ɫ';
	comment on column H_EXMARGINRATE.EXCHANGEID is '����������';
	comment on column H_EXMARGINRATE.SHORTRATE is '��ͷ��֤����';
	comment on column H_EXMARGINRATE.UPLOADDATE is '�ϱ�����';
	comment on column H_EXMARGINRATE.TRADEDATE is '��������';
	comment on column H_EXMARGINRATE.LONGRATE is '��ͷ��֤����';


--******************************
--�����ͻ�ӯ������
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

comment on table H_EXCUSPROFIT is '�ͻ�ӯ������';
	comment on column H_EXCUSPROFIT.FUNDACCNUMBER is '�ʽ��˻�����';
	comment on column H_EXCUSPROFIT.PROFIT is 'ӯ�����';
	comment on column H_EXCUSPROFIT.VHFLAG is 'Ͷ���ױ���־';
	comment on column H_EXCUSPROFIT.CURRENCY is '����';
	comment on column H_EXCUSPROFIT.BSTAG is '������־';
	comment on column H_EXCUSPROFIT.EXCOMPANYID is '��Ա��';
	comment on column H_EXCUSPROFIT.EXCHANGEID is '����������';
	comment on column H_EXCUSPROFIT.CONTRACTID is 'Ʒ�ֺ�Լ';
	comment on column H_EXCUSPROFIT.EXCLIENTID is '�ͻ�����';
	comment on column H_EXCUSPROFIT.UPLOADDATE is '�ϱ�����';
	comment on column H_EXCUSPROFIT.TRADEDATE is '����';
	comment on column H_EXCUSPROFIT.PROFITTYPE is 'ӯ������';


--******************************
--������Ա�ʽ��ļ�
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

comment on table H_EXCOMPFUND is '��Ա�ʽ��ļ�';
	comment on column H_EXCOMPFUND.PROFIT is '������ӯ��';
	comment on column H_EXCOMPFUND.MORTGAGECHANGE is '��Ѻ�䶯��';
	comment on column H_EXCOMPFUND.MARGIN is '��ԱȨ���ܶ�';
	comment on column H_EXCOMPFUND.MONEYIN is '���';
	comment on column H_EXCOMPFUND.SETTLEMENTFUND is '����׼����';
	comment on column H_EXCOMPFUND.CASH is 'ʵ�л����ʽ�';
	comment on column H_EXCOMPFUND.UPLOADDATE is '�ϱ�����';
	comment on column H_EXCOMPFUND.TRADEMARGIN is '���ױ�֤��';
	comment on column H_EXCOMPFUND.DELIVMARGIN is '���֤��';
	comment on column H_EXCOMPFUND.FUNDACCNUMBER is '�ʽ��˻�����';
	comment on column H_EXCOMPFUND.CURRENCY is '����';
	comment on column H_EXCOMPFUND.MORTGAGE is '��Ѻ��';
	comment on column H_EXCOMPFUND.EXCOMPANYID is '��Ա��';
	comment on column H_EXCOMPFUND.EXCHANGEID is '����������';
	comment on column H_EXCOMPFUND.ACCOUNTTYPE is '�ʽ��˻�����';
	comment on column H_EXCOMPFUND.LASTMARGIN is '���ձ�֤���ܶ�';
	comment on column H_EXCOMPFUND.TRADEDATE is '��������';
	comment on column H_EXCOMPFUND.OTHERS is '�����ʽ�';
	comment on column H_EXCOMPFUND.DELIVAMOUNT is '�������';
	comment on column H_EXCOMPFUND.FEE is '����������';
	comment on column H_EXCOMPFUND.MONEYOUT is '����';


--******************************
--����Ʒ�ֺ�Լ�ļ�
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

comment on table H_EXCONTRACT is 'Ʒ�ֺ�Լ�ļ�';
	comment on column H_EXCONTRACT.CLOSINGPRICE is '���̼�';
	comment on column H_EXCONTRACT.LASTSETTLEPRICE is '������';
	comment on column H_EXCONTRACT.HIGHESTPRICE is '��߼�';
	comment on column H_EXCONTRACT.MARGIN is '��֤���';
	comment on column H_EXCONTRACT.COMMODITYID is 'Ʒ��';
	comment on column H_EXCONTRACT.CONTRACTID is 'Ʒ�ֺ�Լ';
	comment on column H_EXCONTRACT.AMOUNT is '�ɽ���';
	comment on column H_EXCONTRACT.UPLOADDATE is '�ϱ�����';
	comment on column H_EXCONTRACT.SETTLEPRICE is '������';
	comment on column H_EXCONTRACT.CURRENCY is '����';
	comment on column H_EXCONTRACT.STARTDATE is '��ʼ������';
	comment on column H_EXCONTRACT.OPENINGPRICE is '���̼�';
	comment on column H_EXCONTRACT.LOWESTPRICE is '��ͼ�';
	comment on column H_EXCONTRACT.FEERATE is '��������';
	comment on column H_EXCONTRACT.MARGINRATE is '��֤����';
	comment on column H_EXCONTRACT.VOLUMN is '�ɽ���';
	comment on column H_EXCONTRACT.EXCHANGEID is '����������';
	comment on column H_EXCONTRACT.POSITION is '�ֲ���';
	comment on column H_EXCONTRACT.TRADEDATE is '������';
	comment on column H_EXCONTRACT.ENDDATE is '�������';
	comment on column H_EXCONTRACT.FEE is '�����Ѷ�';


spool off
quit;

