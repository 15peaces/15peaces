Rem
	Testprogram for ftp engine
EndRem

SuperStrict

Import "ftp.bmx"

Local myftp:Tftp = New Tftp

myftp.Init(0)

myftp.connect("nyanro.org")

End