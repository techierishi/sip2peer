//
//  Parser.m
//  StringTest
//
//  Created by Marco Picone on 09/06/09.
//

#import "Parser.h"
#import "SIPDelimiter.h"


@implementation Parser
 
@synthesize str;
@synthesize index;

/** Creates the Parser from the String <i>s</i> and point to the beginning of the string.*/
-(id) initWithString: (NSString*) s
{
	if(self = [super init])
	{	
		
		//NSLog(@"Initing Parser: %@",s);
		
		if(s != nil)
		{
			[self setStr:s];
			index = 0;
		}
		else	
		{	
			NSException *exception = [NSException exceptionWithName:@"ParserException" reason:@"Tried to costruct a new Parser with a null String"  userInfo:nil];
			@throw exception;		
		}
		
	}
	return self;
}

/** Creates the Parser from the String s and point to the position i. */
-(id) initWithString: (NSString*) s andPosition:(int) i
{
	if(self = [super init])
	{	
		if(s != nil)
		{
			[self setStr:s];
			index = i;
		}
		else	
		{	
			NSException *exception = [NSException exceptionWithName:@"ParserException" reason:@"Tried to costruct a new Parser with a null String"  userInfo:nil];
			@throw exception;		
		}
	}
	return self;
}

/** Gets the rest of the (unparsed) string. */
-(NSString *) getRemainingString
{ 
	return [str substringWithRange:NSMakeRange(index, [str length] - index )];
}

/** Returns a new Parser of len chars starting from the current position. */
-(Parser*) subParser:(int) len
{  
	return [[Parser alloc] initWithString:[str substringWithRange:NSMakeRange(index, index + len)]];  
}   

/** Length of unparsed string. */
-(int) length
{ 
	return ([str length] - index); 
}

/** Whether there are more chars to parse. */
-(BOOL) hasMore
{ 
	return ([self length] > 0); 
}

/** Gets the next char and go over */
-(char) getChar
{ 
	return [str characterAtIndex:(index+1)]; 
}

/** Gets the char at distance n WITHOUT going over */
-(char) charAt:(int) n
{ 
	return [str characterAtIndex:(index+n)]; 
} 

/** Gets the next char WITHOUT going over */
-(char) nextChar
{
	return [self charAt:0];
}


/** Goes to position */
-(Parser*) setPos:(int) i
{
	self.index = i;
	return self;
}

/** Goes to the next occurence of char c */
-(Parser*) goTo:(char) c 
{ 	
	NSString *testString = [NSString stringWithFormat:@"%c" , c];
	NSRange range = [str rangeOfString:testString options:NSLiteralSearch range:NSMakeRange(self.index, [str length] - index -1)];
	
	if(range.location != NSNotFound)
		self.index = range.location;
	else		
		self.index = [str length];

	return self;
}

/** Goes to the next occurence of any char of array cc */
-(Parser*) goToArrayOfChar:(char*) cc withSize:(int)size 
{ 
	//NSLog(@"---------- GO TO ARRAY OF SIZE -------");

	
	index=[self indexOfCString:cc withSize:size]; 
	
	if (index<0) 
		index=[str length]; 
	
	//NSLog(@"---------- GO TO ARRAY OF SIZE -------");
	
	return self; 
}

/** Goes to the next occurence of String s */
-(Parser*) goToString:(NSString*) s 
{ 

	NSRange range = [str rangeOfString:s options:NSLiteralSearch range:NSMakeRange(index, [str length] - index)];
	
	if(range.location != NSNotFound)
		index = range.location;	
	else
		index=[str length]; 

	return self; 
}

/** Goes to the next occurence of any string of array ss */
-(Parser*) goToStringInArray:(NSArray*) ss 
{ 
	index = [self indexOfStringInArray:ss];
	
	if( index < 0) 
		index = [str length]; 
	
	return self; 
}

/** Goes to the next occurence of String s */
-(Parser*) goToIgnoreCase:(NSString*) s
{ 
	index=[self indexOfIgnoreCase:s]; 
	
	if (index < 0) 
		index=[str length]; 
	
	return self; 
}

/** Goes to the next occurence of any string of array ss */
-(Parser*) goToIgnoreCaseInArray:(NSArray*) ss
{ 
	index = [self indexOfStringInArrayIgnoreCase:ss];
	
	if (index<0) 
		index=[str length]; 
	
	return self; 
}

