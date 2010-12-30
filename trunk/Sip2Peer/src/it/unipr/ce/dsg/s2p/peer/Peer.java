package it.unipr.ce.dsg.s2p.peer;


import java.util.Iterator;


import org.zoolu.tools.Log;

import it.unipr.ce.dsg.s2p.message.BasicMessage;
import it.unipr.ce.dsg.s2p.message.parser.BasicParser;
import it.unipr.ce.dsg.s2p.message.parser.JSONParser;
import it.unipr.ce.dsg.s2p.org.json.JSONObject;
import it.unipr.ce.dsg.s2p.sip.Address;
import it.unipr.ce.dsg.s2p.sip.Node;
import it.unipr.ce.dsg.s2p.util.ResolutionHost;

/**
 * The <code>Peer</code> is an abstract class that extends <code>Node</code> class.
 * <p>
 * Class Peer permits to send and receive message, add and remove peer descriptor into the list, 
 * print log.
 * 
 * @author Fabrizio Caramia
 *
 */

public abstract class Peer extends Node {

	protected PeerDescriptor peerDescriptor;

	protected PeerListManager peerList;

	protected BasicParser parserMsg;
	
	/**
	 * Create a new Peer
	 * 
	 * @param pathConfig configuration file for peer
	 * @param key identifies the peer
	 */
	
	public Peer(String pathConfig, String key) {

		super(pathConfig);

		init(key, null);

	}
	
	/**
	 * Create a new Peer
	 * 
	 * @param pathConfig configuration file for peer
	 * @param key identifies the peer
	 * @param peerName name of the peer
	 * @param peerPort port (UDP for default) of the peer
	 */
	public Peer(String pathConfig, String key, String peerName, int peerPort){
		
		super(pathConfig, peerName, peerPort);
		init(key, null);
	}

	/**
	 * Create a new Peer
	 * 
	 * @param pathConfig configuration file for peer
	 * @param key identifies the peer
	 * @param peerName name of the peer
	 * @param peerPort port (UDP for default) of the peer
	 * @param parser to marshal peer message
	 */
	public Peer(String pathConfig, String key, String peerName, int peerPort, BasicParser parser) {

		super(pathConfig, peerName, peerPort);

		init(key, parser);

	}


	/**
	 * Create a new Peer
	 * 
	 * @param pathConfig configuration file for peer
	 * @param key identifies the peer
	 * @param parser to marshal peer message
	 */
	public Peer(String pathConfig, String key, BasicParser parser) {

		super(pathConfig);

		init(key, parser);

	}

	/**
	 * Initialize peer
	 * 
	 * @param key identifies the peer
	 * @param parser parser object for message peer
	 */
	private void init(String key, BasicParser parser){

		this.peerDescriptor = new PeerDescriptor(nodeConfig.peer_name, getAddress().getURL(), key);

		this.peerList = new PeerListManager();

		// Default parser is JSONParser
		if(parser!=null)
			this.parserMsg = parser;
		else
			this.parserMsg = new JSONParser(nodeConfig.content_msg);
			
	}
	

	/**
	 * To send peer message through <code>toAddress</code>
	 * 
	 * @param toAddress destination address
	 * @param message the peer message
	 */
	public void send(Address toAddress, BasicMessage message){
		
		send(toAddress, null, message); 
		
	}
	
	
	/**
	 * To send peer message through <code>toContactAddress</code>
	 * 
	 * @param toAddress destination address (local)
	 * @param toContactAddress contact address (address)
	 * @param message the peer message
	 */

	public void send(Address toAddress, Address toContactAddress, BasicMessage message){

		try{
			if(nodeConfig.content_msg.equals("text")){
				sendMessage(toAddress, toContactAddress, new Address(peerDescriptor.getAddress()), message.toString(), parserMsg.getContentType());
			}
			else{
				sendMessage(toAddress, toContactAddress, new Address(peerDescriptor.getAddress()), parserMsg.marshal(message), parserMsg.getContentType());
			}
		}
		catch (NullPointerException e) {
			throw new RuntimeException(e);

		}
	}
	
	/**
	 * To send the peer message using NeighborPeerDescriptor of the recipient peer. If Contact Address, of the PeerDescriptor class,
	 * contains the public address the message is sent through it.
	 * 
	 * @param toNeighborPeer NeighborPeerDescriptor of the peer
	 * @param message the peer message
	 */
	
