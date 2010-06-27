//
//  StatusLine.h
//  StringTest
//
//  Created by Marco Picone on 09/06/09.
//  Copyright 2010 Marco Picone ( http://dsg.ce.unipr.it ) - University of Parma - Italy. 
//  All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface StatusLine : NSObject {
	
	/** Status Code **/
	int code;
	
	/** Status Reason **/
	NSString* reason;
	
}

@property int code;
@property (nonatomic, retain) NSString* reason;

/** Init Status Line with Code and Reason **/
-(id)initWithCode:(int)codeValue andReason:(NSString*)reasonValue;

@end
