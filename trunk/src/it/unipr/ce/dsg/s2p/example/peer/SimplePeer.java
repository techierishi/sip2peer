package it.unipr.ce.dsg.s2p.example.peer;

import it.unipr.ce.dsg.s2p.example.msg.JoinMessage;
import it.unipr.ce.dsg.s2p.peer.Peer;
import it.unipr.ce.dsg.s2p.sip.Address;


/**
 * 
 * A very simple peer.
 * 
 * @author Fabrizio Caramia
 *
 */
public class SimplePeer extends Peer {

	public SimplePeer(String pathConfig) {
		super(pathConfig, "a5ds465a465a45d4s64d6a");

	}

	public void joinToPeer(String toAddress, String contactAddress){

		JoinMessage peerMsg = new JoinMessage(peerDescriptor);

		send(new Address(toAddress), new Address(contactAddress), peerMsg);

	}

	@Override
	protected void onDeliveryMsgFailure(String peerMsgSended, Address receiver,
			String contentType) {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void onDeliveryMsgSuccess(String peerMsgSended, Address receiver,
			String contentType) {
		// TODO Auto-generated method stub
		
	}
	
	public static void main(String[] args) {

		if(args.length>0){

			SimplePeer peer = new SimplePeer("config/"+args[0]);
			peer.joinToPeer(args[1], args[2]);
		}



	}
}
