# sip2peer Tutorial #

sip2peer is an open-source SIP-based middleware for the implementation of distributed and peer-to-peer applications or overlay, without constrains on device nature (fixed/mobile) and specific architecture.

Main features are:

  * Multiplatform nature
  * Simple communication API with notification system
  * SIP-based platform
  * NAT traversal management
  * Efficient, scalable and configurable structure

**Supported Platform**

At this moment sip2peer is available for Java SE and Android platforms, but we are working on the iOS release.

## Java/Android Tutorial ##

This tutorial shows the main elements of the library, and how to create a simple peer that interacts with other peers. We analyze also the problem of NAT traversal and show how to address it with sip2peer. The code of this example and others (more complex) is available in Sip2PeerExample.zip in the Download page.

As mentioned before, the Java and the Android implementation of the library are based on the java SIP stack called MjSip [http://www.mjsip.org](http://www.mjsip.org) that allows to manage the exchange of SIP messages or multimedia streams.

Creating our own peer class using sip2peer is extremely simple and it is only necessary to extend the Class called **Peer**. In this example we have:

```
public class SimplePeer extends Peer  
```

All constructors accept the path of the configuration file (explained later in this tutorial) and additional parameters like node key, peerName and eventually the needed message parser.

Different constructors are available with different parameters and configuration:

```
1) public Peer(String pathConfig, String key);
2) public Peer(String pathConfig, String key, String peerName, int peerPort);
3) public Peer(String pathConfig, String key, String peerName, int peerPort, BasicParser parser);
4) public Peer(String pathConfig, String key, BasicParser parser);
```

In particular in this tutorial we focus on number 1 and 2, that allow to specify a configuration file with node parameters and the peer port.

The class constructor has to call the super method with  the path of peer configuration file (for detailed information about it, look below in this tutorial) and the unique key of the peer in the network.

```
public SimplePeer(String pathConfig) {
		super(pathConfig, "a5ds465a465a45d4s64d6a");
}
```

Sip2peer supports two message formats. It is possible to manage simple text message containing any kind of information like raw data or XML and it is also possible to natively use JSON format. Following this scalable approach, the Peer class provides all needed methods to send and receive messages allowing the developer to select the best solution according to his/her protocol and overlay.

The following methods can be overridden and are automatically called when the node receives a message (1 for String and 2 for JSON based msgs) and when a message is correctly delivered or if there are errors.

```

@Override
protected void onReceivedMsg(String peerMsg, Address sender, String contentType) {
	super.onReceivedMsg(peerMsg, sender, contentType);
        ...
}

@Override
protected void onReceivedJSONMsg(JSONObject jsonMsg, Address sender) {
	super.onReceivedJSONMsg(jsonMsg, sender);
        ...
}

@Override
protected void onDeliveryMsgFailure(String peerMsgSended, Address receiver,String contentType) {
	....	
}

@Override
protected void onDeliveryMsgSuccess(String peerMsgSended, Address receiver,String contentType) {
        ....      
}
```

These methods are called when the node receives a message (String or JSON based) and when a message is correctly delivered, or if there are some errors.

Four important methods are inherited from the base class, providing the appropriate functions to send a message to a destination node. These methods are:

```

1) public void sendMessage(Address toAddress, Address fromAddress, String msg, String contentType)

2) public void sendMessage(Address toAddress, Address toContactAddress, Address fromAddress, String msg, String contentType)

3) public void send(Address toAddress, BasicMessage message);

4) public void send(Address toAddress, Address toContactAddress, BasicMessage message)
```

1) and 2) do not use our JSON based message approach but allow the developer to send a generic String to the destination.
3) and 4) use our JSON based message approach, allowing the developer to easily extend BasicMessage class to create specific and custom messages. In this tutorial and generally in every example we will use the JSON based approach.

A Methods 2 and 4 use "toContactAddress" in addition to "toAddress" parameter. The contact address represents the real destination address of the target node, while the first one is kept only as reference. This is useful in different scenarios where a peer behind a NAT advertises as contact address a specific ip:port different form the private one where it can receive incoming messages without firewall or NAT issues.

The Peer class also provides the following useful and ready-to-use instances:
  * **PeerDescriptor**: a simple structure to keep information about node like:
    * name (loaded from configuration file)
    * key
    * address
    * contactAddress
  * **PeerListManager**: extends Hashtable, defining a simple and ready-to-use structure to hold the peer descriptors of known nodes.

