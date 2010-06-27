//
//  StatusLine.m
//  StringTest
//
//  Created by Marco Picone on 09/06/09.
//

#import "StatusLine.h"

@implementation StatusLine

@synthesize code;
@synthesize reason;


-(id)initWithCode:(int)codeValue 
		   andReason:(NSString*)reasonValue {
	
	if(self = [super init])
	{
		code = codeValue;
		[self setReason:reasonValue];
	}
	
	NSLog(@"StatusLine ---> Init with Code and Reason: %d - %@", code , reason);
	
	return self;
}

/** Whetever Object obj is equal to this Status Line **/
- (BOOL)isEqual:(id)obj;
{
	if ([obj isKindOfClass:[StatusLine class]]) {
		StatusLine *objStatus= (StatusLine *)obj;
		if( self.code == objStatus.code && [self.reason isEqualToString:objStatus.reason]) return YES;
		return NO;
	}
	return NO;
}

/** Dealloc Status Line **/
-(void)dealloc {
	
	NSLog(@"StatusLine ---> Dealloc where Code and Reason were: %d - %@", code , reason);
	
	[reason release];
	
	[super dealloc];
}

@end
