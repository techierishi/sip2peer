//
//  MutableString.m
//  StringTest
//
//  Created by marcopk on 29/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MutableString.h"

/*
 * The MutableString class can be used to create string objects whose characters can be changed. Because 
 this kind of class is a subclass of NSString, all NSString's methods can be used as well.
 */
@implementation MutableString

-(void) test{
	
	NSLog(@" -------------------- Mutable String Test ----------------------");
	
	NSString *str1 = @"This is string A";
	NSString *search, *replace;
	NSMutableString *mstr;
	NSRange substr;
		
	//Create mutable string from nonmutable
	mstr = [NSMutableString stringWithString:str1];
	NSLog(@"Mutable string from nonmutable: %@", mstr);
	
	//Insert characters 
	[mstr insertString:@" mutable" atIndex:7];
	NSLog(@"Insert characters : %@", mstr);
	
	//Effective concatenation if insert at end
	[mstr insertString:@" and string B" atIndex:[mstr length]];
	NSLog(@"Effective concatenation if insert at end: %@",mstr);
	
	//Concatenation with append
	[mstr appendString:@" and string C"];
	NSLog(@"Concatenation with append: %@",mstr);
	
	//Delete substring based on range
	[mstr deleteCharactersInRange:NSMakeRange(16, 13)];
	NSLog(@"Delete substring based on range: %@",mstr);
	
	//Find range first and then use it for deletion
	substr = [mstr rangeOfString:@" string B and"];
	
	if(substr.location != NSNotFound)
	{
		[mstr deleteCharactersInRange:substr];
		NSLog(@"Find range first and then use it for deletion: %@",mstr);
	}
	
	//Set the mutable string direcly
	[mstr setString:@"This is string A"];
	NSLog(@"Set the mutable string direcly: %@",mstr);
	
	//Now let's replace a range of chars with another
	[mstr replaceCharactersInRange:NSMakeRange(8,8) withString:@"a mutable string"];
	NSLog(@"Now let's replace a range of chars with another: %@",mstr);
	
	//Search  and replace
	search = @"This is";
	replace = @"An example of";
	
	substr = [mstr rangeOfString:search];
	
	if(substr.location != NSNotFound)
	{
		[mstr deleteCharactersInRange:substr];
		NSLog(@"Find range first and then use it for deletion: %@",mstr);
	}
	
	
}

@end
