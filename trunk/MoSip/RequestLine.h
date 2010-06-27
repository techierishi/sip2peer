//
//  RequestLine.h
//  StringTest
//
//  Created by marcopk on 09/06/09.
//  Copyright 2010 Marco Picone ( http://dsg.ce.unipr.it ) - University of Parma - Italy. 
//  All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SipURL.h"


@interface RequestLine : NSObject {
	
	/** Request Method **/
	NSString* method;
	
	/** Request target */
	SipURL* url;
	
}

@property (nonatomic,retain) NSString* method;
@property (nonatomic,retain) SipURL* url;

/** Creates a new RequestLine <i>request</i> with <i>sipurl</i> as recipient. */
-(id) initWithRequest:(NSString*) request andSipUrlString:(NSString*) sipUrl;

/** Creates a new RequestLine <i>request</i> with <i>sipurl</i> as recipient. */
-(id) initWithRequest:(NSString*) request andSipUrl:(SipURL*) sipUrl;

/** Gets String value of this Object. */
-(NSString*) toString;

@end
