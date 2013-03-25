'Demofile for Sunshine BMax- Inilibrary

SuperStrict

Include "inilib.bmx"

Print "Creating Ini..."
Local inifile:TStream = WriteFile("config.ini")

Print "Writing ini:"
Print "Comment: TESTINI"
WriteIniComment(inifile,"Sunshine TESTINI")

Print "Create inigroup: testgroup1"
WriteIniGroup(inifile,"testgroup1")

Print "Add entrys to Group1: test1=1;test2=2"
WriteIniField(inifile,"test1","1")
WriteIniField(inifile,"test2","2")

Print "Create inigroup: testgroup2"
WriteIniGroup(inifile,"testgroup2")

Print "Add entrys to Group2: test3=3;test4=4"
WriteIniField(inifile,"test3","3")
WriteIniField(inifile,"test4","4")

CloseFile(inifile)
Delay 100
Print "ini Written"

Print "Reading ini..."

Local ini:TStream=ReadFile("config.ini")

Print "Jump to 1st Group"
IniGroup(ini,"testgroup1")
Print "Jumped"

Print "Now Reading..."
Local t1:String = ReadIniField(ini,"test1","")
Local t2:String = ReadIniField(ini,"test2","")
Print "test1:"+t1+" test2:"+t2

Print "Jump to 2nd Group"
IniGroup(ini,"testgroup2")
Print "Jumped"

Print "Now Reading..."
Local t3:String = ReadIniField(ini,"test3","")
Local t4:String = ReadIniField(ini,"test4","")
Print "test3:"+t3+" test4:"+t4

Print "Deleting Testini..."
CloseFile(ini)
DeleteFile("config.ini")

Input("[PRESS ANY KEY TO EXIT]")

