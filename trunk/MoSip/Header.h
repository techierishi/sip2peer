//
//  Header.h
//  MOSip
//
//  Created by marcopk on 27/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/** Header Via */
#define H_Via @"Via";

/** Header From */
#define H_From @"From";

/** Header To */
#define H_To @"To";

/** Header Call-ID */
#define H_CallId @"Call-ID";

/** Header CSeq */
#define H_CSeq @"CSeq";

/** Header Max-Forwards */
#define H_MaxForwards @"Max-Forwards";

/** Header Contact */
#define H_Contact @"Contact";

/** Header Expires */
#define H_Expires @"Expires";

/** Header User-Agent */
#define H_UserAgent @"User-Agent";

/** Header Server */
#define H_Server @"Server";

/** Header Content-Length */
#define H_ContentLength @"Content-Length";

/** Header Content-Type */
#define H_ContentType @"Content-Type";

/** Header Event */
#define H_Event @"Event";

/** Header Subject */
#define H_Subject @"Subject"; 


@interface Header : NSObject {

	/** The header type */
	NSString* name;
	/** The header string, without terminating CRLF */
	NSString* value;
	
}


@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* value;

/** Creates a new Header. */
-(id) initWithName:(NSString*)hname andValue:(NSString*)hvalue;

@end