Message definition and management in sip2peer by default is based on the JSON format ([http://www.json.org/](http://www.json.org/)), but the design is open to other formats, such as XML.

In this tutorial we focus on JSON both for message definition and exchange, because it is more simple for defining, sending and parsing generic messages. For this reason we use the appropriate methods associated with JSON, i.e.:

  * protected void onReceivedJSONMsg(JSONObject jsonMsg, Address sender)
  * public void send(Address toAddress, BasicMessage message);
  * public void send(Address toAddress, Address toContactAddress, BasicMessage message)

The base class used to define a message that could be easily transformed in a JSON string is **BaseMessage**, that defines the following general structure:

  * long timestamp
  * String type
  * Payload payload

Payload in another base class of the library that defines a data structure of  key/value for the message (implements an Hashtable). The class permits different approach to create a payload, through constructors and methods. It is also possible to directly add and remove parameters from it. Detailed information are available in the JAVA Doc of the project.

If for example we want to create a simple PING Message to send the node's PeerDescriptor to another active user, we just need to extend the BasicMessage class, redefining the constructor according to our needs. The result class will be:

```
public class PingMessage extends BasicMessage {
	
	public static final String MSG_PEER_PING="peer_ping"; 
	
	
	public PingMessage(PeerDescriptor peerDesc) {
		
		super(MSG_PEER_PING, new Payload(peerDesc));
	
	}
}
```

The same approach can be used to create a message to send the peer list, or for the JoinMessage.

```
public class PeerListMessage extends BasicMessage {

	public static final String MSG_PEER_LIST="peer_list"; 

	public PeerListMessage(PeerListManager peerList) {
		super(MSG_PEER_LIST, new Payload(peerList));
		
	}
}

public class JoinMessage extends BasicMessage{
	
	private int numPeerList;
	
	
	public static final String MSG_PEER_JOIN="peer_join"; 

	public JoinMessage(PeerDescriptor peerDesc) {
		
		super(MSG_PEER_JOIN, new Payload(peerDesc));
		setNumPeerList(0);
	}

	public int getNumPeerList() {
		return numPeerList;
	}

	public void setNumPeerList(int numPeerList) {
		this.numPeerList = numPeerList;
	}
}

```

As already described, the transmission of BasicMessage with send methods 3) or 4) implies that the message object is converted into a JSON Object and sent as a JSON format string.

Referring to the JSON library that we are using at the moment, the JSONObject constructor uses bean getters. It reflects on all of the public methods of the object. For each of the methods with no parameters and a name starting with "get" or "is" followed by an uppercase letter, the method is invoked, and a key and the value returned from the getter method are put into the new JSONObject. The key is formed by removing the "get" or "is" prefix. If the second remaining character is not upper case, then the first character is converted to lower case.

For example, if an object has a method named "getName", and if the result of calling object.getName() is "Larry Fine", then the JSONObject will contain "name": "Larry Fine". For this reason, as shown in the JoinMessage class, it is mandatory to implement get methods to expose the parameters we want to include in the JSON object representing the message. This rule is valid not only for the Message instance, but also for each kind of Object added in the Payload.

It is also possible to explicitly add element to the payload as for this example of ACK Message:

```
public class AckMessage extends BasicMessage  {

	public static final String ACK_MSG="ack"; 
	
	public AckMessage(String status, String msg) {
		super();
		Payload payload = new Payload();
		payload.addParam("status", status);
		payload.addParam("msg", msg);	
		this.setType(ACK_MSG);
		this.setPayload(payload);
	}	
}
```

In order to complete our simple peer class we just need to add a function that allows to send a JoinMessage to a destination address, and to define the main method:

```
public void joinToPeer(String toAddress, String contactAddress){

		JoinMessage peerMsg = new JoinMessage(peerDescriptor);
		
		send(new Address(toAddress), new Address(contactAddress), peerMsg);
}

public static void main(String[] args) {

	if(args.length>0){
			SimplePeer peer = new SimplePeer("config/"+args[0]);
			peer.joinToPeer(args[1], args[2]);
        }
}
```


### Node Configuration ###

The Peer class provides the means to configure main parameters of the node. These values can be loaded from the file specified in the constructor, as first parameter, or in the code, by calling the appropriate methods.

Tipically the most useful attributes for a node are:

  * peer\_name=name of the peer advertised in its descriptor
  * format\_message= by default is "json" but could be also "text"
  * sbc: ip:port of the available sbc
  * keepalive\_time: keep alive time value

A configuration file has a simple structure of "key=value" with # to comment the line.
A useful example:

```
peer_name=kate
#format_message=json
sbc=160.78.28.112:6067
keepalive_time=5000
```

