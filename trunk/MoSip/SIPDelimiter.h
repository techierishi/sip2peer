//
//  SIPDelimiter.h
//  MOSip
//
//  Created by Marco Picone on 19/06/10.
//  Copyright 2010 Marco Picone ( http://dsg.ce.unipr.it ) - University of Parma - Italy. 
//  All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define CRLF_SIZE 2
#define WSP_SIZE 2
#define SPACE_SIZE 2
#define WSPCRLF_SIZE 4
#define MARK_SIZE 8
#define SEPARATOR_SIZE 19
#define URI_SEPARATORS_SIZE 4
#define URI_SCHEMES_SIZE 2
#define PARAM_SEPARATORS_SIZE 6

@interface SIPDelimiter : NSObject {

	/** Characters space (SP) and tab (HT). */
	char *WSP;
	
	/** The same as WSP (for legacy) */
	char *SPACE;
	
	/** Characters CR and LF.*/
	char *CRLF;
	
	/** Characters white-space, tab, CR, and LF. */
	char *WSPCRLF;
	
	/** MARK char[], composed by: '-' , '_' , '.' , '!' , '~' , '*' , '\'' , '|' */
	char *MARK;//={'-','_','.','!','~','*','\'','|'};
	
	/** SEPARATOR char[], composed by: ' ','\t','\r','\n','(',')','<','>',',',';','\\','"','/','[',']','?','=','{','}' */
	char *SEPARATOR;//={' ','\t','\r','\n','(',')','<','>',',',';','\\','"','/','[',']','?','=','{','}'};
	
	char *URI_SEPARATORS;//={' ','>','\n','\r'};
	
	NSString* *URI_SCHEMES;//={@"sip:",@"sips:"};
	
	/** PARAM SEPARATOR char[], composed by: ' ', '=', ';', ',', '\n', '\r' */  
	char *PARAM_SEPARATORS;//={' ', '=', ';', ',', '\n', '\r'};	
	
	NSString *SIP_VERSION; 
	NSString *INVITE;
	NSString *CANCEL;
	NSString *ACK;
	NSString *BYE;
	NSString *REGISTER;
	NSString *SUBSCRIBE;
	NSString *NOTIFY;
	NSString *MESSAGE;
	
}

@property char* WSP;
@property char* SPACE;
@property char* CRLF;
@property char* WSPCRLF;
@property char* MARK;
@property char* SEPARATOR;
@property char* URI_SEPARATORS;
@property NSString* *URI_SCHEMES;
@property char* PARAM_SEPARATORS;
@property (nonatomic, retain) NSString *SIP_VERSION;
@property (nonatomic, retain) NSString *INVITE;
@property (nonatomic, retain) NSString *CANCEL;
@property (nonatomic, retain) NSString *ACK;
@property (nonatomic, retain) NSString *BYE;
@property (nonatomic, retain) NSString *REGISTER;
@property (nonatomic, retain) NSString *SUBSCRIBE;
@property (nonatomic, retain) NSString *NOTIFY;
@property (nonatomic, retain) NSString *MESSAGE;

@end
