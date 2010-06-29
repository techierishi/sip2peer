//
//  Message.m
//  StringTest
//
//  Created by Marco Picone on 09/06/09.
//  Copyright 2010 Marco Picone ( http://dsg.ce.unipr.it ) - University of Parma - Italy. 
//  All rights reserved.
//

#import "Message.h"


@implementation Message

@synthesize request_line;
@synthesize status_line;
@synthesize body;
@synthesize headers;



/** Creates new message from String */
-(id) initWithStringMessage: (NSString*) s
{
	
	
}


/** Creates a new Message */ 
-(id) initWithMessage:(Message*)msg
{

}



@end
