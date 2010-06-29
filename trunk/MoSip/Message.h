//
//  Message.h
//  StringTest
//
//  Created by Marco Picone on 09/06/09.
//  Copyright 2010 Marco Picone ( http://dsg.ce.unipr.it ) - University of Parma - Italy. 
//  All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StatusLine.h"
#import "RequestLine.h"


@interface Message : NSObject {
	
    RequestLine *request_line;
	StatusLine *status_line;	
	NSString* body;
	NSArray* headers;
	
}

@property (nonatomic,retain) RequestLine* request_line;
@property (nonatomic,retain) StatusLine* status_line;
@property (nonatomic,retain) NSString* body;
@property (nonatomic,retain) NSArray* headers;


/** Creates new message from String */
-(id) initWithStringMessage: (NSString*) s;

/** Creates a new Message */ 
-(id) initWithMessage:(Message*)msg;




@end
