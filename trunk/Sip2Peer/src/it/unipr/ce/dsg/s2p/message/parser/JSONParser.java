package it.unipr.ce.dsg.s2p.message.parser;

import it.unipr.ce.dsg.s2p.message.BasicMessage;
import it.unipr.ce.dsg.s2p.org.json.JSONException;
import it.unipr.ce.dsg.s2p.org.json.JSONObject;

/**
 * Class <code>JSONParser</code> that extends <code>BasicParser</code> 
 * for mashalling and unmarshalling message in the JSON format.
 * 
 * @author Fabrizio Caramia
 *
 */
public class JSONParser extends BasicParser {
	
	/**
	 * Defines JSON content type
	 */
	public static final String MSG_JSON="application/json"; 

	/**
	 * Create a new JSONParser to marshalling and unmarshalling peer message into JSON format
	 * 
	 * @param formatMsg peer message
 	 */
	
	public JSONParser(String formatMsg) {
		super(formatMsg);
		
	}

	@Override
	public String marshal(BasicMessage msg) {
		
		if(contentMsg.equals("json")){
			
			JSONObject jsonMsg = new JSONObject(msg);
			return jsonMsg.toString();
		}
		else 
			return msg.toString();
	}

	@Override
	public JSONObject unmarshal(String msg) {
		
		JSONObject jsonMsg;
		
		try {
			jsonMsg = new JSONObject(msg);
			return jsonMsg;
			
		} catch (JSONException e) {
			throw new RuntimeException(e);
		}
		
	}

	@Override
	public String getContentType() {
			
		super.getContentType();
			
		if(contentMsg.equals("json"))
				return MSG_JSON;
		
		return MSG_TEXT;
			
			
			
	}
	
	

}
