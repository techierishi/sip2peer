//
//  SipURL.h
//  StringTest
//
//  Created by Marco Picone on 09/06/09.
//  Copyright 2010 Marco Picone ( http://dsg.ce.unipr.it ) - University of Parma - Italy. 
//  All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SipURL : NSObject {
	
	/** Whether has SIPS Scheme **/
	BOOL secure;
	
	/** SIP URL **/
	NSString* url;
	
}

@property BOOL secure;
@property (nonatomic, retain) NSString* url;

/* Create a New SipURL strating from a URL Value*/
-(id) initWithSipURL:(NSString*) urlValue;

/* Create a New SipURL starting from hostname, username and portNumber*/
-(id) initWithUsername:(NSString*) userName hostName:(NSString*)hostName portNumber:(int)portNumber;

/* Create a New SipURL starting from hostname, username */
-(id) initWithUserName:(NSString*) userName hostName:(NSString*)hostName;

/* Create a New SipURL starting from hostname, portNumber*/
-(id) initWithHostName:(NSString*) hostName portNumber:(int)portNumber;

/* Gets Scheme (sip or sips) */
-(NSString*) getScheme;

/* Gets user name of SipUrl (Return nil if user name does note exist) */
-(NSString*) getUserName;

/* Gets Host of SipUrl */
-(NSString*) getHost;

/** Gets port of SipURL; returns -1 if port is not specidfied. */
-(int) getPort;

/** Gets boolean value to indicate if SipURL has user name. */
-(BOOL) hasUserName;

/** Gets boolean value to indicate if SipURL has port. */
-(BOOL) hasPort;

/** Gets string representation of URL. */
-(NSString*) toString;

/** Gets the string of all parameters. Returns a string of all parameters or null if no parameter is present. */
-(NSString*) getParameters;

/** Whetever Object obj is equal to this SIP URL **/
- (BOOL)isEqual:(id)obj;

@end
