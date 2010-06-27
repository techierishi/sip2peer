//
//  SipParser.m
//  MOSip
//
//  Created by Marco Picone on 27/04/10.
//  Copyright 2010 Marco Picone ( http://dsg.ce.unipr.it ) - University of Parma - Italy. 
//  All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "Parser.h"
#import "Header.h"
#import "RequestLine.h"
#import "StatusLine.h"
#import "NameAddress.h"

@interface SipParser : Parser {
}


/** Creates a new SipParser based on String <i>s</i> */ 
-(id) initWithString: (NSString*) s;

/** Creates a new SipParser from the String s and point to the position i. */
-(id) initWithString: (NSString*) s andPosition:(int) i;

/** Creates a new SipParser starting from the current position. */ 
-(id) initWithParser:(Parser*)parser;

/** Checks whether a char is any MARK */
-(BOOL) isMark:(char) c;

/** Unreserved char; that is an alphanum or a mark*/
-(BOOL) isUnreserved:(char) c;

/** Separator; differently form RFC2543, do not include '@' and ':', while include '\r' and '\n'*/
-(BOOL) isSeparator:(char) c;

/** Returns the first occurence of a separator or the end of the string*/
-(int) indexOfSeparator;

/** Index of the end of the header (EOH) */
-(int) indexOfEOH;

/** Returns the begin of next header */
-(int) indexOfNextHeader;

/** Goes to the begin of next header */
-(SipParser*) goToNextHeader;

/** Returns the index of the begin of the first occurence of the Header <i>hname</i> */
-(int) indexOfHeader:(NSString*) hname;

/** Tests if this string starts with the specified prefix beginning at the specified index. */
-(BOOL)string:(NSString*)testStr startWith:(NSString*)startStr fromIndex:(int)idx;

/** Go to the begin (first char of) Message Body */
-(SipParser*) goToBody;

/** Returns the first header and goes to the next line. */
-(Header*) getHeader ;

/** Returns the first occurence of Header <i>hname</i>. */
-(Header*) getHeader:(NSString*)hname;   

/** Returns the request-line. */
-(RequestLine*) getRequestLine;

/** Returns the first URL.
 * If no URL is found, it returns <b>null</b> */
-(SipURL*) getSipURL;


/** Returns the status-line or null (if it doesn't start with "SIP/"). */
-(StatusLine*) getStatusLine;

/** Returns the first NameAddress in the string <i>str</i>.
 * If no NameAddress is found, it returns <b>null</b>.  
 * A NameAddress is a string of the form of:
 * <BR><BLOCKQUOTE><PRE>&nbsp&nbsp "user's name" &lt;sip url&gt; </PRE></BLOCKQUOTE> */
-(NameAddress*) getNameAddress;

@end
