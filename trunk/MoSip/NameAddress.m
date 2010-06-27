//
//  NameAddress.m
//  StringTest
//
//  Created by marcopk on 09/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NameAddress.h"
#import "SipParser.h"

@implementation NameAddress

@synthesize name;
@synthesize url;

/** Creates a new NameAddress. */
-(id) initWithName:(NSString*)display_name andSipUrl:(SipURL*)urlValue
{  
	if(self = [super init])
	{
		[self setName:display_name];
		[self setUrl:urlValue];
	}
	
	return self;
}

/** Creates a new NameAddress. */
-(id)initWithSipUrl:(SipURL*)urlValue
{  
	if(self = [super init])
	{
		[self setName:nil];
		[self setUrl:urlValue];
	}
	
	return self;
}

/** Creates a new NameAddress. */
-(id)initWithNameAddress:(NameAddress*) naddr
{  
	if(self = [super init])
	{
		[self setName:[naddr name]];
		[self setUrl:[naddr url]];
	}
	
	return self;
}

/** Creates a new NameAddress. */
-(id) initWithString:(NSString*)str
{  
	SipParser* sipParser = [[SipParser alloc] initWithString:str];
	
	NameAddress* naddr=[sipParser getNameAddress];
	
	if(self = [super init])
	{
		[self setName:[naddr name]];
		[self setUrl:[naddr url]];
	}
	
	return self;
	
}

/** Whether object <i>obj</i> is "equal to" this. */
-(BOOL)isEqual:(id)obj;
{
	
	if ( [obj isKindOfClass:[NameAddress class]] ) {
		
		NameAddress* naddr= (NameAddress*)obj;
		
		return (([name isEqual:[naddr name]]) || ([name isEqual:[naddr name]]) && ([url isEqual:[naddr url]]));

	}
	return NO;
}


@end
