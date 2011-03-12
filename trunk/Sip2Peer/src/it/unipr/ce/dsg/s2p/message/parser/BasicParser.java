package it.unipr.ce.dsg.s2p.message.parser;

/*
 * Copyright (C) 2010 University of Parma - Italy
 * 
 * This source code is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This source code is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this source code; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 * 
 * Designer(s):
 * Marco Picone (picone@ce.unipr.it)
 * Fabrizio Caramia (fabrizio.caramia@studenti.unipr.it)
 * Michele Amoretti (michele.amoretti@unipr.it)
 * 
 * Developer(s)
 * Fabrizio Caramia (fabrizio.caramia@studenti.unipr.it)
 * 
 */


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