/** Goes to the begin of the new line */
-(Parser*) goToNextLine
{  
	while ( index < [str length] && ! [self isCRLF:[str characterAtIndex:index]] ) 
		index++;
	
	// skip the end of the line (i.e. '\r' OR '\n' OR '\r\n')
	if( index < [str length] ) 
	{ 
		
		NSRange range = [str rangeOfString:@"\r\n" options:NSLiteralSearch range:NSMakeRange(index, ( [str length] - index))];		
		
		if(range.location != NSNotFound && range.location == index)
			index+=2; 
		else 
			index++; 
	}   
	
	return self;
}

/** True if char <i>ch</i> is any char of array <i>ca</i> */
-(BOOL) isChar:(char)ch AnyOfArray:(char[])ca withSize:(int)size
{  
	BOOL found=NO;
	
	for (int i=0; i < size; i++) 
	{
		if (ca[i]==ch) 
		{ 
			found=YES; 
			break; 
		}
	}

	return found;
}


/** Up alpha */
-(BOOL) isUpAlpha:(char)c { return (c>='A' && c<='Z'); }

/** Low alpha */
-(BOOL) isLowAlpha:(char)c { return (c>='a' && c<='z'); }

/** Alpha */
-(BOOL) isAlpha:(char)c { return ([self isUpAlpha:c] || [self isLowAlpha:c]); }

/** Alphanum */
-(BOOL) isAlphanum:(char)c { return ([self isAlpha:c] || [self isDigit:c]); }

/** Digit */
-(BOOL) isDigit:(char)c { return (c>='0' && c<='9'); }

/** Valid ASCII char */
-(BOOL) isChar:(char)c { return (c >' ' && c <= '~'); }

/** CR */   
-(BOOL) isCR:(char)c { return (c=='\r'); }

/** LF */
-(BOOL) isLF:(char)c { return (c=='\n'); }

/** CR or LF */
//-(BOOL) isCRLF:(char)c { return [self isChar:c AnyOfArray:CRLF]; }
-(BOOL) isCRLF:(char)c 
{ 
	//SIPDelimiter *delimiter = [[SIPDelimiter alloc] init];
	return [self isChar:c AnyOfArray:[[[SIPDelimiter alloc] init] CRLF] withSize:CRLF_SIZE]; 
}

/** HT */
-(BOOL) isHT:(char)c { return (c=='\t'); }

/** SP */
-(BOOL) isSP:(char)c { return (c==' '); }

/** SP or tab */
//-(BOOL) isWSP:(char)c { return [self isChar:c AnyOfArray:WSP]; }
-(BOOL) isWSP:(char)c 
{ 
	//SIPDelimiter *delimiter = [[SIPDelimiter alloc] init];
	return [self isChar:c AnyOfArray:[[[SIPDelimiter alloc] init] WSP] withSize:WSP_SIZE]; 
}

/** SP, tab, CR, or LF */
//-(BOOL) isWSPCRLF:(char) c { return [self isChar:c AnyOfArray:WSPCRLF]; }
-(BOOL) isWSPCRLF:(char) c 
{ 
	//SIPDelimiter *delimiter = [[SIPDelimiter alloc] init];
	return [self isChar:c AnyOfArray:[[[SIPDelimiter alloc] init] WSPCRLF] withSize:WSPCRLF_SIZE]; 
}


/** Compares two chars ignoring case */
-(int) compareIgnoreCase:(char) c1 andChar:(char) c2
{  
	if ([self isUpAlpha:c1]) c1+=32;
	
	if ([self isUpAlpha:c2]) c2+=32;
	
	return c1-c2;
}

/************************ Indexes ************************/

/** Gets the index of the first occurence of char c */
-(int) indexOf:(char)c
{
	NSString *testString = [NSString stringWithFormat:@"%c" , c];
	NSRange range = [str rangeOfString:testString options:NSLiteralSearch range:NSMakeRange(self.index, [str length] - index)];
	
	if(range.location != NSNotFound)
		return range.location;
	
	return -1;
}

