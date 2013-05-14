Rem 
	Usage / Documentation:
	**********************
	Method connect(ip,port = 21,local_port = -1)
		-Connects to Server
		-Sample: myftp.connect("ftpserver.com")
endrem

Import "my_socketstream.bmx"

Type Tftp		
	Field _silent:Int = 1
	Field _connection_socketstream:TSocketStream
	Field _connection_socket:TSocket
	Field _connection_stream:TStream
	
	Field _tstring:String
	
	Method Init(silent:Int = 1) 'Init Tftp type (Recommened)
		_silent = silent
		
		If _connection 'cleaning old Connection Stream
			If Not _silent Then Print "Closing old Stream " + _connection_socketstream.tostring() + " ..."
			CloseStream(_connection_socketstream)
		EndIf
		
		If _connection_Socket 'cleaning old Connection Socket
			If Not _silent Then Print "Closing old Connection Socket " + _connection_socket.tostring() + " ..."
			CloseSocket(_connection_socket)
		EndIf
		
		_connection_socket = CreateTCPSocket()
	EndMethod
	
	Method connect(ip:String , port:Int = 21 , local_port:Int = - 1)
		If ip = ""
			If Not _silent Then Print "Could not connect... Unknown Serverip!"
			Return(False)
		EndIf

		If ConnectSocket( _connection_socket,HostIp(ip), port)
			_connection_socketstream = CreateSocketStream(_connection_socket, True)
			_connection_stream		= OpenStream(_connection_socketstream)
			
			If Not _silent Then Print "connected."
			
			_tstring = _receiveLineFromServer()
			If Not _silent Then Print _tstring
			
			Return(_getAnswer("220"))	
		Else
			If Not _silent Then Print "could not connect to " +  ip
			Return(False)
		EndIf
	EndMethod
	
	Method Listen() 'MARK: use own readline / multithreading (ein thread liest dauernd vom server un speichert in ne list / Listen() arbeitet liste ab)
		Local waitTime:Int = 1000
		Local startTime:Int = MilliSecs()
		
		Local con:TStream = ReadStream(_connection)
		
		Local t:String
		Repeat
			t = ReadLine(con)
				Select t[..3]
					Case "220"
						If Not _silent Then Print t
				EndSelect
		Until (t[..3] <> "220") Or (startTime + waitTime <= MilliSecs()) 'FIX: TIMER!
	EndMethod


	Method _receiveLineFromServer:String()
		' time in milliseconds until timeout
		Local threshold:Int = 3000
		Local start:Int = MilliSecs()
		Local now:Int = 0
	
		Local data:String
		
		If _connection_Stream And SocketConnected(_connection_Socket)
			While Not SocketReadAvail(_connection_Socket) And ( (now - start) < threshold )
				now = MilliSecs()
			Wend
			
			If (now - start) < threshold
				If SocketReadAvail(_connection_Socket)>0
			      	data = ReadLine(_connection_Stream)
				EndIf
				
		        	If(data<>"")
					Return(data)
		        	EndIf
			EndIf 
		EndIf
	EndMethod
	
	Method _getAnswer:Int(s:String)
		If s = "220" And _tstring[0..Len(s)] = "220"
			While _tstring[0..Len(s)] = "220"
				_tstring = _receiveLineFromServer()
				If Not _silent Then Print _tstring
			Wend
		EndIf
	
		If _tstring[0..Len(s)] <> s 
			If Not _silent Then Print _tstring
			Return(false)
		Else
			If Not _silent Then Print _tstring
			Return(true)
		EndIf
	Endmethod
EndType
