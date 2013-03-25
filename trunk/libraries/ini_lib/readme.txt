Sunshine BMax- Inilibrary
Rewritten from BB- Source
BB- Source from: http://www.blitzforum.de/
	
Copyright © 15peaces 2009 - 2011
Website: http://15peaces.com

This is a simple BlitzMax- Library for managing ini- files.

Features:
    Create and Jump to ini- groups
    Create ini- comments
    Create and Read ini- Fields 

V. 1.02

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