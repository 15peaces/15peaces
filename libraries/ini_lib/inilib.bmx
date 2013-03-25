Rem
	Sunshine BMax- Inilibrary
	Rewritten from BB- Source
	BB- Source from: http://www.blitzforum.de/
	
	Copyright © 15peaces 2009 - 2011
	Website: http://15peaces.com

	V. 1.02a

	Changes:
	========
		1.00:
		-----
			-added Functions: 
				-IniGroup:Int(IniHandle:TStream,Group:String)
				-ReadIniField:String(IniHandle:TStream,Key:String,DefVal:String="")
				-WriteIniComment(IniHandle:TStream,Comment:String)
				-WriteIniGroup(IniHandle:TStream,Group:String)
				-WriteIniField(IniHandle:TStream,Key:String,Value:String)
			-added Sample- Project
		1.01:
		----
			-added ssini.dll (DLL- File with ini- functions for usage in your projects)
		1.02:
		----
			-rewrite of inilib.bmx and ssini.dll- source in Superstrict- Mode to optimize source
			-Library is working with framework BRL.Stream now
EndRem

'SuperStrict

'Framework BRL.Stream

'Jump to ini-group
Function IniGroup:Int(IniHandle:TStream,Group:String)
	SeekStream(IniHandle,0)
	If Group="" Then Return True
	While Not Eof(IniHandle)
		If ReadLine(IniHandle).tolower()="["+Group.tolower()+"]" Then Return True
        Wend
	Return False
EndFunction

'Read Configuration (in Current Group only!)
Function ReadIniField:String(IniHandle:TStream,Key:String,DefVal:String="")
	Local char:Byte
	While Chr:String(char)<>"]" And StreamPos(IniHandle)>0
                SeekStream (IniHandle,StreamPos(IniHandle)-1)
                char=ReadByte(IniHandle)
                If Chr:String(char)<>"]" Then SeekStream (IniHandle,StreamPos(IniHandle)-1)
	Wend
	
	ReadLine(IniHandle)
	
	While Not Eof(IniHandle)
		Local lin:String
		lin=ReadLine(IniHandle)
		If mLeft(lin,1)="[" Then Return DefVal
		If mLeft(lin,1)<>"#" And mLeft(lin,1)<>""
			If mLeft(lin,mInstr(lin,"=",1)-1).tolower()=Key.tolower()
				Return mRight(lin,Len(lin)-mInstr(lin,"=",1))
			EndIf
		EndIf
	Wend
	Return DefVal
EndFunction

'Writes a Comment to Inifile
Function WriteIniComment(IniHandle:TStream,Comment:String)
        WriteLine IniHandle,"#"+Comment
End Function

'Creates new ini-group
Function WriteIniGroup(IniHandle:TStream,Group:String)
        WriteLine IniHandle, ""
        WriteLine IniHandle,"["+Group+"]"
End Function

'Add entry to Current ini-group
Function WriteIniField(IniHandle:TStream,Key:String,Value:String)
        WriteLine IniHandle,Key+"="+Value
End Function

Function mLeft:String( str:String,n:Int )
	If n>Len(str) n=Len(str)
	Return str[..n]
End Function

Function mRight:String( str:String,n:Int )
	If n>Len(str) n=Len(str)
	Return str[Len(str)-n..]
End Function

Function mInstr:Int( str:String,sub:String,start:Int=1 )
	Return str.Find( sub,start-1 )+1
End Function