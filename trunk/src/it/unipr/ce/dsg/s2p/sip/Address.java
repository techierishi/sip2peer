package it.unipr.ce.dsg.s2p.sip;

import org.zoolu.sip.address.SipURL;

/**
 * Class <code>Address</code> is used to represent a 
 * valid address for peer in the form:
 * <br> 
 * <code>peername@pcdomain:port</code>
 * <p>
 * It forms a SIP address.
 * 
 * @author Fabrizio Caramia
 *
 */

public class Address extends SipURL{
	
	/**
	 * Create a new address from a SIP URL
	 * 
	 * @param sipURL
	 */

	public Address(SipURL sipURL) {
		super(sipURL);
		
	}
	
	/**
	 * Create a new address from a URL string
	 * 
	 * @param url URL string
	 */

	public Address(String url) {
		super(url);

	}
	
	/**
	 * Create a new address from an host name and a port number
	 * 
	 * @param hostname the host name 
	 * @param portnumber the port number
	 */
	
	public Address(String hostname, int portnumber) {
		super(hostname, portnumber);
		
	}

	/**
	 * Create a new address from an peer name, an host name and a port number
	 * 
	 * @param peername the peer name
	 * @param hostname the host name 
	 * @param portnumber the port number
	 */
	public Address(String peername, String hostname, int portnumber) {
		super(peername, hostname, portnumber);
		
	}


	/**
	 * Create a new address from an user name and the host name
	 * 
	 * @param peername the peer name
	 * @param hostname the host name 
	 */
	public Address(String peername, String hostname) {
		super(peername, hostname);
		
	}
	
	
	/**
	 * Get URL String in the format <code>peername@pcdomain:port</code>
	 * 
	 * @return URL String
	 */
	public String getURL() {
		return toString().substring(4);
	}
	
	

}
