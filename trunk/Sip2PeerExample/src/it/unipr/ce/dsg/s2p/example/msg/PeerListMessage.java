package it.unipr.ce.dsg.s2p.example.msg;

import it.unipr.ce.dsg.s2p.message.BasicMessage;
import it.unipr.ce.dsg.s2p.message.Payload;
import it.unipr.ce.dsg.s2p.peer.PeerListManager;


/**
 * Class <code>PeerListMessage</code> implements a simple message sent by Bootstrap Peer to peer.
 * The payload of PeerListMessage contains the peer descriptor list.
 * 
 * @author Fabrizio Caramia
 *
 */

public class PeerListMessage extends BasicMessage {
	
	
	public static final String MSG_PEER_LIST="peer_list"; 

	public PeerListMessage(PeerListManager peerList) {
		super(MSG_PEER_LIST, new Payload(peerList));
		
	}
	

}
