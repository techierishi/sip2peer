package local.sbc;

import java.util.Vector;

import org.zoolu.sip.address.NameAddress;
import org.zoolu.sip.address.SipURL;
import org.zoolu.sip.header.ContactHeader;
import org.zoolu.sip.header.Header;
import org.zoolu.sip.message.Message;
import org.zoolu.sip.message.MessageFactory;
import org.zoolu.sip.provider.SipProvider;
import org.zoolu.sip.transaction.TransactionClient;
import org.zoolu.sip.transaction.TransactionClientListener;

import local.server.Proxy;
import local.server.ServerProfile;

public class SessionBorderController extends Proxy implements TransactionClientListener{


	SessionBorderController(SipProvider sipProvider, ServerProfile serverProfile){

		
		super(sipProvider, serverProfile); 


	}
	
	//
	public void processRequestToLocalServer(Message msg){
		
		super.processRequestToLocalServer(msg);
		String contact;
		NameAddress nameAddress = null;
		SipURL mySipURL = new SipURL(sip_provider.getViaAddress());
		
		//System.out.println("to " +  msg.getContacts().getHeaders().elementAt(0).);
		Vector contacts=msg.getContacts().getHeaders();

		for (int i=0; i<contacts.size(); i++)     
		{  
			ContactHeader contactHeader=new ContactHeader((Header)contacts.elementAt(i));
			nameAddress = contactHeader.getNameAddress();     
			//contact = nameAddress.getAddress().toString();
			//System.out.println("contact " + contact);
		}
		
		//send SIP MESSAGE to contact of local peer
		Message message=MessageFactory.createMessageRequest(sip_provider,  nameAddress, new NameAddress(mySipURL), null, "application/text", "messaggio di prova");
		TransactionClient transactionClient=new TransactionClient(sip_provider, message, this);
		transactionClient.request();
		
		
		GatewayPeer gatewayPeer = new GatewayPeer(5080);
			
	   }
	
	
	
	
	public static void main(String[] args) {

		SipProvider sipProvider = new SipProvider("config/"+args[0]);
		
		ServerProfile serverP = new ServerProfile(null);
		@SuppressWarnings("unused")
		SessionBorderController sbc = new SessionBorderController(sipProvider, serverP);


	}

	@Override
	public void onTransFailureResponse(TransactionClient arg0, Message msg) {
		String message = msg.getStatusLine().getReason();
		System.out.println("Status line failure " + message);
	}

	@Override
	public void onTransProvisionalResponse(TransactionClient arg0, Message arg1) {
		
		
	}

	@Override
	public void onTransSuccessResponse(TransactionClient arg0, Message msg) {
		
		String message = msg.getStatusLine().getReason();
		System.out.println("Status line success " + message);
	}

	@Override
	public void onTransTimeout(TransactionClient arg0) {
		// TODO Auto-generated method stub
		
	}
	

}
