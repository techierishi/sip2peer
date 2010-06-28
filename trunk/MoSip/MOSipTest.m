#import <Foundation/Foundation.h>
#import "MutableString.h"
#import "ImmutableMutableString.h"
#import "SipURL.h"
#import "Parser.h"
#import "SipParser.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	
	ImmutableMutableString * immutableStringTest = [[ImmutableMutableString alloc] init];
	[immutableStringTest test];
	
	MutableString * mutableStringTest = [[MutableString alloc] init];
	[mutableStringTest test];
	
	
	/*
	NSString* testMessage = @"
	1236090458374: 15:27:38.374 Tue 03 Mar 2009, 192.168.1.229:5089/udp (429 bytes) sent
	MESSAGE sip:Monfortino-Monfortino@192.168.1.229:5089 SIP/2.0
	Via: SIP/2.0/UDP 192.168.1.229:5060;rport;branch=z9hG4bKb05062e8
	Max-Forwards: 70
	To: <sip:Monfortino-Monfortino@192.168.1.229:5089>
	From: <sip:Marco-Picone@192.168.1.229>;tag=057878413567
	Call-ID: 724601520366@192.168.1.229
	CSeq: 1 MESSAGE
	Expires: 3600
	User-Agent: mjsip 1.7
	Subject: NO SUBJECT
	Content-Length: 8
	Content-Type: application/text
	
	ci sei ?";*/
	
	
	/************************* TESTING PARSER CLASS **********************************/
	//NSLog(@"/************************* TESTING PARSER CLASS **********************************/");
	Parser *parser = [[Parser alloc] initWithString:@"HELLO WORLD !" andPosition:0];
	
	NSLog(@"Parser ---> String:%@ ---> Position: %d", parser.str , parser.index);
	NSLog(@"GetRemainingString: %@", [parser getRemainingString]);
	NSLog(@"SubParser with len 5: %@", [[parser subParser:5] str]);
	NSLog(@"Lenght: %d", [parser length]);
	NSLog(@"Has More ? %@", ([parser hasMore] ? @"YES" : @"NO"));
	NSLog(@"Get Char at %d : %c", [parser index], [parser getChar]);
	NSLog(@"Char at %d : %c", 6 , [parser charAt:6]);
	NSLog(@"Next Char: %c", [parser nextChar]);
	NSLog(@"Set Pos at 6 : %d", [[parser setPos:6] index]);
	NSLog(@"Go to Char W : %d", [[parser goTo:'W'] index]);

	NSLog(@"IndexOfChar '!' : %d", [parser indexOf:'!']);
	NSLog(@"IndexOfChar 'W' : %d", [parser indexOf:'W']);
	
	char testArray[2] = {'D','D'};
	int arraySize = sizeof(testArray) / sizeof(char);
	NSLog(@"Size Of Array: %d",arraySize);
	NSLog(@"IndexOfCString [D,D] : %d", [parser indexOfCString:testArray withSize:2]);
	
	NSLog(@"IndexOfString WORLD : %d", [parser indexOfString:@"WORLD"]);
	
	NSArray* testArray2 = [[NSArray alloc] initWithObjects:@"HELLO",@"world",@"!",nil];
	NSLog(@"IndexOfStringArray {HELLO,world,!} : %d", [parser indexOfStringInArray:testArray2]);
	NSLog(@"Compare Ignore Case 'c' e 'C' : %d", [parser compareIgnoreCase:'c' andChar:'C']);
	NSLog(@"Compare Ignore Case 'C' e 'C' : %d", [parser compareIgnoreCase:'C' andChar:'C']);
	NSLog(@"Compare Ignore Case 'W' e 'C' : %d", [parser compareIgnoreCase:'W' andChar:'C']);
	NSLog(@"Is '/r' CRLF ? %@",( [parser isCRLF:'\r'] ? @"YES" : @"NO"));
	NSLog(@"Is 'r' CRLF ? %@",( [parser isCRLF:'r'] ? @"YES" : @"NO"));
	NSLog(@"Is '/t' CRLF ? %@",( [parser isWSPCRLF:'\t'] ? @"YES" : @"NO"));
	NSLog(@"Is 't' CRLF ? %@",( [parser isWSPCRLF:'t'] ? @"YES" : @"NO"));
	NSLog(@"Parser at Index: %d start with 'WORLD' %@",[parser index],( [parser startsWith:@"WORLD"] ? @"YES" : @"NO"));
	NSLog(@"Parser at Index: %d start with 'HELLO' %@",[parser index],( [parser startsWith:@"HELLO"] ? @"YES" : @"NO"));
	
	NSArray* testArray3 = [[NSArray alloc] initWithObjects:@"HELLO",@"WORLD",@"!",nil];
	NSLog(@"Parser at Index: %d start with String in Array {'HELLO','WORLD','!} ? %@",[parser index],( [parser startsWithStringInArray:testArray3] ? @"YES" : @"NO"));
	
	NSArray* testArray4 = [[NSArray alloc] initWithObjects:@"HELLO",@"world",@"!",nil];
	NSLog(@"Parser at Index: %d start with String in Array {'HELLO','world','!}' ? %@",[parser index],( [parser startsWithStringInArray:testArray4] ? @"YES" : @"NO"));
	
	NSLog(@"Parser at Index: %d start with 'world' ignoring case %@",[parser index],( [parser startsWithIgnoreCase:@"world"] ? @"YES" : @"NO"));
	NSLog(@"Parser at Index: %d start with 'hello' ignoring case %@",[parser index],( [parser startsWithIgnoreCase:@"hello"] ? @"YES" : @"NO"));
	
	NSLog(@"Parser at Index: %d start with String in Array {'HELLO','WORLD','!} ignoring case ? %@",[parser index],( [parser startsWithIgnoreCaseStringInArray:testArray3] ? @"YES" : @"NO"));
	NSLog(@"Parser at Index: %d start with String in Array {'HELLO','world','!} ignoring case ? %@",[parser index],( [parser startsWithIgnoreCaseStringInArray:testArray4] ? @"YES" : @"NO"));
	
	NSLog(@"IndexOfIgnoreCase world : %d", [parser indexOfIgnoreCase:@"world"]);
	NSLog(@"IndexOfIgnoreCase HOUSE : %d", [parser indexOfIgnoreCase:@"HOUSE"]);
	
	NSArray* testArray5 = [[NSArray alloc] initWithObjects:@"Hello",@"world",@"!",nil];
	NSLog(@"indexOfStringInArrayIgnoreCase {HELLO,world,!} : %d", [parser indexOfStringInArrayIgnoreCase:testArray5]);
	
	NSArray* testArray6 = [[NSArray alloc] initWithObjects:@"Hello",@"house",@"!!",nil];
	NSLog(@"indexOfStringInArrayIgnoreCase {HELLO,HOUSE,!} : %d", [parser indexOfStringInArrayIgnoreCase:testArray6]);
	
	NSLog(@"Index Of Next Line: %d", [parser indexOfNextLine]);
	
	NSLog(@"Go to String 'LD': %d", [[parser goToString:@"LD"] index]);
	NSLog(@"Go to String in Array {'HELLO','WORLD','!}: %d", [[parser goToStringInArray:testArray3] index]);
	
	NSLog(@"Setting Parser Position to 0 ...");
	[parser setPos:0];
	
	NSLog(@"Go to String Ignoring Case 'ld': %d", [[parser goToIgnoreCase:@"ld"] index]);
	
	NSLog(@"Setting Parser Position to 0 ...");
	[parser setPos:0];
	
	[parser setPos:0];NSArray* testArray7 = [[NSArray alloc] initWithObjects:@"house",@"world",@"!!",nil];
	NSLog(@"Go to String Ignoring Case in Array {'house','world','!} : %d", [[parser goToIgnoreCaseInArray:testArray7] index]);
	
	NSLog(@"Setting Parser Position to 0 ...");
	[parser setPos:0];
	NSLog(@"Skip 5 chars ---> New Index: %d",[[parser skipN:5] index]);
	NSLog(@"Skip WSP ---> New Index: %d", [[parser skipWSP] index] );
	
	NSLog(@"GetString :%@---> New Parser Index %d", [parser getString],[parser index]);
	
	NSLog(@"Setting Parser Position to 0 ...");
	[parser setPos:0];
	NSLog(@"GetString Of Lenght 3 :%@", [parser getStringOfLenght:3]);
	
	Parser *parser2 = [[Parser alloc] initWithString:@"HELLO#WORLD#!!!!" andPosition:0];
	NSLog(@"Parser2 ---> String:%@ ---> Position: %d", parser2.str , parser2.index);
	char app[1] = {'#'};
	NSLog(@"Get Word separated by any of chars of separators {'#'}:%@",[parser2 getWord:app withSize:1]);
	NSLog(@"New Parser2 Position: %d",[parser2 index]);
	
	NSLog(@"Get Int: %d",[parser2 getInt]);
	NSLog(@"Get Double: %f",[parser2 getDouble]);
	
	Parser *parser3 = [[Parser alloc] initWithString:@"HELLO WORLD!!!!\nCiaoMondo!!!\nHolaMundo!!!" andPosition:0];
	NSLog(@"Parser3 ---> String:%@ ---> Position: %d", parser3.str , parser3.index);
	NSLog(@"Get Line:%@",[parser3 getLine]);
	NSLog(@"New Parser3 Position: %d",[parser3 index]);
	
	Parser *parser4 = [[Parser alloc] initWithString:@"35#25#15#10" andPosition:0];
	NSLog(@"Parser4 ---> String:%@ ---> Position: %d", parser4.str , parser4.index);
	
	NSLog(@"Get Int Vector Of Parser 4 with separator {#}:");
	NSArray *intArray = [parser4 getIntArrayWithSeparators:app withSize:1];
	for(int i=0; i < [intArray count]; i++)
		NSLog(@"Value(%d)=%@",i,[intArray objectAtIndex:i]);
	
	NSLog(@"Setting Parser4 Position to 0 ...");
	[parser4 setPos:0];
	NSLog(@"Get Int Vector Of Parser 4:");
	intArray = [parser4 getIntArray];
	for(int i=0; i < [intArray count]; i++)
		NSLog(@"Value(%d)=%@",i,[intArray objectAtIndex:i]);
	
	NSLog(@"Setting Parser2 Position to 0 ...");
	[parser2 setPos:0];
	NSLog(@"Get Words Vector Of Parser 2 with separator {#}:");
	NSArray *wordsArray = [parser2 getWordArray:app withSize:1];
	for(int i=0; i < [wordsArray count]; i++)
		NSLog(@"Value(%d)=%@",i,[wordsArray objectAtIndex:i]);

	NSLog(@"Setting Parser Position to 0 ...");
	[parser setPos:0];
	NSLog(@"Get Strings Vector Of Parser :");
	wordsArray = [parser getStringArray];
	for(int i=0; i < [wordsArray count]; i++)
		NSLog(@"Value(%d)=%@",i,[wordsArray objectAtIndex:i]);
	
	NSLog(@"Setting Parser2 Position to 0 ...");
	[parser2 setPos:0];
	NSLog(@"Get Word Skipping Quoted Of Parser2 :%@",[parser2 getWordSkippingQuoted:app withSize:1]);
	
	[testArray2 retain];
	[testArray3 retain];
	[testArray4 retain];
	[testArray5 retain];
	[testArray6 retain];
	[testArray7 retain];
	[parser retain];
	[parser2 retain];
	[parser3 retain];
	[parser4 retain];
	
	NSLog(@"/*********************************************************************************/");
	/*********************************************************************************/
	
	/************************* TESTING SIP URL CLASS **********************************/
	NSLog(@" ");
	NSLog(@" ");
	NSLog(@"/************************* TESTING SIP URL CLASS **********************************/");
	/* Init Methods tests */
	SipURL* sipUrlTest = [[SipURL alloc] initWithSipURL:@"sips:Monfortino-Monfortino@192.168.1.229:5089"];
	NSLog(@"SipUrl ---> URL: %@ - Secure: %@", sipUrlTest.url , (sipUrlTest.secure ? @"YES" : @"NO"));

	SipURL* sipUrlTest2 = [[SipURL alloc] initWithSipURL:@"Monfortino-Monfortino"];
	NSLog(@"SipUrl 2 ---> URL: %@ - Secure: %@", sipUrlTest2.url , (sipUrlTest2.secure ? @"YES" : @"NO"));
	
	SipURL* sipUrlTest3 = [[SipURL alloc] initWithUsername:@"marcopk" hostName:@"Monfortino" portNumber:8080];
	NSLog(@"SipUrl 3 ---> URL: %@ - Secure: %@", sipUrlTest3.url , (sipUrlTest3.secure ? @"YES" : @"NO"));
	
	/* Get Methods */
	NSLog(@"SipUrl ---> Get User Name: %@",[sipUrlTest getUserName]);
	NSLog(@"SipUrl ---> Get Host : %@",[sipUrlTest getHost]);
	NSLog(@"SipUrl ---> Get Port: %d",[sipUrlTest getPort]);
	NSLog(@"SipUrl ---> Has User Name ? %@", ([sipUrlTest hasUserName] ? @"YES" : @"NO"));
	NSLog(@"SipUrl ---> Has Port ? %@", ([sipUrlTest hasPort] ? @"YES" : @"NO"));
	NSLog(@"SipUrl ---> To String : %@",[sipUrlTest toString]);
	NSLog(@"SipUrl ---> Get Parameters : %@",[sipUrlTest getParameters]);
	
	/* Equal Method Test*/
	if(![sipUrlTest3 isEqual:sipUrlTest])
		NSLog(@"Are SipUrl and SipUrl3 Equal ? Not Equals !");
	if([sipUrlTest isEqual:sipUrlTest])
		NSLog(@"Are SipUrl and SipUrl Equal ?  Equals !");
	
	
	[sipUrlTest release];
	[sipUrlTest2 release];
	[sipUrlTest3 release];
	NSLog(@"/*********************************************************************************/");
	/****************************************************************************************/
	
	/************************* TESTING SIP PARSER CLASS **********************************/
	NSLog(@" ");
	NSLog(@" ");
	NSLog(@"/************************* TESTING SIP PARSER CLASS **********************************/");

	SipParser* sipParser = [[SipParser alloc] initWithString:@"MESSAGE sip:echo@zoopera.com SIP/2.0\nVia: SIP/2.0/UDP 127.0.0.77:5077;rport;branch=z9hG4bK19524\nMax-Forwards: 70\nTo: <sip:echo@zoopera.com>\nFrom: \"user\" <sip:user@127.0.0.77:5077>;tag=z9hG4bK31991716\nCall-ID: 217226008925@127.0.0.77\nCSeq: 1 MESSAGE\nExpires: 3600\nUser-Agent: mjsip stack 1.6\nContent-Length: 4\nContent-Type: application/text\n\nciao"];
	//NSLog(@"\n%@\n",[sipParser str]);
	//NSLog(@"Get Request Line OO--> %@ ",[[sipParser getRequestLine] toString]); //OK !
	
	//StatusLine* statusLine = [sipParser getStatusLine];
	//NSLog(@"Get Status Line --> Code:%d Reason:%@ ",[statusLine code],[statusLine reason]);
	
	//Header* header = [sipParser getHeader:@"Via"];
	//NSLog(@"Header Via: %@ value:%@",[header name],[header value]);
	 
	//NameAddress* nameAddr = [sipParser getNameAddress];
	//NSLog(@"Get Name Address --> Name:%@ URL:%@ ",[nameAddr name],[[nameAddr url] toString]);

	//NSString* params = [sipParser getParameter:@"rport"];
	//NSLog(@"Get Parameters --> Reason:%@ ",params);
	
	//NSArray* params = [sipParser getParameterNames];
	
	//for(int i=0; i<[params count]; i++)
	//	NSLog(@"Param[%d]:%@",i,[params objectAtIndex:i]);
	
	//NSLog(@"HasParameter ---> Reason ? %@", ([sipParser hasParameter:@"rport"] ? @"YES" : @"NO"));
	
	//NSLog(@"indexOfCommaHeaderSeparator ---> Reason: %d", ([sipParser indexOfCommaHeaderSeparator]));

	//NSLog(@"goToCommaHeaderSeparator ---> Reason: %d", ([sipParser goToCommaHeaderSeparator]));
	
	
	NSLog(@"/*********************************************************************************/");
	
	
	
	
	
	
	
	
	/****************************************************************************************/
		
    [pool drain];
    return 0;
}
