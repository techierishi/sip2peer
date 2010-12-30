package it.unipr.ce.dsg.s2p.example.msg;

import it.unipr.ce.dsg.s2p.message.BasicMessage;
import it.unipr.ce.dsg.s2p.message.Payload;
import it.unipr.ce.dsg.s2p.peer.PeerDescriptor;

/**
 * Class <code>JoinMessage</code> implements a simple message sent by the peer to Bootstrap Peer.
 * The payload of JoinMessage contains the peer descriptor.
 * 
 * @author Fabrizio Caramia
 *
 */

public class JoinMessage extends BasicMessage{
	
	private int numPeerList;
	
	
	public static final String MSG_PEER_JOIN="peer_join"; 

	public JoinMessage(PeerDescriptor peerDesc) {
		
		super(MSG_PEER_JOIN, new Payload(peerDesc));
		
		/**
		 * number of the neighbor peers in the list
		 * 
		 * If numPeerList=0 the BootstrapPeer sends full peer list
		 * If numPeerList=-1 the BootstrapPeer not sends the peer list
		 * Per default all peer are requested
		 * 
		 */
		setNumPeerList(0);
	}

	public int getNumPeerList() {
		return numPeerList;
	}

	public void setNumPeerList(int numPeerList) {
		this.numPeerList = numPeerList;
	}
	
	
	

}
