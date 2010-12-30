package it.unipr.ce.dsg.s2p.sip.sbc;


import org.zoolu.sip.address.SipURL;


/**
 * Class <code>TestNATListener</code> listen for message response from local peer
 * 
 * @author Fabrizio Caramia
 *
 */
public interface TestNATListener {
	/**
	 * When the TestNATPeer sends a SIP MESSAGE to local peer and receives a response
	 * 
	 * @param type the type of the test
	 * @param localAddress local peer address
	 * @param remoteAddress remote peer address with IP assigned by NAT
	 */
	public void onSuccessTest(String type, SipURL localAddress, SipURL remoteAddress);
	
	/** 
	 * When the TestNATPeer send a SIP MESSAGE to local peer and don't receives a response
	 *
	 * @param type the type of the test
	 * @param localAddress local peer address
	 * @param remoteAddress remote peer address with IP assigned by NAT
	 */
	  
	public void onFailureTest(String type, SipURL localAddress, SipURL remoteAddress);
}
