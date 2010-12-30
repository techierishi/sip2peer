package it.unipr.ce.dsg.s2p.util;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

import org.zoolu.sip.address.SipURL;

import it.unipr.ce.dsg.s2p.sip.Address;


/**
 * Class <code>ResolutionHost</code> verifies if a node is reached.
 * 
 * @author Fabrizio Caramia
 *
 */

public class ResolutionHost {
	
	private String addressHost;
	
	/**
	 * Create a new ResolutionHost
	 * 
	 * @param address the address must be verified
	 */
	
	public ResolutionHost(Address address){
		
		this.addressHost = address.getHost();
	}
	
	/**
	 * Create a new ResolutionHost
	 * 
	 * @param address the address must be verified
	 */
	public ResolutionHost(SipURL address){
		
		this.addressHost = address.getHost();
	}
	
	/**
	 *  Create a new ResolutionHost
	 * 
	 * @param address the address must be verified
	 */
	public ResolutionHost(String address){
		
		this.addressHost = address;
	}
	
	/**
	 * Check if the address is reached
	 * 
	 * @param timeout max interval time in milliseconds to verify the reachability
	 * @return return true if the node is reached
	 */
	synchronized public boolean isReachable(int timeout){
		
		boolean reachability=false;
		
		try {
			InetAddress address = InetAddress.getByName(addressHost);
			
			reachability =address.isReachable(timeout);
			
			
		} catch (UnknownHostException e) {
			reachability=false;
		} catch (IOException e) {
			reachability=false;
		}
		
		return reachability;
		
		
	}
	


}
