//
//  SipURL.m
//  StringTest
//
//  Created by marcopk on 09/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SipURL.h"
#import "Parser.h"


/** SIP Scheme **/
static NSString* SIP_SCHEME = @"sip";

/** SIPS Scheme **/
static NSString* SIPS_SCHEME = @"sips";

/** Transport Param Name **/
static NSString* PARAM_TRANSPORT = @"transport";

/** Maddr param name */
static NSString* PARAM_MADDR=@"maddr"; 

/** TTL param name */
static NSString* PARAM_TTL=@"ttl"; 

/** Lr param name */
static NSString* PARAM_LR=@"lr"; 

@implementation SipURL

@synthesize secure;
@synthesize url;

/** Create a new SipURL strating from url **/
-(id) initWithSipURL:(NSString*) urlValue{
	
	if(self = [super init])
	{	
		
		NSRange substr;
		NSMutableString *testString;
		
		//Set Secure Default Value
		secure = NO;
		
		//Check for SIP_SCHEME
		testString = [NSMutableString stringWithString:SIP_SCHEME];
		[testString appendString:@":"];
		
		substr = [urlValue rangeOfString:testString];
		
		if(substr.location != NSNotFound)
		{	
			//NSLog(@"SIP schema founded !");
			[self setUrl:urlValue];
		}
		else
		{	
			//Check for SIPS_SCHEME
			testString = [NSMutableString stringWithString:SIPS_SCHEME];
			[testString appendString:@":"];

			substr = [urlValue rangeOfString:testString];

			if(substr.location != NSNotFound)
			{
				//NSLog(@"SIPS schema founded !");
				
				[self setUrl:urlValue];
				secure = YES;
			}
			else
			{
				//NSLog(@"No schema founded !");
				
				testString = [NSMutableString stringWithString:SIP_SCHEME];
				[testString appendString:@":"];
				[testString appendString:urlValue];
				
				[self setUrl:testString];
			}
		}
		
		//Release TesString after use
		[testString retain];
		
		
	}
	
	//NSLog(@"StatusLine ---> Init with Url %@ and secure %@ ", url , (secure ? @"YES" : @"NO"));
	
	return self;
}

/* Create a New SipURL starting from hostname, username and portNumber*/
-(id) initWithUsername:(NSString*) userName hostName:(NSString*)hostName portNumber:(int)portNumber
{
	
	if(self = [super init])
	{	
		NSMutableString *testString = [NSMutableString stringWithString:[self getScheme]];
		[testString appendString:@":"];
		
		if(userName != nil)
			[testString appendString:userName];
		
		if(portNumber > 0){
			[testString appendString:@":"];
			[testString appendString:[NSMutableString stringWithFormat:@"%d",portNumber]];
			
			[self setUrl:testString];
		}
	}
	
	return self;
}


/* Create a New SipURL starting from hostname, username */
-(id) initWithUserName:(NSString*) userName hostName:(NSString*)hostName
{
	
	if(self = [super init])
	{	
		[self initWithUsername:userName hostName:hostName portNumber:-1];
	}
	
	return self;
}


/* Create a New SipURL starting from hostname, portNumber*/
-(id) initWithHostName:(NSString*) hostName portNumber:(int)portNumber;
{
	
	if(self = [super init])
	{	
		[self initWithUsername:nil hostName:hostName portNumber:portNumber];
	}
	
	return self;
}

/** Whetever Object obj is equal to this SIP URL **/
- (BOOL)isEqual:(id)obj;
{
	if ([obj isKindOfClass:[SipURL class]]) {
		SipURL *objSipURL= (SipURL *)obj;
		if( [self.url isEqualToString:objSipURL.url] ) return YES;
		return NO;
	}
	return NO;
}

/* Gets Scheme (sip or sips) */
-(NSString*) getScheme
{
	return ((secure)? SIPS_SCHEME : SIP_SCHEME);
}

/* Gets user name of SipUrl (Return nil if user name does note exist) */
-(NSString*) getUserName
{
	int begin = [[self getScheme] length] + 1;
	
	NSRange range = [url rangeOfString:@"@" options:NSCaseInsensitiveSearch range:NSMakeRange(begin, ([url length] - begin))];
	
	int end = range.location + range.length;
	
	if(end < 0)
		return nil;
	
	NSString *res = [url substringWithRange:NSMakeRange(begin, end - begin - 1)];
	
	return res;
}

/* Gets Host of SipUrl */
-(NSString*) getHost
{
	
	char host_terminators[3] = {':',';','?'};

	Parser *par= [[Parser alloc] initWithString:url];
	
	int begin = [par indexOf:'@'];
	
	if (begin<0) 
		begin = [[self getScheme] length]+1; // skip "sip:"
	else 
		begin++; // skip "@"
	
	[par setPos:begin];
	
	int end=[par indexOfCString:host_terminators withSize:sizeof(host_terminators)];
	
	if (end<0) 
		return [url substringFromIndex:begin];
	else 
		return [url substringWithRange:NSMakeRange(begin, end - begin)];
	 
}

/** Gets port of SipURL; returns -1 if port is not specidfied. */
-(int) getPort
{ 
	char port_terminators[2] = {';','?'};
	
	Parser *par = [[Parser alloc] initWithString:url andPosition:([[self getScheme] length] + 1)]; // skip "sip:"
	
	int begin=[par indexOf:':'];
	
	if (begin<0) 
		return -1;
	else
	{  
		begin++;
		[par setPos:begin];
		
		int end = [par indexOfCString:port_terminators withSize:sizeof(port_terminators)];
		
		if( end < 0) 
			return [[url substringFromIndex:begin] intValue];
		else 
			return [[url substringWithRange:NSMakeRange(begin,end-begin)] intValue] ;
	}
}

/** Gets boolean value to indicate if SipURL has user name. */
-(BOOL) hasUserName
{  
	return ( [self getUserName] != nil);
}

/** Gets boolean value to indicate if SipURL has port. */
-(BOOL) hasPort
{  
	return ([self getPort] >= 0);
}

/** Gets string representation of URL. */
-(NSString*) toString
{  
	return url;
}

/** Gets the string of all parameters. Returns a string of all parameters or null if no parameter is present. */
-(NSString*) getParameters 
{  
	if (url != nil)
	{  
		NSRange range = [url rangeOfString:@";"];
		
		if (range.location != NSNotFound)
			return [url substringFromIndex:(range.location+1)];
	}
	
	return nil;
}


/* Dealloc Method for SipURL */
-(void)dealloc{
	
	[url release];
	
	[super dealloc];
}

@end
