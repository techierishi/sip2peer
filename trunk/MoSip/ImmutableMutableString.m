//
//  ImmutableMutableString.m
//  StringTest
//
//  Created by marcopk on 29/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImmutableMutableString.h"


@implementation ImmutableMutableString

-(void) test{
	NSLog(@" -------------------- Immutable String Test ----------------------");
	
	NSString *str1 = @"This is string A";
	NSString *str2 = @"This is string A";
	NSString *res;
	NSComparisonResult compareResult;
	NSRange subRange;
	
	//////////////////////////////// 1 ////////////////////////////////////////
	
	//Count the number of characters
	NSLog(@"Lenght of str1: %lu", [str1 length]);
	
	//Copy one string to another
	res = [NSString stringWithString:str1];
	NSLog(@"copy: %@", res);
	
	//Copy one string to the end of another
	str2 = [str1 stringByAppendingString:str2];
	NSLog(@"Concatenation: %@",str2);
	
	//Test if two strings are equal
	if([str1 isEqualToString: res] == YES)
		NSLog(@"str1 == res");
	else
		NSLog(@"str1 != res");
	
	//Test if one string is <, == or > than another
	compareResult = [str1 compare:str2];
	
	if(compareResult == NSOrderedAscending)
		NSLog(@"str1 < str2");
	else if(compareResult == NSOrderedSame)
			NSLog(@"str1 == str2");
	else 
			NSLog(@"str1 > str2");
	
	//Convert String to uppercase
	res = [str1 uppercaseString];
	NSLog(@"Uppercase conversion: %s", [res UTF8String]);
	
	
	//Convert String to lowercase
	res = [str1 lowercaseString];
	NSLog(@"Lowercase conversion: %s", [res UTF8String]);
	
	NSLog(@"Original String: %@", str1);
	
	
	//////////////////////////////// 2 ////////////////////////////////////////
	
	//Extract first 3 char from string
	res = [str1 substringToIndex:3];
	NSLog(@"First 3 chars of string str1: %@",res);
	
	//Extract chars to end of string strating at index 5
	res = [str1 substringFromIndex:5];
	NSLog(@"Chars from index 5 of string str1: %@",res);

	//Extract chars from index 8 through 13 (6 chars)
	res = [[str1 substringFromIndex:8] substringToIndex:6];
	NSLog(@"Chars from index 8 through 13 of string str1: %@",res);
	
	//An easier way to do the same thing
	res = [str1 substringWithRange:NSMakeRange(8,6)];
	NSLog(@"Chars from index 8 through 13 of string str1: %@",res);
	
	//Locate one string inside another
	subRange = [str1 rangeOfString:@"string A"];
	NSLog(@"String is at index %lu , lenght is %lu",subRange.location,subRange.length);
	
	subRange = [str1 rangeOfString:@"string B"];
	if(subRange.location == NSNotFound)
		NSLog(@"String not found");
	else
		NSLog(@"String is at index %lu , lenght is %lu",subRange.location,subRange.length);
	
	NSLog(@"\n");
}



@end
