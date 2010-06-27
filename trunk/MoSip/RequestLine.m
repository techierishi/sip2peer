//
//  RequestLine.m
//  StringTest
//
//  Created by Marco Picone on 09/06/09.
//  Copyright 2010 Marco Picone ( http://dsg.ce.unipr.it ) - University of Parma - Italy. 
//  All rights reserved.
//

#import "RequestLine.h"


@implementation RequestLine

@synthesize method;
@synthesize url;

/** Creates a new RequestLine <i>request</i> with <i>sipurl</i> as recipient. */
-(id) initWithRequest:(NSString*) request andSipUrlString:(NSString*) sipUrl
{  
	if(self = [super init])
	{	
		[self setMethod:request];
		[self setUrl:[[SipURL alloc] initWithSipURL:sipUrl]];
	}
	return self;
	
	
}

/** Creates a new RequestLine <i>request</i> with <i>sipurl</i> as recipient. */
-(id) initWithRequest:(NSString*) request andSipUrl:(SipURL*) sipUrl
{  
	if(self = [super init])
	{	
		[self setMethod:request];
		[self setUrl:sipUrl];
	}
	return self;
	
	
}

/** Whetever Object obj is equal to this Status Line **/
- (BOOL)isEqual:(id)obj
{
	if ([obj isKindOfClass:[RequestLine class]]) {
		RequestLine* r= (RequestLine *)obj;
		if([[r method] isEqual:[self method]] && [[r url] isEqual:[self url]]) 
			return YES;
		
		else
			return NO;
	}
	return NO;
}


/** Gets String value of this Object. */
-(NSString*) toString
{  
	
	NSMutableString *mstr;
	mstr = [NSMutableString stringWithString:@"Method:"];
	[mstr appendString:method];
	[mstr appendString:@" URL:"];
	[mstr appendString:[url toString]];
	[mstr appendString:@" SIP/2.0\r\n"];
	
	return mstr;
}

@end