/** Gets the index of the first occurence of any char of array cc within string str starting form begin; return -1 if no occurence is found */
-(int) indexOfCString:(char*) cc withSize:(int)stringSize;
{  
	BOOL found=NO;
	int begin=index;
	
	//NSString *testString = [[NSString alloc] initWithCString:cc];
	
	//NSLog(@"Parser INDEX: %d", [self index]);
    //NSLog(@"Parser STR: %@", [self str]);
	//NSLog(@"---------- INDEX OF C STRING -------");
	//NSLog(@"Array Size: %d", stringSize);
	
	
	while( begin < [str length] && !found)
	{  
		for (int i=0; i < stringSize; i++)
		{	
//			NSLog(@"####################################################");
//			NSLog(@"indexOfCString --> %c",[str characterAtIndex:begin]);
//			NSLog(@"indexOfCString --> %c",cc[i]);
			
			if ([str characterAtIndex:begin] == cc[i]) 
			{ 
				//NSLog(@"indexOdCString FOUNDED %d",begin);
				found=YES; 
				break; 
			}
			
//			NSLog(@"####################################################");
		}
		
		begin++;
	}
	
	//NSLog(@"---------- INDEX OF C STRING -------");

	
	return (found)? (begin-1) : -1;
}

/** Gets the index of the first occurence of String s starting from index */
-(int) indexOfString:(NSString*) s
{  
	NSString* appStr = [str substringWithRange:NSMakeRange(index, str.length - index)];

	return (index+[appStr rangeOfString:s].location);
}

/** Gets the index of the first occurence of any string of array ss within string str; return -1 if no occurence is found. */
-(int) indexOfStringInArray:(NSArray*) ss
{ 
	BOOL found=NO;
	int begin=index;

	while (begin < [str length] && !found)
	{  
		for (int i=0; i < [ss count]; i++)
		{	
			NSRange range = [str rangeOfString:[ss objectAtIndex:i] options:NSLiteralSearch range:NSMakeRange(begin, ( [str length] - begin))];
			
			//NSLog(@"Word: %@ Location %d ; Lenght %d ; Begin %d; Index %d",[ss objectAtIndex:i],range.location,range.length,begin,index);
			
			if(range.location != NSNotFound && range.location == begin)
			{ 
				found=YES; 
				break; 
			}
		}
		begin++;
	}
	return (found)? (begin-1) : -1;
}

/** Gets the index of the first occurence of String s ignoring case. */
-(int) indexOfIgnoreCase:(NSString*) s
{  
	Parser *par = [[Parser alloc] initWithString:str andPosition:index];
	
	while([par hasMore])
	{
		if([par startsWithIgnoreCase:s]) 
			return [par index];
		else 
			[par skipChar];
	} 
	
	[par retain];
	
	return -1;
}

/** Gets the index of the first occurence of any string of array ss ignoring case. */
-(int) indexOfStringInArrayIgnoreCase:(NSArray*) ss
{  
	Parser *par = [[Parser alloc] initWithString:str andPosition:index];
	
	while([par hasMore])
	{  
		if([par startsWithIgnoreCaseStringInArray:ss]) 
			return [par index];
		else 
			[par skipChar];
	} 
	
	[par retain];
	
	return -1;
}

/** Gets the begin of next line */
-(int) indexOfNextLine
{  
	
	Parser *par = [[Parser alloc] initWithString:str andPosition:index];
	
	[par goToNextLine];
	
	int i = [par index];
	
	[par retain];
	
	return ( i < [str length] ) ? i : -1;
	
}


// ********************* Starts with *********************

/** Whether next chars equal to a specific String s. */
-(BOOL) startsWith:(NSString*) s
{  
	NSRange range = [str rangeOfString:s options:NSLiteralSearch range:NSMakeRange(index, ( [str length] - index))];
	
	if(range.location != NSNotFound && range.location == index)
		return YES;
	else
		return NO;
}


/** Whether next chars equal to any string of array ss. */
-(BOOL) startsWithStringInArray:(NSArray*) ss
{  
	for (int i=0; i<[ss count]; i++)
	{
		NSRange range = [str rangeOfString:[ss objectAtIndex:i] options:NSLiteralSearch range:NSMakeRange(index, ( [str length] - index))];
		
		if(range.location != NSNotFound && range.location == index)			
			return YES;
	}
	
	return NO;
}

/** Whether next chars equal to a specific String s ignoring case. */
-(BOOL) startsWithIgnoreCase:(NSString*) s
{  
	NSRange range = [str rangeOfString:s options:NSCaseInsensitiveSearch range:NSMakeRange(index, ( [str length] - index))];
	
	if(range.location != NSNotFound && range.location == index)
		return YES;
	else
		return NO;
}

