call "C:\Program Files\Microsoft Visual Studio\VC98\Bin\VCVARS32.BAT"
set path=%path%;D:\Program\pump\bin
set include=%include%;D:\Program\pump\include
set lib=%lib%;D:\Program\pump\lib
mergeUFXML DB %1 %2 %3 %4
rem mergeUFXML DB  .\test.xml .\framework.xml  .\Entity.xml  .\type.xml 
pump %5 %6 %1
rem pump test.sql CreateTable.sql.tpl test.xml