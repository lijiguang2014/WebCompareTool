call "C:\Program Files (x86)\Microsoft Visual Studio\VC98\Bin\VCVARS32.BAT"
set path=%path%;D:\program\pump\bin
mergeUFXML DB %1 %2 %3 %4
rem mergeUFXML DB  .\test.xml .\framework.xml  .\fumarginEntity.xml  .\fumarginType.xml 