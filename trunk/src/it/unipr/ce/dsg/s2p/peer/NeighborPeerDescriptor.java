package it.unipr.ce.dsg.s2p.peer;

/**
 * Class <code>NeighborPeerDescriptor</code> extends PeerDescriptor
 * adding the reachability information about the known peers. The reachability
 * is verified into <code>Peer</code> class.
 * 
 * @author Fabrizio Caramia
 *
 */


public class NeighborPeerDescriptor extends PeerDescriptor {
	
	private String localReachability;
	
	/**
	 * Create a new NeighborPeerDescriptor
	 */
	public NeighborPeerDescriptor() {
		super();
	}

	/**
	 * Create a new NeighborPeerDescriptor from a PeerDescriptor
	 * 
	 * @param peerDesc PeerDescriptor
	 */
	public NeighborPeerDescriptor(PeerDescriptor peerDesc) {
		super(peerDesc.getName(), peerDesc.getAddress(), peerDesc.getKey(), peerDesc.getContactAddress());
		setLocalReachability(null);
	}

	/**
	 * Get local reachability information
	 * @return local reachability information
	 */
	public String localReachability() {
		return localReachability;
	}

	/**
	 * Set local reachability information
	 * @param localReachability local reachability information
	 */
	public void setLocalReachability(String localReachability) {
		this.localReachability = localReachability;
	}

}
