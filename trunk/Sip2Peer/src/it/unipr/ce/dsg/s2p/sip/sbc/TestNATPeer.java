package it.unipr.ce.dsg.s2p.sip.sbc;


import org.zoolu.sip.message.Message;
import org.zoolu.sip.transaction.TransactionClient;

/**
 * Class <code>TestNATPeer</code> extends GatewayPeer.
 * The TestNATPeer check if a peer is behind NAT.
 * 
 * 
 * @author Fabrizio Caramia
 */

public class TestNATPeer extends GatewayPeer {

	private TestNATListener testListener; 

	/**
	 * Create a TestNATPeer
	 * 
	 * @param namePeer TestNATPeer name
	 * @param listenPort port associated
	 * @param testListener listener
	 */
	public TestNATPeer(String namePeer, int listenPort, TestNATListener testListener) {
		super(namePeer, listenPort);

		this.testListener=testListener;
	}

	public void onTransTimeout(TransactionClient tc) {
		//toHeader contain the local address
		//Request Line contain the remote address
		Message msg=tc.getRequestMessage();
		this.testListener.onFailureTest("Timeout", msg.getToHeader().getNameAddress().getAddress(), msg.getRequestLine().getAddress());
	}

	public void onTransFailureResponse(TransactionClient tc, Message msg) {
		
		Message msgReq=tc.getRequestMessage();
		this.testListener.onFailureTest("Failure", msgReq.getToHeader().getNameAddress().getAddress(), msgReq.getRequestLine().getAddress());
	}

	public void onTransSuccessResponse(TransactionClient tc, Message msg) {
		
		Message msgReq=tc.getRequestMessage();
		this.testListener.onSuccessTest("Success", msgReq.getToHeader().getNameAddress().getAddress(), msgReq.getRequestLine().getAddress());

	}

}
