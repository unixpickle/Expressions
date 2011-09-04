//
//  EPTokenString.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define IS_OPERATOR(x) (x == '+' || x == '-' || x == '/' || x == '*' || x == '(' || x == ')' || x == '^')

#import "EPTokenString.h"

@interface EPTokenString (Private)

- (id)initWithTokens:(NSArray *)tokens;
- (EPToken *)tokenFromString:(NSString *)tString vars:(id<EPTokenStringVariableSource>)vars functs:(id<EPTokenStringFunctionSource>)functs;

@end

@implementation EPTokenString

- (id)init {
	if ((self = [super init])) {
	}
	return self;
}

- (id)initWithExpression:(NSString *)expression varSource:(id<EPTokenStringVariableSource>)variables
			  funcSource:(id<EPTokenStringFunctionSource>)functions {
	if ((self = [super init])) {
		NSMutableString * currentBuff = [NSMutableString string];
		NSMutableArray * tArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < [expression length]; i++) {
			unichar aChar = [expression characterAtIndex:i];
			// check for a single-character operator
			if (IS_OPERATOR(aChar)) {
				if ([currentBuff length] > 0) {
					EPToken * token = [self tokenFromString:currentBuff vars:variables functs:functions];
					[currentBuff deleteCharactersInRange:NSMakeRange(0, [currentBuff length])];
					if (token) {
						[tArray addObject:token];
					} else {
						[tArray release], [super dealloc];
						return nil;
					}
				}
				NSString * tString = [NSString stringWithFormat:@"%C", aChar];
				EPToken * token = [self tokenFromString:tString vars:variables functs:functions];
				if (token) {
					[tArray addObject:token];
				} else {
					[tArray release], [super dealloc];
					return nil;
				}
			} else if (!isspace(aChar)) {
				[currentBuff appendFormat:@"%C", aChar];
			}
		}
		if ([currentBuff length] > 0) {
			EPToken * token = [self tokenFromString:currentBuff vars:variables functs:functions];
			if (token) {
				[tArray addObject:token];
			} else {
				[tArray release], [super dealloc];
				return nil;
			}
		}
		tokenArray = [[NSArray alloc] initWithArray:tArray];
		[tArray release];
	}
	return self;
}

- (NSArray *)tokenArray {
	return tokenArray;
}

- (EPTokenString *)substringWithRange:(NSRange)tokenRange {
	if (tokenRange.location + tokenRange.length > [tokenArray count]) {
		@throw [NSException exceptionWithName:NSRangeException
									   reason:@"Invalid bounds specified for substringWithRange:"
									 userInfo:nil];
	}
	
	NSMutableArray * subArray = [[NSMutableArray alloc] init];
	for (NSUInteger i = tokenRange.location; i < tokenRange.location + tokenRange.length; i++) {
		[subArray addObject:[tokenArray objectAtIndex:i]];
	}
	
	NSArray * immutable = [NSArray arrayWithArray:subArray];
	[subArray release];
	return [[[EPTokenString alloc] initWithTokens:immutable] autorelease];
}

- (void)dealloc {
	[tokenArray release];
	[super dealloc];
}

#pragma mark Private

- (id)initWithTokens:(NSArray *)tokens {
	if ((self = [super init])) {
		tokenArray = [tokens copyWithZone:NSDefaultMallocZone()];
	}
	return self;
}

- (EPToken *)tokenFromString:(NSString *)_tString vars:(id<EPTokenStringVariableSource>)vars functs:(id<EPTokenStringFunctionSource>)functs {
	// go through a series of possibilities
	EPToken * theToken = nil;
	
	NSString * tString = [[[NSString alloc] initWithString:_tString] autorelease];
	
	if ((theToken = [[EPParenthesesToken alloc] initWithString:tString]) != nil) return [theToken autorelease];	
	if ((theToken = [[EPAddSubOperator alloc] initWithString:tString]) != nil) return [theToken autorelease];
	if ((theToken = [[EPMulDivOperator alloc] initWithString:tString]) != nil) return [theToken autorelease];
	if ((theToken = [[EPPowerOperator alloc] initWithString:tString]) != nil) return [theToken autorelease];
	if ((theToken = [[EPNumericalToken alloc] initWithString:tString]) != nil) return [theToken autorelease];
	
	if ([vars variableExists:tString]) {
		theToken = [[EPVariableToken alloc] initWithString:tString];
		[(EPVariableToken *)theToken setDoubleValue:[vars variableValue:tString]];
		return [theToken autorelease];
	}
	
	if ([functs functionExists:tString]) {
		theToken = [functs functionTokenForName:tString];
		return theToken;
	}
	
	return theToken;
}

@end
