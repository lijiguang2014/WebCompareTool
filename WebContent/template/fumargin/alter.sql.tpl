!!travel Tables!!
	!!let tableName=@name!!
	!!if !strcmp(@isDrop, "true")!!
drop table !!@tableName!!;
	!!elseif !strcmp(@isCreate, "true")!!
create table !!@tableName!! (
		!!travel Columns!!
		!!@columnName!! !!@columnType!! !!if !strcmp(@notnull, "true")!! not null !!endif!! !!if !strcmp(@iskey, "true")!! primary key!!endif!!,
		!!next!!
);
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
		!!endif!!
		!!if !strcmp(@type, "index")!!
alter table !!@tableName!! drop index !!@indexName!!;
		!!endif!!
		!!next!!
		!!travel Adds!!
alter table !!@tableName!! add column !!@columnName!! !!@typeName!! !!if !strcmp(@notnull, "true")!! not null !!endif!! !!if !strcmp(@iskey, "true")!! primary key!!endif!!;
		!!next!!
		!!travel Alters!!
			!!if !strcmp(@type, "cloumnType")!!
alter table !!@tableName!! modify(!!@columnName!! !!@ChangedTypeName!!);
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
			!!endif!!
		!!next!!
	!!endif!!
	
!!next!!