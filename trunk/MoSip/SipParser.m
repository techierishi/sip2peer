//
//  SipParser.m
//  MOSip
//
//  Created by marcopk on 27/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SipParser.h"
#import "SIPDelimiter.h"

@implementation SipParser 

/** Creates a new SipParser based on String <i>s</i> */ 
-(id) initWithString: (NSString*) s
{
	return [super initWithString:s];
}

/** Creates the Parser from the String s and point to the position i. */
-(id) initWithString: (NSString*) s andPosition:(int) i
{
	return [super initWithString:s andPosition:i];
}

/** Creates a new SipParser starting from the current position. */ 
-(id) initWithParser:(Parser*)parser
{
	return [super initWithString:[parser getString] andPosition:parser.index];
}

/** Checks whether a char is any MARK */
-(BOOL) isMark:(char) c
{  
	return [super isChar:c AnyOfArray:[[[SIPDelimiter alloc] init] MARK] withSize:MARK_SIZE];
}

/** Unreserved char; that is an alphanum or a mark*/
-(BOOL) isUnreserved:(char) c
{  
	return ([super isAlphanum:c] || [self isMark:c]);
}

/** Separator; differently form RFC2543, do not include '@' and ':', while include '\r' and '\n'*/
-(BOOL) isSeparator:(char) c
{  
	return [super isChar:c AnyOfArray:[[[SIPDelimiter alloc] init] SEPARATOR] withSize:MARK_SIZE];
}

/** Returns the first occurence of a separator or the end of the string*/
-(int) indexOfSeparator
{  
	int begin=index;
	
	while(begin <[str length] && ![self isSeparator:[str characterAtIndex:begin]]) 
		begin++;
	
	return begin;
}  

/** Index of the end of the header (EOH) */
-(int) indexOfEOH
{  
	//NSLog(@"---------- INDEX OF EOH --------");
	
	SipParser* par = [[SipParser alloc] initWithString:str andPosition:index];

	
	while(true)
	{  
		//NSLog(@"indexOfEOH Index: %d", par.index);
		
		[par goToArrayOfChar:[[[SIPDelimiter alloc] init] CRLF] withSize:CRLF_SIZE];
		
		//NSLog(@"indexOfEOH Index CRLF: %d", par.index);
		
		if(![par hasMore])
			return [str length];
		
		int end = par.index;	
		
		[par goToNextLine];
		
		//NSLog(@"indexOfEOH Index: %d", par.index);
		//NSLog(@"indexOfEOH Next Char: %c",[par nextChar]);
		
		if(![par hasMore] || ![self isWSP:[par nextChar]])
		{
			//NSLog(@"indexOfEOH returning end: %d", end);
			return end;
		}
	}

	//NSLog(@"-------------------------------");
}

/** Returns the begin of next header */
-(int) indexOfNextHeader
{  
	SipParser* par = [[SipParser alloc] initWithString:str andPosition:index];
	[par goToNextHeader];
	return par.index;
}

/** Tests if this string starts with the specified prefix beginning at the specified index. */
-(BOOL)string:(NSString*)testStr startWith:(NSString*)startStr fromIndex:(int)idx
{
	int begin=idx;
	
	NSRange range = [testStr rangeOfString:startStr options:NSLiteralSearch range:NSMakeRange(begin, ( [str length] - begin))];
	
	if(range.location != NSNotFound && range.location == begin)
		return YES;
	else
		return NO;

}

/** Returns the index of the begin of the first occurence of the Header <i>hname</i> */
-(int) indexOfHeader:(NSString*) hname
{  
    int begin=index;
	
	NSRange range = [str rangeOfString:hname options:NSLiteralSearch range:NSMakeRange(begin, ( [str length] - begin))];
	
	if(range.location != NSNotFound && range.location == begin)
		return index;
	
	//Creating target array
	NSMutableString* sN = [NSMutableString stringWithString:@"\n"];
	NSMutableString* sR = [NSMutableString stringWithString:@"\r"];
	[sN appendString:hname];
	[sR appendString:hname];
	
	NSArray* target = [[NSArray alloc] initWithObjects:sN,sR,nil];
	
	SipParser* par = [[SipParser alloc] initWithString:str andPosition:index];
	
	[par goToIgnoreCaseInArray:target];
	
	if([par hasMore]) 
		[par skipChar];
	
	return par.index;
}

/** Goes to the begin of next header */
-(SipParser*) goToNextHeader
{  
	index=[self indexOfEOH];
	[self goToNextHeader];
	return self;
}

/** Go to the end of the last header.
 * The final empty line delimiter is not considered as header */
-(SipParser*) goToEndOfLastHeader
{  
	
	NSArray* delimiters = [[NSArray alloc] initWithObjects:@"\r\n\r\n",@"\n\n",nil];
	
	[self goToStringInArray:delimiters];
	
	if (![self hasMore]) // no double newline found
	{  
		if([self string:str startWith:@"\r\n" fromIndex:([str length]-2)])
			index = [str length] -2;
		else if([str characterAtIndex:([str length]-1)] == '\n')
			index = [str length] -1;
		else 
			index = [str length];
	}
	
	return self;
}

/** Go to the begin (first char of) Message Body */
-(SipParser*) goToBody
{  
	[self goToEndOfLastHeader];
	
	[[self goTo:'\n'] skipChar];
	[[self goTo:'\n'] skipChar];
	
	return self;
}

