# Introduction #

Instructions about how to run sip2peer examples


# Simple Peer #

SimplePeer.java located in the package called "it.unipr.ce.dsg.s2p.example.peer" represents a first and easy example about how to use sip2peer library.

Extends Peer class and implements message managements methods described in the library tutorial.

```
public class SimplePeer extends Peer

protected void onReceivedJSONMsg(JSONObject jsonMsg, Address sender)

protected void onDeliveryMsgFailure(String peerMsgSended, Address receiver,String contentType)

protected void onDeliveryMsgSuccess(String peerMsgSended, Address receiver,String contentType)

protected void onReceivedMsg(String peerMsg, Address sender,String contentType)

```

The main method contains takes 3 arguments as input:

  * name of configuration file
  * address of destination peer
  * contact address of the destination peer

and use these values to instantiate the node with the configuration file

```
SimplePeer peer = new SimplePeer("config/"+args[0]);
```

and to send a JoinMessage to the destination peer

```
peer.joinToPeer(args[1], args[2]);
```

In order to run the example you have to create a new configuration file based on k.cfg structure inside the "config" folder of Sip2Peer example.
The new configuration file will have to following fields in particular to specify the name of the peer and the port on which it is listening.

```

via_addr=AUTO-CONFIGURATION 

host_port=5075

peer_name=Peer_A

test_address_reachability=no

log_path=log/

keepalive_time=5000

debug_level=1

```

If you want to run two instances of SimplePeer on the same machine you have to change properly the port number in the configuration file in order to allow the communication.

For example if we have different Simple Peers (A and B) on the same machine (with IP 192.168.1.15) we have to create two configuration file (a\_k.cfg and b\_k.cfg) with two different port host port values ( A with port 5075 and B with port 5076) and two different Peer names (Peer\_A and Peer\_B).
Running arguments for Peer\_A will be "a\_k.cfg Peer\_B@192.168.1.15:5076 Peer\_B@192.168.1.15:5076" and for Peer\_B "b\_k.cfg Peer\_A@192.168.1.15:5076 Peer\_A@192.168.1.15:5075".

In order to execute the same scenario on two different machine Computer\_A (with IP 192.168.1.15) and Computer\_B (with IP 192.168.1.16) of the same LAN you can keep the same port for the two nodes changing only the peer name field.
In this second scenario running arguments for Peer\_A will be "a\_k.cfg Peer\_B@192.168.1.16:5075 Peer\_B@192.168.1.16:5075" and for Peer\_B "b\_k.cfg Peer\_A@192.168.1.15:5075 Peer\_A@192.168.1.15:5075".