	//the one method that check if peer is reached locally or through gatewayPeer contact address
	public void send(NeighborPeerDescriptor toNeighborPeer, BasicMessage message){
	
		if(toNeighborPeer.localReachability()=="yes")
			send(new Address(toNeighborPeer.getAddress()), new Address(toNeighborPeer.getAddress()), message);
		else
			send(new Address(toNeighborPeer.getAddress()), new Address(toNeighborPeer.getContactAddress()), message);
			
	}
	
	/**
	 * 
	 * Stop peer communication
	 */
	
	public void halt(){
		
		sipProvider.halt();
	}
	
	
	/**
	 * Add peer descriptor of the near peer to list 
	 * 
	 * @param neighborPeer NeighborPeerDescriptor
	 * @return NeighborPeerDescriptor the update NeighborPeerDescriptor
	 */
	public NeighborPeerDescriptor addNeighborPeer(PeerDescriptor neighborPeer){

		NeighborPeerDescriptor neighborPD = null;
		
		try{

			 neighborPD = new NeighborPeerDescriptor(neighborPeer);
		
			//Test if a neighbor peer is reached by "address" value of the PeerDescriptor
			 
			if(nodeConfig.test_address_reachability.equals("yes")){
				//check if the local address of peer is reached
				ResolutionHost resHost = new ResolutionHost(new Address(neighborPeer.getAddress()));
				//timeout in milliseconds
				if(resHost.isReachable(3000)){
					neighborPD.setLocalReachability("yes");
				
				}
				else
					neighborPD.setLocalReachability("no");
			}
		
			
			peerList.put(neighborPD.getKey(), neighborPD);

		}
		catch (NullPointerException e) {
			return neighborPD;
		}
		return neighborPD;

	}

    /**
     * Remove peer descriptor of the near peer from list 
     * 
     * @param key the key that identifies the peer
     * @return boolean if true the removal was successful
     */
	public boolean removeNeighborPeer(String key){

		try{
			peerList.remove(key);
		}
		catch (NullPointerException e) {
			return false;
		}
		return true;

	}

	/**
	 * 
	 * Remove peer descriptor of the near peer from list 
	 * 
	 * @param peerAddress the address that identifies the peer
	 * @return boolean if true the removal was successful
	 */
	
	public boolean removeNeighborPeer(Address peerAddress){

		if(peerAddress!=null){

			Iterator<String> iter = peerList.keySet().iterator();

			while(iter.hasNext()){

				String key = iter.next();

				NeighborPeerDescriptor peerDesc = peerList.get(key);

				if(peerDesc.getAddress().compareTo(peerAddress.getURL())==0){

					peerList.remove(key);
				}

			}

			return true;
		}
		else
			return false;

	}
	
	
	@Override
	protected void onReceivedMsg(String peerMsg, Address sender, String contentType) {
		
		if(contentType.equals(JSONParser.MSG_JSON)){
			
			JSONObject jsonMsg = (JSONObject) parserMsg.unmarshal(peerMsg);
			onReceivedJSONMsg(jsonMsg, sender);
		}
	}
	
	protected void onReceivedJSONMsg(JSONObject jsonMsg, Address sender){
		
		
	}

	
	@Override
	protected void onReceivedSBCMsg(String SBCMsg){
		/*
		 * part of SBC Handshaking 
		 */

		if(SBCMsg.equals("NAT_ON"))
			requestPublicAddress();
		//else NAT OFF 
			//the contact address is the local address
	}
	
	@Override
	protected void onReceivedSBCContactAddress(Address cAddress) {
		
		/*
		 * part of SBC Handshaking 
		 */
		this.peerDescriptor.setContactAddress(cAddress.getURL());
		
		/*
		 * send message with HELLO string in the SIP Message body,
		 * this is important because opens the NAT port 
		 */
		sendMessage(cAddress, new Address(peerDescriptor.getAddress()), "HELLO", null);
		
	}

	/**
	 * Save log 
	 * 
	 * @param info information that must be saved
	 * @param log Log object
	 */
	public void printLog(String info, Log log){  

		 log.println(info);
		 
	}
	
	/**
	 * Save log in the JSON format
	 * 
	 * @param jsonInfo information that must be saved in the JSON format
	 * @param log Log object
	 * @param timestamp enable/disable timestamp print
	 */
	
	public void printJSONLog(JSONObject jsonInfo, Log log, boolean timestamp){
		
		log.setTimestamp(timestamp);
		log.println(jsonInfo.toString());
		
	}

}
