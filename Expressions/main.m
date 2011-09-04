//
//  main.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNumber+Expression.h"

NSString * NSReadLine (FILE * fp);

int main (int argc, const char * argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	NSDictionary * variables = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:90], @"x", 
								[NSNumber numberWithDouble:180], @"y", nil];
	// Compressed equation
	NSNumber * parsedx = [NSNumber numberByParsingExpression:@"sin(x(pi/180))" withVariables:variables];
	// Non-compressed equation ;)
	NSNumber * parsedy = [NSNumber numberByParsingExpression:@"sin ( y * ( pi / 180 ) )" withVariables:variables];
	// Both work perfectly
	NSLog(@"sin(90): %@", parsedx);
	NSLog(@"sin(180): %@", parsedy);
	
	printf("Enter an expression: ");
	NSString * expr = NSReadLine(stdin);
	NSNumber * parsed = [NSNumber numberByParsingExpression:expr];
	NSLog(@"%@ = %@", expr, parsed);
	
	NSLog(@"Starting benchmark: %@.", expr);
	for (int i = 0; i < 10000; i++) {
		NSAutoreleasePool * inner = [[NSAutoreleasePool alloc] init];
		[NSNumber numberByParsingExpression:expr];
		[inner drain];
	}
	NSLog(@"Done benchmark.");
	
	[pool drain];
	return 0;
}

NSString * NSReadLine (FILE * fp) {
	NSMutableString * stringBuilder = [[NSMutableString alloc] init];
	while (!feof(fp)) {
		int aChar = fgetc(fp);
		if (aChar == EOF) {
			break;
		} else if (aChar != '\r') {
			if (aChar == '\n') break;
			[stringBuilder appendFormat:@"%c", (char)aChar];
		}
	}
	
	NSString * immutable = [NSString stringWithString:stringBuilder];
	[stringBuilder release];
	return immutable;
}
