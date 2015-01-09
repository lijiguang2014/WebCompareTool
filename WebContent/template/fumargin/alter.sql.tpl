!!function!!
#include <vector>
using namespace std;

!!endfunction!!

!!travel Tables!!
	!!let tableName=@name!!
	!!if !strcmp(@isDrop, "true")!!
drop table !!@tableName!!;
	!!elseif !strcmp(@isCreate, "true")!!
create table !!@tableName!! (
	!!let keyList=" "!!
	!!travel Columns!!
		!!if @pumpid!=0!!,!!endif!!!!@columnName!! !!@columnType!! !!if !strcmp(@notnull, "true")!! not null !!endif!! 
		!!if !strcmp(@iskey,"yes")!!
			!!if !strcmp(@keyList," ")!!
				!!let keyList=@columnName!!
			!!else!!
				!!let keyList=multiaddstring(3,@keyList,",",@columnName)!!
			!!endif!!
		!!endif!! 
	!!next!!
	!!if strcmp(@keyList," ")!!
		,constraint pk_!!@name!! primary key (!!@keyList!!)
	!!endif!!
);

!!travel Index!!
create !!if !strcmp(@unique,"yes")!!unique!!endif!! index i_!!@name!! on !!@tableName!!
(
!!travel self!!
	!!if @pumpid!=0!!,!!endif!!!!@name!! !!@order!!
!!next!!
);
!!next!!

comment on table !!@tableName!! is '!!@description!!';
		!!travel Columns!!
comment on column !!@tableName!!.!!@columnName!! is '!!@label!!';
		!!next!!
	!!else!!
	!!if strcmp(@changedDescription, "")!!
comment on table !!@tableName!! is '!!@changedDescription!!';
	!!endif!!
		!!travel Drops!!
		!!if !strcmp(@type, "column")!!
alter table !!@tableName!! drop column !!@columnName!!;
		!!elseif !strcmp(@type, "index")!!
drop index !!@indexName!!;
		!!endif!!
		!!next!!
		!!travel Adds!!
alter table !!@tableName!! add column !!@columnName!! !!@typeName!! !!if !strcmp(@notnull, "true")!! not null !!endif!! !!if !strcmp(@iskey, "true")!! primary key!!endif!!;
		!!next!!
		!!travel Alters!!
			!!if !strcmp(@type, "columnType")!!
alter table !!@tableName!! modify(!!@columnName!! !!@changedTypeName!!);
			!!elseif !strcmp(@type, "columnName")!!
alter table !!@tableName!! rename column !!@columnName!! to !!@changedName!!;
			!!elseif !strcmp(@type, "columnComment")!!
comment on column !!@tableName!!.!!@columnName!! is '!!@changedComment!!';
			!!elseif !strcmp(@type, "columnIskey")!!
				!!if !strcmp(@changedIskey, "yes")!!
alter table !!@tableName!! add constraint primary key(!!@columnName!!);
				!!endif!!
			!!elseif !strcmp(@type, "columnNotnull")!!
				!!if !strcmp(@changedNotnull, "yes")!!
alter table !!@tableName!! modify (!!@columnName!! not null);
				!!else!!
alter table !!@tableName!! modify !!@columnName!! null;				
				!!endif!!
			!!elseif !strcmp(@type, "columnIsindex")!!
				!!if !strcmp(@changedIsindex, "yes")!!
create index on !!@tableName!!(!!@columnName!!);
				!!endif!!
			!!else!!
				!!error!!
			!!endif!!
		!!next!!
	!!endif!!
	
!!next!!