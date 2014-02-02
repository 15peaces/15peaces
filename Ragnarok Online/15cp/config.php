<?
	/*
		Configuration file for 15CP 0.08
	
		Legend:
			(*1) = Please use  = 'value'; format here!
			(*2) = True / False variable!
			(*3) = Interger variable. Only numbers are allowed!
	*/
	
	//General Stuff
	$config['title'] = '15peaces Control Panel'; //This is the title of your control panel! (*1)
	
	//SQL related
	$conf['sql_rag_ip'] 	= '127.0.0.1'; //Your RO-Servers SQL IP (*1)
	$conf['sql_rag_user'] 	= 'root'; //Your RO-Servers SQL Username (*1)
	$conf['sql_rag_pass'] 	= 'password'; //Your RO-Servers SQL Password (*1)
	$conf['rag_db']			= 'ragnarok'; //Your RO-Servers Maindatabase (*1)
	
	//Mainserver configs
	
	//NOTE: It is recommoned to use a DNS. If you use 127.0.0.1 or localhost, it'll maybe make the cp really slow...
	$conf['serverip_log'] = '127.0.0.1'; //Your RO- Loginserver IP (*1)
	$conf['serverip_char'] = '127.0.0.1'; //Your RO- Characterserver IP (*1)
	$conf['serverip_map'] = '127.0.0.1'; //Your RO- Mapserver IP (*1)
	
	$conf['port_log'] = 6900; //Your RO- Loginserver Port (*3)
	$conf['port_char'] = 5121; //Your RO- Characterserver Port (*3)
	$conf['port_map'] = 6121; //Your RO- Mapserver Port (*3)
	
	// ------------------------------------------------------------------------------------------
	// Plugins:
	
	//Link configuration:
	$config['plugin.homelink'] = ''; //Link to Servers Homepage or empty to disable
	$config['plugin.downloadlink'] = ''; //Link to Servers Downloadpage or empty to disable
	$config['plugin.forumlink'] = ''; //Link to Servers Downloadpage or empty to disable
	
	// Facebook Plugin configuration:
	$config['plugin.facebook.activate'] = true; //Activate Facebook-Plugin (*2)
	$config['plugin.facebook.url'] 		= 'YOUR PAGE URL'; //(*1)
?>