/** Whether next chars equal to any string of array ss ignoring case. */
-(BOOL) startsWithIgnoreCaseStringInArray:(NSArray*) ss
{  
	for (int i=0; i<[ss count]; i++)
	{
		NSRange range = [str rangeOfString:[ss objectAtIndex:i] options:NSCaseInsensitiveSearch range:NSMakeRange(index, ( [str length] - index))];
		
		if(range.location != NSNotFound && range.location == index)			
			return YES;
	}
	
	return NO;
}

// ************************ Skips ************************

/** Skips one char */
-(Parser*) skipChar
{  
	if(index < [str length]) 
		index++;
	
	return self;
}

/** Skips N chars */
-(Parser*) skipN:(int) n
{  
	index+=n;
	
	if(index > [str length]) 
		index=[str length];
	
	return self;
}

/** Skips all spaces */
-(Parser*) skipWSP
{  
	while( index < [str length] && [self isSP:[str characterAtIndex:index]] ) 
		index++;
	
	return self;
}

/** Skips return lines */
-(Parser*) skipCRLF
{  
	while( index < [str length] && [self isCRLF:[str characterAtIndex:index]] ) 
		index++;
	
	return self;
}

/** Skips white spaces or return lines */
-(Parser*) skipWSPCRLF
{  
	while( index < [str length] && [self isWSPCRLF:[str characterAtIndex:index]] ) 
		index++;
	
	return self;
}

/** Skips any selected chars */
-(Parser*) skipChars:(char[]) cc withArraySize:(int)size
{  
	while( index < [str length] && [self isChar:[self nextChar] AnyOfArray:cc withSize:size]) 
		index++;
	
	return self;
}

/** Skips a continuous string of char and go to the next "blank" char */
-(Parser*) skipString
{  
	[self getString];
	return self;
}

// ************************ Gets ************************

/** Gets a continuous string of char and go to the next char */
-(NSString*) getString
{  
	
	int begin=index;
	
	while( begin < [str length] && ![self isChar:[str characterAtIndex:begin]] ) 
		begin++;
	
	int end=begin;
	
	while (end < [str length] && [self isChar:[str characterAtIndex:end]]) 
		end++;
	
	index=end;
	
	return [str substringWithRange:NSMakeRange(begin,end-begin)];
}

/** Gets a string of length len and move over. */
-(NSString*) getStringOfLenght:(int)len
{  
	int start=index;
	index=start+len;
	
	//NSLog(@"Start:%d, Index:%d NSMAKERANGE:(%d,%d) STR LEN:%d",start,index,start,(index-start),[str length]);
	
	if(index > [str length])
	{
		//NSLog(@"PARSER ---> getStringOfLenght index > [str lenght] !");
		index = [str length];
	}
	
	return [str substringWithRange:NSMakeRange(start,index-start)];
}

/** Gets a string of chars separated by any of chars of separators */
-(NSString*) getWord:(char[])separators withSize:(int)size
{  
	int begin=index;
	
	while (begin< [str length] && [self isChar:[str characterAtIndex:begin] AnyOfArray:separators withSize:size]) 
		begin++;
	
	int end=begin;
	
	while(end < [str length] && ![self isChar:[str characterAtIndex:end] AnyOfArray:separators withSize:size]) 
		end++;
	
	index = end;

	
	return [str substringWithRange:NSMakeRange(begin,end-begin)];
}

/** Gets an integer and point to the next char. Returns 0 if the receiver doesn’t begin with a valid decimal text representation of a number.*/
-(int) getInt
{  
	return [[self getString] integerValue];
}

/** Gets a double and point to the next char. Returns 0.0 if the receiver doesn’t begin with a valid text representation of a floating-point number */
-(double) getDouble
{  
	return [[self getString] doubleValue];
}

/** Gets all chars until the end of the line (or the end of the parser) and go to the next line. */
-(NSString*) getLine
{  
	int end = index;
	
	while (end < [str length] && ![self isCRLF:[str characterAtIndex:end]]) 
	{	
		end++;
	}
	
	NSString *line = [str substringWithRange:NSMakeRange(index,end-index)];

	index = end;
	
	// skip the end of the line (i.e. '\r' OR '\n' OR '\r\n')
	if (index < [str length] )
	{  
		NSRange range = [str rangeOfString:@"\r\n" options:NSLiteralSearch range:NSMakeRange(index, ( [str length] - index))];
		
		if(range.location != NSNotFound && range.location == index)
			index+=2;
		else 
			index++;
	}  
	
	return line;
}

