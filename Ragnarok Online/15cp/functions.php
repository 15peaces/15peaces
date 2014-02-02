<?
	function GetStatus()
	{
		global $conf;
		$ret = 0;
		$stat = @fsockopen ($conf['serverip_log'],$conf['port_log'],$errno, $errstr, 1);
		if ($stat = true)
			$ret = 1;
		else 
			return('<span class="stat_offline">offline</span>');	
		$stat = @fsockopen ($conf['serverip_char'],$conf['port_char'], $errno, $errstr, 1);
		if ($stat = true)
			$ret = 1;
		else 
			return('<span class="stat_offline">offline</span>');	
		$stat = @fsockopen ($conf['serverip_map'],$conf['port_map'], $errno, $errstr, 1);
		if ($stat = true)
			$ret = 1;
		else 
			return('<span class="stat_offline">offline</span>');
		if ($ret = 1)
			return('<span class="stat_online">online</span>');
		else
			return('<span class="stat_offline">offline</span>');
	}
	
	function LoggedIn($ID,$pass)
	{
		global $conf;
		$con = @mysql_pconnect($conf['sql_rag_ip'],$conf['sql_rag_user'],$conf['sql_rag_pass']);
		if(!$con){
			return false;
			mysql_close($con);
		}
		mysql_select_db($conf['rag_db'], $con);
		$out = mysql_query("SELECT userid,user_pass FROM login",$con);
		if(!$out){
			return false;
			mysql_close($con);
		}
		while($row = mysql_fetch_array($out))
		{
			if ($row['userid'] == $ID and md5($row['user_pass']) == $pass){
				return true;
				mysql_close($con);
			}
		}
		return false;
	}

	function OnlineCount()
	{
		global $conf;
		$con = @mysql_pconnect($conf['sql_rag_ip'],$conf['sql_rag_user'],$conf['sql_rag_pass']);
			if(!$con){
				return;
				mysql_close($con);
			}
			mysql_select_db($conf['rag_db'], $con);
			$out = mysql_query("SELECT COUNT(1) FROM `char` WHERE online = '1'",$con);
			if(!$out){
				return;
				mysql_close($con);			
			}
			$result = mysql_fetch_row($out);
			return $result[0];
		mysql_close($con);
	}

	function SiteExist($site){
		if(file_exists($site)){
			return(true);
		}else{
			return(false);
		}
	}

	function deleteCookie($cookie)
	{
		setcookie($cookie,"",time()+60*60*24*30);
		return;
	}

	function login($ID,$pass,$stay,$page)
	{
		global $conf;
		$con = @mysql_pconnect($conf['sql_rag_ip'],$conf['sql_rag_user'],$conf['sql_rag_pass']);
		if(!$con){
				echo('<p style=color:red>mySQL-Error: ' . mysql_error().'</p><a href=index.php style="color:blue">back</a>');
				return;
				mysql_close($con);
			}
		mysql_select_db($mainconf['sql_db'], $con);
		$out = mysql_query("SELECT userid,user_pass FROM login",$con);
		if(!$out){
				echo('<p style=color:red>mySQL-Error: ' . mysql_error().'</p><a href=index.php style="color:blue">back</a>');
				return;
				mysql_close($con);
				
			}
		while($row = mysql_fetch_array($out))
		{
			if ($row['userid'] == $ID){
				if(md5($row['user_pass']) == $pass){
					if(isset($stay)){
						setcookie("ID",$ID,time()+60*60*24*30);
						setcookie("pass",$pass,time()+60*60*24*30);
					}else{
						setcookie("ID",$ID,0);
						setcookie("pass",$pass,0);
					}
					echo ('<meta http-equiv="refresh" content="0; URL=?site='.$page.'">');
					return;
					mysql_close($con);
				}
				return('<p style=color:red>USERNAME/PASSWORD WRONG!</p><a href=index.php style="color:blue">back</a>');
				return;
				mysql_close($con);
			}
		}
		return('<p style=color:red>USERNAME/PASSWORD WRONG!</p><a href=index.php style="color:blue">back</a>');
		return;
		mysql_close($con);
	}
	
	function logoff()
	{
		deleteCookie("ID");
		deleteCookie("pass");
		echo '<meta http-equiv="refresh" content="0; URL=?site=home">';
		return;
	}
?>