/** Returns the first header and goes to the next line. */
-(Header*) getHeader    
{  
	//NSLog(@"Get Header Called ...");
	
	if (![self hasMore]) 
		return nil;
	
	int begin = self.index;
	
	int end = [self indexOfEOH];
	
	//NSLog(@"Begin: %d End: %d",begin,end);
	
	NSString* header_str = [self getStringOfLenght:(end - begin)];
	
	//NSLog(@"Header STR: %@",header_str);
	
	[self goToNextLine];
	
	NSRange range = [header_str rangeOfString:@":"];
	
	if(range.location != NSNotFound)
	{
		int colon = range.location;
		
		if (colon<0) 
			return nil;
	
		NSString* hname = [[header_str substringFromIndex:0] substringToIndex:colon];
		hname = [hname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
		NSString* hvalue = [[header_str substringFromIndex:(++colon)] substringToIndex:([header_str length]-(++colon))];
		hvalue = [hvalue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		
		return [[Header alloc] initWithName:hname andValue:hvalue];       
	}
	else 
		return nil;
}

/** Returns the first occurence of Header hname. */
-(Header*) getHeader:(NSString*)hname    
{  
	SipParser* par = [[SipParser alloc] initWithString:str andPosition:[self indexOfHeader:hname]];
	
	if (![par hasMore])
	{
		[par release];
		return nil;
	}
	
	[par skipN:[hname length]];
	
	int begin = [par indexOfString:@":"]+1;
	
	int end = [par indexOfEOH];
	
	if (begin>end) 
	{
		[par release];
		return nil;
	}
	
	//NSLog(@"Begin: %d End:%d ", begin,end);
	
	NSString* hvalue = [str substringWithRange:NSMakeRange(begin,end-begin)];
	hvalue = [hvalue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	index=end;
	
	[par release];
	
	return [[Header alloc] initWithName:hname andValue:hvalue];  
}

//************************ first-line ************************

/** Returns the request-line. */
-(RequestLine*) getRequestLine    
{  
	//NSLog(@"---------- GET REQUEST LINE --------");
	
	NSString* method = [self getString];
	
	//NSLog(@"Parser Index: %d",[self index]);
	
	[self skipWSP];

	//NSLog(@"Parser Index: %d",[self index]);
	
	SipParser* parser = [[SipParser alloc] initWithString:[self getStringOfLenght:([self indexOfEOH] - [self index])]];
	
	SipURL* url = [parser getSipURL];
	
	[self goToNextLine];
		
	//NSLog(@"---------- GET REQUEST LINE --------");
	
	return [[RequestLine alloc] initWithRequest:method andSipUrl:url];
}

/** Returns the status-line or null (if it doesn't start with "SIP/"). */
-(StatusLine*) getStatusLine
{  
	NSString* version = [self getStringOfLenght:4];     
	
	if (![version isEqualToString:@"SIP/"]) 
	{  
		index=[str length]; 
		return nil;  
	} 
	
	[[self skipString] skipWSP];
	
	int code=[self getInt];
	
	NSString* reason = [self getStringOfLenght:([self indexOfEOH] - self.index)];
	reason = [reason stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	[self goToNextLine];
	
	return [[StatusLine alloc] initWithCode:code andReason:reason];
}


//*************************** URIs ***************************


/** Returns the first URL.
 * If no URL is found, it returns <b>null</b> */
-(SipURL*) getSipURL
{  
	
	//NSLog(@"---------- GET SIP URL --------");
	
	NSArray* appArray = [[NSArray alloc] initWithObjects:@"sip:",@"sips:",nil];
	
	[self goToStringInArray:appArray];
	
	if (![self hasMore]) 
		return nil;
	
	int begin=[self index];
	
	int end = [self indexOfCString:[[[SIPDelimiter alloc] init] URI_SEPARATORS] withSize:URI_SEPARATORS_SIZE];
	
	if (end<0) 
		end=[str length];
	
	NSString* url = [self getStringOfLenght:(end - begin)];
		
	if ([self hasMore]) 
		[self skipChar];
	
	//NSLog(@"---------- GET SIP URL --------");
	
	return [[SipURL alloc] initWithSipURL:url];
}

/** Returns the first NameAddress in the string <i>str</i>.
 * If no NameAddress is found, it returns <b>null</b>.  
 * A NameAddress is a string of the form of:
 * <BR><BLOCKQUOTE><PRE>&nbsp&nbsp "user's name" &lt;sip url&gt; </PRE></BLOCKQUOTE> */
-(NameAddress*) getNameAddress
{  
	
	NSString* text=nil;
	
	SipURL* url=nil;
	
	int begin=[self index];
	
	NSRange range = [str rangeOfString:@"<sip:"];
	
	if(range.location == NSNotFound)
		return nil;
	
	int begin_url=range.location;
	
	NSLog(@"DEBUG: inside parseNameAddress(): str=%@",[self getRemainingString]);
	NSLog(@"DEBUG: inside parseNameAddress(): index=%d",begin_url);
	
	if (begin_url<0) 
	{  
		url = [self getSipURL];
		
		if (url==nil){  
			[self setPos:begin];
			url=[[SipURL alloc] initWithSipURL:[self getString]];
		}
		
		return [[NameAddress alloc] initWithSipUrl:url];
		
	}
	else
	{  
		text = [self getStringOfLenght:(begin_url-begin)];
		text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

		url=[self getSipURL];
		
		
		if ([text length] > 0 && [text characterAtIndex:0]=='\"' && [text characterAtIndex:([text length]-1)]=='\"')
		{  
			[text substringWithRange:NSMakeRange(1, [text length]-2)];
		}
		
		if ([text length]==0) 
			return [[NameAddress alloc] initWithSipUrl:url];
		else 
			return [[NameAddress alloc] initWithName:text andSipUrl:url]; 
	}
	
	return nil;
}


@end
