package local.sbc;

import org.zoolu.sip.address.NameAddress;
import org.zoolu.sip.header.MaxForwardsHeader;
import org.zoolu.sip.header.RecordRouteHeader;
import org.zoolu.sip.header.ViaHeader;
import org.zoolu.sip.message.Message;
import org.zoolu.sip.message.MessageFactory;
import org.zoolu.sip.message.SipResponses;
import org.zoolu.sip.provider.SipProvider;
import org.zoolu.sip.provider.SipProviderListener;
import org.zoolu.sip.provider.SipStack;
import org.zoolu.sip.transaction.TransactionClient;
import org.zoolu.sip.transaction.TransactionClientListener;
import org.zoolu.sip.transaction.TransactionServer;

public class GatewayPeer implements SipProviderListener , TransactionClientListener{
	
	private SipProvider sipPeer;
	
	public GatewayPeer(int listePort){
		
		sipPeer = new SipProvider("AUTO-CONFIGURATION", listePort);
		sipPeer.addSelectiveListener(SipProvider.ANY, this);
		
	}

	@Override
	public void onReceivedMessage(SipProvider sipPeer, Message msgPeer) {
		
		System.out.println("ricevuto messaggio da inviare al peer" + msgPeer.getToHeader().getNameAddress().getAddress());
		
		/*TransactionServer transactionServer=new TransactionServer(sipPeer, msgPeer, null);
		transactionServer.respondWith(MessageFactory.createResponse( msgPeer, 200, SipResponses.reasonOf(200), null));*/
		
		
		//remove route header and add record-route header
		if(msgPeer.hasRouteHeader()){
			NameAddress nameAdd = msgPeer.getRouteHeader().getNameAddress();
			msgPeer.removeRouteHeader();
			msgPeer.addRecordRouteHeader( new RecordRouteHeader(nameAdd));
		}
		
		ViaHeader via=new ViaHeader(sipPeer.getDefaultTransport(), sipPeer.getViaAddress(), sipPeer.getPort());
	      if (sipPeer.isRportSet()) via.setRport();
	      String branch=sipPeer.pickBranch(msgPeer);
	     
	      via.setBranch(branch);
	      msgPeer.addViaHeader(via);

	      // decrement Max-Forwards
	      MaxForwardsHeader maxfwd=msgPeer.getMaxForwardsHeader();
	      if (maxfwd!=null) maxfwd.decrement();
	      else maxfwd=new MaxForwardsHeader(SipStack.max_forwards);
	      msgPeer.setMaxForwardsHeader(maxfwd);
		
				
		TransactionClient transactionClient=new TransactionClient(sipPeer, msgPeer, this);
		transactionClient.request();
	}

	@Override
	public void onTransFailureResponse(TransactionClient arg0, Message arg1) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onTransProvisionalResponse(TransactionClient arg0, Message arg1) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onTransSuccessResponse(TransactionClient arg0, Message arg1) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onTransTimeout(TransactionClient arg0) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
	
	
	
	

}
