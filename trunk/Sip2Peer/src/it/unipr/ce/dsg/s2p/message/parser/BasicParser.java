package it.unipr.ce.dsg.s2p.message.parser;

import it.unipr.ce.dsg.s2p.message.BasicMessage;


/**
 * The <code>BasicParser</code> is an abstract class 
 * to marshal and unmarshal the messages of the peer
 * with a data-interchange format (es. JSON, XML).
 * <p>
 * All class that extends <code>BasicParser</code> should implement
 * a content type. For example in JSON format will be MSG_JSON="application/json" 
 * 
 * @author Fabrizio Caramia
 *
 */

public abstract class BasicParser {
	/** 
	 * Specifies the content type.
	 */
	public static final String MSG_TEXT="application/text"; 
	
	protected String contentMsg;
	
	public BasicParser(String contentMsg){
	
		this.contentMsg = contentMsg;
	
	}
	
	/**
	 * Marshal a message
	 * 
	 * @param msg the message that will be converted into a format
	 * @return String message after marshalling
	 */
	public abstract String marshal(BasicMessage msg);
	
	/**
	 * Parse a message
	 * 
	 * @param msg the message string that will be parsed
	 * @return Object after unmarshalling
	 */
	public abstract Object unmarshal(String msg);
	
	/**
	 * Get the content type
	 * 
	 * @return the content type of the message
	 */
	public String getContentType(){
		
		if(contentMsg.equals("text"))
			return MSG_TEXT;
		
		return null;	
	}

}
