//
//  SIPDelimiter.m
//  MOSip
//
//  Created by Marco Picone on 19/06/10.
//  Copyright 2010 Marco Picone ( http://dsg.ce.unipr.it ) - University of Parma - Italy. 
//  All rights reserved.
//

#import "SIPDelimiter.h"


@implementation SIPDelimiter


@synthesize WSP;
@synthesize SPACE;
@synthesize CRLF;
@synthesize WSPCRLF;
@synthesize MARK;
@synthesize SEPARATOR;
@synthesize URI_SEPARATORS;
@synthesize URI_SCHEMES;


/** Creates a void Header. */
-(id) init
{
	
	if(self = [super init])
	{	
		//NSLog(@"SIPDelimiter Init ...");
		
		char wspValues[2]={' ','\t'};
		char crlfValues[2]={'\r','\n'};
		char wspcrlf[4]={' ','\t','\r','\n'};
	
		char markValues[] ={'-','_','.','!','~','*','\'','|'};
		char separatorValues[]={' ','\t','\r','\n','(',')','<','>',',',';','\\','"','/','[',']','?','=','{','}'};
		char uri_separatorsValues[4]={' ','>','\n','\r'};		
		NSString* uri_schemesValues[]={@"sip:",@"sips:"};
		
		//self.WSP = wspValues;
		self.WSP = (char*)malloc(WSP_SIZE);
		memcpy(self.WSP, wspValues, WSP_SIZE);
		
		//self.SPACE = wspValues;
		self.SPACE = (char*)malloc(SPACE_SIZE);
		memcpy(self.SPACE, wspValues,SPACE_SIZE);
		
		//self.CRLF = crlfValues;
		self.CRLF = (char*)malloc(CRLF_SIZE);
		memcpy(self.CRLF, crlfValues,CRLF_SIZE);
		
		//self.WSPCRLF = wspcrlf;
		self.WSPCRLF = (char*)malloc(WSPCRLF_SIZE);
		memcpy(self.WSPCRLF, wspcrlf,WSPCRLF_SIZE);
		
		//self.MARK = markValues;
		self.MARK = (char*)malloc(MARK_SIZE);
		memcpy(self.MARK, markValues,MARK_SIZE);
		
		//self.SEPARATOR = separatorValues;
		self.SEPARATOR = (char*)malloc(SEPARATOR_SIZE);
		memcpy(self.SEPARATOR, separatorValues,SEPARATOR_SIZE);
		
		self.URI_SEPARATORS = (char*)malloc(URI_SEPARATORS_SIZE);
		memcpy(self.URI_SEPARATORS, uri_separatorsValues, URI_SEPARATORS_SIZE); 
		
		//self.URI_SCHEMES = uri_schemesValues;
		self.URI_SCHEMES = (NSString**)malloc(sizeof(NSString*)*URI_SCHEMES_SIZE);
		memcpy(self.URI_SCHEMES, uri_schemesValues, URI_SCHEMES_SIZE); 
	}
	return self;
}

@end