//********************** Vectors/arrays **********************

/** Gets all integers separated by any char belonging to separators */
-(NSArray*) getIntArrayWithSeparators:(char[])separators withSize:(int)size
{  
	NSMutableArray *list = [[NSMutableArray alloc] init];
	
	do { 
		//NSLog(@"%d",[[self getWord:separators] integerValue]);
		[list addObject:[NSNumber numberWithInteger:[[self getWord:separators withSize:size] integerValue]]];
	} while ([self hasMore]);
	
	return list;
}

/** Gets all integers */
-(NSArray*) getIntArray
{  
	NSMutableArray *list = [[NSMutableArray alloc] init];
	
	do { 
		[list addObject:[NSNumber numberWithInteger:[[self getString] integerValue]]]; 
	} while([self hasMore]);
	
	return list;
}

/** Gets all strings of chars separated by any char belonging to <i>separators</i> */
-(NSArray*) getWordArray:(char[])separators withSize:(int)size
{  
	NSMutableArray *list = [[NSMutableArray alloc] init];
	
	do {
		[list addObject:[self getWord:separators withSize:size]];
	} while ([self hasMore]);
	
	return list;
}

/** Gets all strings */
-(NSArray*) getStringArray
{  
	NSMutableArray *list = [[NSMutableArray alloc] init];
	
	do { 
		[list addObject:[self getString]];
	} while ([self hasMore]);

	
	return list;
}

//********************** Quoted Strings **********************

/** Gets a string of chars separated by any of chars in separators, skipping any separator inside possible quoted texts. */
-(NSString*) getWordSkippingQuoted:(char[])separators withSize:(int)size
{  
	int begin=index;
	
	while( begin < [str length] && [self isChar:[str characterAtIndex:begin] AnyOfArray:separators withSize:size]) 
		begin++;
	
	BOOL inside_quoted_string=NO;
	
	int end=begin;
	
	while ( end < [str length] && (![self isChar:[str characterAtIndex:end] AnyOfArray:separators withSize:size] || inside_quoted_string))
	{  
		if ([str characterAtIndex:end]=='"') 
			inside_quoted_string=!inside_quoted_string;
		end++;
	}
	
	index=end;
	
	return [str substringWithRange:NSMakeRange(begin,end-begin)];
}

/** Gets the first quatable string, that is a normal string, or text in quotes. In the latter case, quotes are dropped. */
-(NSString*) getStringUnquoted
{  
	// jump possible "non-chars"
	while ( index < [str length] && ![self isChar:[str characterAtIndex:index]]) 
		index++;
	
	if (index == [str length]) 
		return [str substringWithRange:NSMakeRange(index,index-index)];;
	
	// check whether is a quoted string
	int next_qmark;
	
	NSRange range = [str rangeOfString:@"\"" options:NSLiteralSearch range:NSMakeRange(index + 1 , ( [str length] - index - 1))];
	
	if ([str characterAtIndex:index] == '"' && range.location != NSNotFound) 
	{  
		next_qmark = range.location;
		
		// is quoted text
		NSString *qtext=[str substringWithRange:NSMakeRange(index+1,next_qmark - index -1)];
		
		index = next_qmark + 1;
		
		return qtext;
	}
	else
	{  
		// is not a quoted text
		return [self getString];
	}
} 

/** Points to the next occurence of char c not in quotes. */
-(Parser*) goToSkippingQuoted:(char) c
{  
	BOOL inside_quotes=NO;
	
	//try
	//{  
		while (index<[str length] && (!([self nextChar]==c) || inside_quotes))
		{  
			if ([self nextChar]=='"') inside_quotes=!inside_quotes;
				index++;
		}
	//}
	//catch (RuntimeException e)
	//{  
		NSLog(@"len= %d",[str length]);
		NSLog(@"index= %d",index);
	//	throw e;
	//}
	
	return self;
}


// *********************** Dealloc ***********************

/* Dealloc Method for Parser */
-(void)dealloc{
	[str release];
	[super dealloc];
}

@end
