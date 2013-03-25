Rem 
	Usage / Documentation:
	**********************
	Method connect(ip,port = 21,local_port = -1)
		-Connects to Server
		-Sample: myftp.connect("ftpserver.com")
		TEST FOR SVN!
endrem

Type Tftp
	Field _silent:Int
	Field _connection:TSocketStream
	
	Method Init(silent:Int = 1)
		_silent = silent
	EndMethod
	
	Method connect(ip:String,port:Int = 21,local_port:Int = -1)
	
		Local socket:TSocket = CreateTCPSocket() 
		If local_port <> (- 1) Then
			If Not BindSocket(socket, local_port) Then Return Null
		EndIf
		
		If Not ConnectSocket(socket, HostIp(ip), port) Then Return Null
		_connection = CreateSocketStream(socket)
		
		Listen()
	
	EndMethod
	
	Method Listen()
		Local mtimer:TTimer = CreateTimer(MilliSecs())
		
		Local con:TStream = ReadStream(_connection)
		
		Repeat
			Local t:String = ReadLine(con)
				Select t[..3]
					Case 220
						If Not _silent Then Print t
				EndSelect
		Until Eof(con) Or TimerTicks(mtimer) > 1000 'FIX: TIMER!
	EndMethod

EndType