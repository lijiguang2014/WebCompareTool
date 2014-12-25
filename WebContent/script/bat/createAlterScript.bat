call "C:\Program Files (x86)\Microsoft Visual Studio\VC98\Bin\VCVARS32.BAT"
set path=%path%;D:\program\pump\bin
set include=%include%;D:\program\pump\include
set lib=%lib%;D:\program\pump\lib
pump %1 %2 %3
rem pump D:\Working\GeneraterAlter\alter.sql D:\Working\GeneraterAlter\alter.sql.tpl D:\Working\GeneraterAlter\compareResult.xml