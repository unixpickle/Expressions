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
	@autoreleasepool {
        NSDictionary * variables = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:90], @"x", 
                                    [NSNumber numberWithDouble:180], @"y", nil];
        // Compressed equation
        NSNumber * parsedx = [NSNumber numberByParsingExpression:@"sin(x(pi/180))" withVariables:variables];
        // Non-compressed equation ;)
        NSNumber * parsedy = [NSNumber numberByParsingExpression:@"sin ( y * ( pi / 180 ) )" withVariables:variables];
        // Both work perfectly
        NSLog(@"sin(90): %@", parsedx);
        NSLog(@"sin(180): %@", parsedy);
        
        NSNumber * parsedw = [NSNumber numberByParsingExpression:@"-x^2" withVariables:variables];
        NSLog(@"-x^2 = %@", parsedw);
        
        printf("Enter an expression: ");
        NSString * expr = NSReadLine(stdin);
        NSNumber * parsed = [NSNumber numberByParsingExpression:expr];
        NSLog(@"%@ = %@", expr, parsed);
        
        NSLog(@"Starting benchmark: %@.", expr);
        for (int i = 0; i < 10000; i++) {
            @autoreleasepool {
                [NSNumber numberByParsingExpression:expr];
            }
        }
        NSLog(@"Done benchmark.");
    }
	
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
			[stringBuilder appendFormat:@"%C", aChar];
		}
	}
	
	NSString * immutable = [NSString stringWithString:stringBuilder];
#if !__has_feature(objc_arc)
	[stringBuilder release];
#endif
	return immutable;
}
