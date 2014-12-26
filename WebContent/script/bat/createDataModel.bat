call "C:\Program Files (x86)\Microsoft Visual Studio\VC98\Bin\VCVARS32.BAT"
set path=%path%;D:\program\pump\bin
set include=%include%;D:\program\pump\include
set lib=%lib%;D:\program\pump\lib
mergeUFXML DB %1 %2 %3 %4
rem mergeUFXML DB  .\test.xml .\framework.xml  .\Entity.xml  .\type.xml 
pump %5 %6 %1
rem pump test.sql CreateTable.sql.tpl test.xml