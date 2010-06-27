//
//  StatusLine.h
//  StringTest
//
//  Created by Marco Picone on 09/06/09.
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
