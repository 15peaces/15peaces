<?
	include "config.php";
	include "functions.php";

	$cur_site = "home";
	
	if(isset($_GET['site'])){
		if(SiteExist($_GET['site'].'.php')){
			$cur_site = $_GET['site'];
		}
	}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de" lang="de">
	<head>
		<title><?php echo $config['title'];?></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>

		<link rel="shortcut icon" href="images/favicon.ico"/>
		<link href="styles/default/style.css" rel="stylesheet" type="text/css"/>

		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
	</head>
	<body>
		<?
			if($config['plugin.facebook.activate'] == true){
				include "plugins/facebook-de/body_top.htm";
			}
		?>
		<div id="head">
			<div id="account">
			<?php
					if($_GET['popup'] <> "login"){
						if(LoggedIn($_COOKIE['ID'],$_COOKIE['pass']) == false){
							echo '&nbsp;&nbsp;&nbsp;Welcome Guest! (<a href=?popup=login&site='.$cur_site.'>Login</a> or <a href=?site=register>Register</a>)&nbsp;&nbsp;&nbsp;Serverstatus: '.GetStatus().' &nbsp;&nbsp;&nbsp;Players online: '.OnlineCount().'&nbsp;&nbsp;&nbsp;';
						}else{
							echo '&nbsp;&nbsp;&nbsp;Welcome '.$_COOKIE['ID'].'! (<a href="?action=logout">logout</a>)&nbsp;&nbsp;&nbsp;Serverstatus: '.GetStatus().' &nbsp;&nbsp;&nbsp;Players online: '.OnlineCount().'&nbsp;&nbsp;&nbsp;';
						}
					}else{
							echo '&nbsp;&nbsp;&nbsp;Welcome Guest! (<a href=?popup=loginh&site='.$cur_site.'>Login</a> or <a href=?site=register>Register</a>)&nbsp;&nbsp;&nbsp;Serverstatus: '.GetStatus().' &nbsp;&nbsp;&nbsp;Players online: '.OnlineCount().'&nbsp;&nbsp;&nbsp;';
							echo '<br>&nbsp;&nbsp;&nbsp;<form method="post" action="?action=login&site='.$cur_site.'"><label>User:</label> <input name="name" type="text" id="name" size="10"> <label>Pass:</label> <input name="pass" type="password" id="pass" size="10"> <label>Stay:</label> <input name="stay" type="checkbox" value="yes"> <input name="ok" type="submit" id="ok" value="Login"></form>';
					}
			?>
			</div>
		</div>
	</body>
</html>