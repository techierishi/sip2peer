package it.unipr.ce.dsg.s2p.peer;

/**
 * Class <code>PeerDescriptor</code> maintains information
 * about a peer to publicize its name, key, address and contact address to other peer.
 * <p>
 * Thera are two address that identifies the peer:<br>
 * -address: is the local address<br>
 * -contact address: generally is the remote address associated through the SBC<br>
 * the address and the contact address may also be the same.
 * @author Fabrizio Caramia
 *
 */

public class PeerDescriptor {
	
	private String name;
	private String key;
	private String address;
	private String contactAddress;
	
	/**
	 * Create a new empty PeerDescriptor
	 * 
	 */
	
	public PeerDescriptor() {
		
	}
	
	/**
	 * Create a new PeerDescriptor
	 * 
	 * @param name the name of peer
	 * @param address the local address of the peer
	 * @param key the key that identifies the peer
	 */
	
	public PeerDescriptor(String name, String address, String key){
		
		this.setName(name);
		this.setAddress(address);
		this.setKey(key);
		this.setContactAddress(address);
		
	}
	
	
	/**
	 * Create a new PeerDescriptor
	 * 
	 * @param name the name of peer
	 * @param address the local address of the peer
	 * @param key the key that identifies the peer
	 * @param contactAddress the remote address associated through the SBC. If SBC isn't present the contact address is equal to address
	 */
	public PeerDescriptor(String name, String address, String key, String contactAddress){
		
		this.setName(name);
		this.setAddress(address);
		this.setKey(key);
		this.setContactAddress(contactAddress);
		
	}
	
	/**
	 * Get the name of the peer
	 * @return String name
	 */
	
	public String getName() {
		return name;
	}
	
	/**
	 * Set name of the peer
	 * @param name peer name
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * Get the key of the peer
	 * 
	 * @return String key
	 */
	public String getKey() {
		return key;
	}
	
	/**
	 * Set the key of the peer
	 * 
	 * @param key the key that identifies the peer
	 */
	public void setKey(String key) {
		this.key = key;
	}
	
	/**
	 * Get the address of the peer
	 * 
	 * @return String address 
	 */
	
	public String getAddress() {
		return address;
	}
	
	/**
	 * Set the address of the peer
	 * 
	 * @param address the address (local) that identifies the peer
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	
	/**
	 * Get the contact address of the peer
	 * 
	 * @return String contact address
	 */
	public String getContactAddress() {
		return contactAddress;
	}
	
	/**
	 * Set contact address of the peer
	 * 
	 * @param contactAddress the contact address (remote) that identifies the peer
	 */
	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}
	
	
	/**
	 * Return a String with all information of the PeerDescriptor
	 * 
	 */
	
	@Override
	public String toString() {
		 
		StringBuilder result = new StringBuilder();
		String NEW_LINE = System.getProperty("line.separator");

		result.append("name: " + getName() + NEW_LINE); 
		result.append("address: " + getAddress() + NEW_LINE); 
		result.append("key: " + getKey() + NEW_LINE);
		result.append("contact address: " + getContactAddress() + NEW_LINE);
		
		return result.toString();
	}
	
	
	

}
