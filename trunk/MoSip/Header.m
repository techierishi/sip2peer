//
//  Header.m
//  MOSip
//
//  Created by marcopk on 27/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Header.h"


@implementation Header

@synthesize name;
@synthesize value;

/** Creates a void Header. */
-(id) init
{
	if(self = [super init])
	{	
		self.name = nil;
		self.value = nil;
	}
	return self;
}

/** Creates a new Header. */
-(id) initWithName:(NSString*)hname andValue:(NSString*)hvalue
{  
	if(self = [super init])
	{	
		[self setName:hname];
		[self setValue:hvalue];
	}
	return self;
}

@end
