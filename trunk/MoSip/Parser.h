//
//  Parser.h
//  StringTest
//
//  Created by Marco Picone on 09/06/09.
//

#import <Cocoa/Cocoa.h>


@interface Parser : NSObject {
	
	/** The String that is being parsed **/ 
	NSString *str;
	
	/** The current pointer to the next char within the string **/
	int index;
}

@property (nonatomic,retain) NSString *str;
@property int index;

/** Creates the Parser from the String s and point to the beginning of the string.*/
-(id) initWithString: (NSString*) s;


/** Creates the Parser from the String s and point to the position i. */
-(id) initWithString: (NSString*) s andPosition:(int) i;

/** Gets the rest of the (unparsed) string. */
-(NSString *) getRemainingString;

/** Returns a new Parser of len chars starting from the current position. */
-(Parser*) subParser:(int) len;

/** Length of unparsed string. */
-(int) length;

/** Whether there are more chars to parse. */
-(BOOL) hasMore;

/** Gets the next char and go over */
-(char) getChar;

/** Gets the char at distance n WITHOUT going over */
-(char) charAt:(int) n;

/** Gets the next char WITHOUT going over */
-(char) nextChar;

/** Goes to position */
-(Parser*) setPos:(int) i;

/** Goes to the next occurence of char c */
-(Parser*) goTo:(char) c;

/** Goes to the next occurence of any char of array cc */
-(Parser*) goToArrayOfChar:(char*) cc withSize:(int)size ;

/** Goes to the next occurence of String s */
-(Parser*) goToString:(NSString*) s;


/** Goes to the next occurence of any string of array ss */
-(Parser*) goToStringInArray:(NSArray*) ss;

/** Goes to the next occurence of String s */
-(Parser*) goToIgnoreCase:(NSString*) s;

/** Goes to the next occurence of any string of array ss */
-(Parser*) goToIgnoreCaseInArray:(NSArray*) ss;

/** Goes to the begin of the new line */
-(Parser*) goToNextLine;

/** True if char <i>ch</i> is any char of array <i>ca</i> */
-(BOOL) isChar:(char)ch AnyOfArray:(char[])ca withSize:(int)size;

/** Up alpha */
-(BOOL) isUpAlpha:(char)c;

/** Low alpha */
-(BOOL) isLowAlpha:(char)c;

/** Alpha */
-(BOOL) isAlpha:(char)c;

/** Alphanum */
-(BOOL) isAlphanum:(char)c;

/** Digit */
-(BOOL) isDigit:(char)c;

/** Valid ASCII char */
-(BOOL) isChar:(char)c;

/** CR */   
-(BOOL) isCR:(char)c;

/** LF */
-(BOOL) isLF:(char)c;

/** CR or LF */
-(BOOL) isCRLF:(char)c;

/** HT */
-(BOOL) isHT:(char)c;

/** SP */
-(BOOL) isSP:(char)c;

/** SP or tab */
-(BOOL) isWSP:(char)c;

/** SP, tab, CR, or LF */
-(BOOL) isWSPCRLF:(char) c;

/** Compares two chars ignoring case */
-(int) compareIgnoreCase:(char) c1 andChar:(char) c2;

/************************ Indexes ************************/

/** Gets the index of the first occurence of char c */
-(int) indexOf:(char)c;

/** Gets the index of the first occurence of any char of array <i>cc</i> within string <i>str</i> starting form <i>begin</i>; return -1 if no occurence is found*/
-(int) indexOfCString:(char*) cc withSize:(int)stringSize;

/** Gets the index of the first occurence of String s */
-(int) indexOfString:(NSString*) s;

/** Gets the index of the first occurence of any string of array ss within string str; return -1 if no occurence is found. */
-(int) indexOfStringInArray:(NSArray*) ss;

/** Gets the index of the first occurence of String s ignoring case. */
-(int) indexOfIgnoreCase:(NSString*) s;

/** Gets the index of the first occurence of any string of array ss ignoring case. */
-(int) indexOfStringInArrayIgnoreCase:(NSArray*) ss;

/** Gets the begin of next line */
-(int) indexOfNextLine;

// ********************* Starts with *********************

/** Whether next chars equal to a specific String s. */
-(BOOL) startsWith:(NSString*) s;

/** Whether next chars equal to any string of array ss. */
-(BOOL) startsWithStringInArray:(NSArray*) ss;

/** Whether next chars equal to a specific String s ignoring case. */
-(BOOL) startsWithIgnoreCase:(NSString*) s;

/** Whether next chars equal to any string of array ss ignoring case. */
-(BOOL) startsWithIgnoreCaseStringInArray:(NSArray*) ss;


// ************************ Skips ************************

/** Skips one char */
-(Parser*) skipChar;

/** Skips N chars */
-(Parser*) skipN:(int) n;

/** Skips all spaces */
-(Parser*) skipWSP;

/** Skips return lines */
-(Parser*) skipCRLF;

/** Skips white spaces or return lines */
-(Parser*) skipWSPCRLF;

/** Skips any selected chars */
-(Parser*) skipChars:(char[]) cc withArraySize:(int)size;

/** Skips a continuous string of char and go to the next "blank" char */
-(Parser*) skipString;


// ************************ Gets ************************

/** Gets a continuous string of char and go to the next char */
-(NSString*) getString;

/** Gets a string of length len and move over. */
-(NSString*) getStringOfLenght:(int)len;

/** Gets a string of chars separated by any of chars of separators */
-(NSString*) getWord:(char[])separators withSize:(int)size;

/** Gets an integer and point to the next char. Returns 0 if the receiver doesn’t begin with a valid decimal text representation of a number. */
-(int) getInt;

/** Gets a double and point to the next char. Returns 0.0 if the receiver doesn’t begin with a valid text representation of a floating-point number */
-(double) getDouble;

/** Gets all chars until the end of the line (or the end of the parser) and go to the next line. */
-(NSString*) getLine;


//********************** Vectors/arrays **********************

/** Gets all integers separated by any char belonging to separators */
-(NSArray*) getIntArrayWithSeparators:(char[])separators withSize:(int)size;

/** Gets all integers */
-(NSArray*) getIntArray;

/** Gets all strings of chars separated by any char belonging to <i>separators</i> */
-(NSArray*) getWordArray:(char[]) separators withSize:(int)size;

/** Gets all strings */
-(NSArray*) getStringArray;


//********************** Quoted Strings **********************

/** Gets a string of chars separated by any of chars in separators, skipping any separator inside possible quoted texts. */
-(NSString*) getWordSkippingQuoted:(char[]) separators withSize:(int)size;

/** Gets the first quatable string, that is a normal string, or text in quotes. In the latter case, quotes are dropped. */
-(NSString*) getStringUnquoted;

/** Points to the next occurence of char c not in quotes. */
-(Parser*) goToSkippingQuoted:(char) c;

@end
