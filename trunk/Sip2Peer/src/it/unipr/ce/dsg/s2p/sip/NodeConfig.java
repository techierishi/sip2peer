package it.unipr.ce.dsg.s2p.sip;


import org.zoolu.tools.Configure;
import org.zoolu.tools.Parser;

/**
 * Class <code>NodeConfig</code> is useful for node/peer configuration.
 * 
 * @author Fabrizio Caramia
 */

public class NodeConfig extends Configure {

	/* ********************** node/peer configuration ********************* */

	/** 
	 * peer name.
	 * Default value: null
	 */
	public String peer_name=null;

	/**
	 * Address of the Session Border Controller peer,
	 * Default value: null
	 */
	public String sbc=null;


	/** 
	 * Keep alive time
	 * Default value: 7000 ms 
	 * */
	public long keepalive_time=7000;

	/** 
	 * Format of the message, use text if the format is a simple string.
	 * Default value: json  */
	public String content_msg="json";


	/**
	 * Path folder for peer list
	 * Default value: null
	 * */
	public String list_path=null;

	/**
	 * Path folder for peer log
	 * Default value: null
	 */
	public String log_path=null;

	/**
	 * Test if a neighbor peer is reached by "address" value of the PeerDescriptor
	 * This test is processed when a new PeerDescriptor is added in the peer list
	 * Default value: yes
	 */

	public String test_address_reachability="yes";


	public NodeConfig(){
		
		init();
	}
	
	public NodeConfig(String file){

		// load configuration
		loadFile(file);
		// post-load manipulation     
		init();
	}
	

	private void init()
	{  
		if (peer_name!=null && peer_name.equalsIgnoreCase(Configure.NONE)) peer_name=null;

	}


	/** Parses a single line (loaded from the config file) */
	protected void parseLine(String line)
	{  

		String attribute;
		Parser par;
		int index=line.indexOf("=");
		if (index>0) {  attribute=line.substring(0,index).trim(); par=new Parser(line,index+1);  }
		else {  attribute=line; par=new Parser("");  }

		if (attribute.equals("peer_name"))      	 {  peer_name=par.getString();  return;  }

		if (attribute.equals("keepalive_time")) {  keepalive_time=par.getInt();  return;  } 
		if (attribute.equals("content_msg")) 	  {  content_msg=par.getString();  return;  } 

		if (attribute.equals("sbc")) 	  		{  sbc=par.getString();  return;  } 

		if (attribute.equals("list_path")) 	  {  list_path=par.getString();  return;  } 

		if (attribute.equals("log_path")) 	  {  log_path=par.getString();  return;  } 

		if (attribute.equals("test_address_reachability")) 	  { test_address_reachability =par.getString();  return;  } 
	}

}
