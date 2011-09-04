//
//  main.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNumber+Expression.h"

int main (int argc, const char * argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	NSDictionary * variables = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:90], @"x", 
								[NSNumber numberWithDouble:180], @"y", nil];
	// Compressed equation
	NSNumber * parsedx = [NSNumber numberByParsingExpression:@"sin(x(pi/180))" withVariables:variables];
	// Non-compressed equation ;)
	NSNumber * parsedy = [NSNumber numberByParsingExpression:@"sin ( y * ( pi / 180 ) )" withVariables:variables];
	// Both work!
	NSLog(@"sin(90): %@", parsedx);
	NSLog(@"sin(180): %@", parsedy);
	
	[pool drain];
	return 0;
}

