package it.unipr.ce.dsg.s2p.sip.sbc;

import org.zoolu.tools.Configure;
import org.zoolu.tools.Parser;
/**
 * Class for the configuration of the Session Border Controller
 * 
 * @author Fabrizio Caramia
 *
 */
public class SessionBorderControllerConfig extends Configure {
	/** 
	 * Max number of Gateway Peer.
	 * Default value: 10 
	 * */
	public int nMaxGatewayPeer=10;
	
	/**
	 * First port that will be assigned to GatewayPeer and so on
	 * Note: first port is assigned to TestNATPeer
	 * Default value: 0 
	 * */
	public int initPort=0;
	
	
	/**
	 * Port for TEST NAT Peer.
	 * Default value: 0 
	 */
	
	public int testNATPort=0;
	
	/** Costructs a new SessionBorderControllerProfile */
	public SessionBorderControllerConfig(String file)
	{  
		init(file);
	}

	/** Inits the SessionBorderControllerProfile */
	private void init(String file)
	{  
		loadFile(file);

	}


	protected void parseLine(String line)
	{ 
		String attribute;
		Parser par;
		int index=line.indexOf("=");
		if (index>0) {  attribute=line.substring(0,index).trim(); par=new Parser(line,index+1);  }
		else {  attribute=line; par=new Parser("");  }

		if (attribute.equals("max_gwPeer")) { nMaxGatewayPeer = par.getInt(); return; }
		if (attribute.equals("init_port")) { initPort = par.getInt(); return; }
		if (attribute.equals("test_nat_port")) { testNATPort = par.getInt(); return; }
		
	}


	
}