The same configuration can be obtained in the following way:

```
SimplePeer peer = new SimplePeer("config/"+args[0]);
peer.nodeConfig.sbc = "160.78.28.112:6067";
peer.nodeConfig.peer_name="kate";
peer.nodeConfig.keepalive_time=5000;
```

It is also possible for the developer to define his own Peer class with additional configuration parameter. For example, read the code of PeerConfig.java and its usage in FullPeer.java - both available in the example zip archive.

Additional SIP configuration for the node are available only by file and the some additional field that can be used are:

  * via\_addr:  contains the desired IP address for the node or the "AUTO-CONFIGURATION" to automatically select the listening interface
  * host\_port: node's port.

A complete configuration file with SIP parameters is for example:

```
via_addr=AUTO-CONFIGURATION 
host_port=5075
peer_name=kate
#format_message=json
sbc=160.78.28.112:6067
keepalive_time=5000
debug_level=1
```

For detailed information about other SIP parameters, refer to MjSip documentation on the official website (in the Java Docs).

### NAT Management ###

Network Address Translation (NAT) is the process of modifying network address information in datagram (IP) packet headers, while in transit across a traffic routing device, for the purpose of remapping one IP address space into another. It is a technique that hides an entire IP address space, usually consisting of private network IP addresses (RFC 1918), behind a single IP address in another, often public address space.

Nowadays NAT is a very common element in computer networking and in particular for peer-to-peer application  may represent an big obstacle for the communication.

In VoIP (Voice over Internet Protocol) networks, a device that is regularly deployed and used to solve NAT traversal problem is the Session Border Controller (SBC). Being sip2peer based on SIP, SBC represents a natural and easily way to solve NAT traversal problems.

Shortly, we can say that in our specific case SBC is a node with public IP that allows a generic peer to check if it is behind a NAT and to request (if necessary) a public IP and port that can be used by the requesting node as contact address and that can be advertised to other peers.

The sip2peer library natively includes an SBC implementation (sip2peerSBC.zip) that can be easily configured and executed on a public IP machine.

Main classes are:

  * **SessionBorderController**: implements the Session Border Controller SIP Server.
  * **SessionBorderControllerConfig**: class for the configuration of the Session Border Controller
  * **TestNATPeer**: class used by the SBC to check if a peer is behind NAT.
  * **GatewayPeer**: implements a Gateway Peer to forward messages to the local peer. Each local peer is associated to a Gateway Peer with public address.

**SBC Configuration**

The main parameters for SBC configuration are:

  * via\_addr: as for node configuration
  * host\_port: as for node configuration
  * transaction\_timeout: sets the timeout for message transaction
  * test\_nat\_port: listening port to test if a peer is behind a NAT
  * max\_gwPeer: Maximum number of peer managed by the SBC
  * init\_port: initialization port
  * debug\_level: as for node configuration

Example:

```
via_addr=AUTO-CONFIGURATION
host_port=6066
transaction_timeout=2000
test_nat_port=6079
max_gwPeer=15
init_port=6080
debug_level=0
```

### Peer & NAT Management ###


In order to manage NAT on the peer side, it is only necessary to set the IP address and port of one of the available SBC servers (with public IP) and then invoke natively method provided by Peer class called checkNAT().

This function starts the procedure with the SBC to verify if the requesting node is behind a NAT and if it is necessary to request a public couple IP:port. If it is the case, the library automatically requests a public address and sets it in the contactAddress (CA) parameter of the peer. Since then, the peer can advertise its CA to other peers, thus becoming reachable from the outside world.

```
	public SimplePeer(String pathConfig) {
		super(pathConfig, "a5ds465a465a45d4s64d6a");
		this.checkNAT();

	}
```

The sip2peer library provides also all methods to manually manage the interaction with the SBC. In particular, requestPublicAddress() allows to directly request a public address to the SBC, without any NAT checks and onReceive methods if override allows to intercept the communication between the node and the SBC.

```
	/**
	 * Request public address from Session Border Controller. Send REQUEST_PORT message to Session Border Controller
	 */

	public void requestPublicAddress(){...}

         /**
	 * When a new message is received from Session Border Controller
	 * 
	 * @param SBCMsg message sent from SBC
	 */
	protected abstract void onReceivedSBCMsg(String SBCMsg);

	/**
	 * When the Contact Address of the peer is received from SBC by its response
	 * 
	 * @param contactAddress
	 */
	protected abstract void onReceivedSBCContactAddress(Address contactAddress);
```