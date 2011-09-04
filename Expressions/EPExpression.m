//
//  EPExpression.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPExpression.h"

@interface EPExpression (Private)

- (EPTokenString *)subExpression:(EPTokenString *)aString fromIndex:(NSUInteger *)i;
- (BOOL)performFunctions;
- (BOOL)performOperatorsOfClass:(Class)aClass;
- (BOOL)evaluateSubExpressions;

@end

@implementation EPExpression

- (id)init {
	if ((self = [super init])) {
		// Initialization code here.
	}
	return self;
}

- (id)initWithTokenString:(EPTokenString *)tString {
	if ((self = [super init])) {
		id lastObject = nil;
		tokens = [[NSMutableArray alloc] init];
		
		for (NSUInteger i = 0; i < [[tString tokenArray] count]; i++) {
			EPToken * token = [[tString tokenArray] objectAtIndex:i];
			if ([token isKindOfClass:[EPParenthesesToken class]]) {
				EPParenthesesToken * pt = (EPParenthesesToken *)token;
				if ([pt direction] == EPTParenthesesClose) {
					[self dealloc];
					return nil;
				}
				// go until we find a matching end-paren
				EPTokenString * subExpr = [self subExpression:tString fromIndex:&i];
				if (!subExpr) {
					[self dealloc];
					return nil;
				}
				EPExpression * expr = [[EPExpression alloc] initWithTokenString:subExpr];
				if (!expr) {
					[self dealloc];
					return nil;
				}
				if (![lastObject isKindOfClass:[EPOperator class]] && ![lastObject isKindOfClass:[EPFunctionToken class]] && lastObject != nil) {
					// insert multiplication operator
					[tokens addObject:[[[EPMulDivOperator alloc] initWithString:@"*"] autorelease]];
				}
				[tokens addObject:expr];
				lastObject = [expr autorelease];
			} else {
				if (![token isKindOfClass:[EPOperator class]]) {
					if (![lastObject isKindOfClass:[EPOperator class]] && ![lastObject isKindOfClass:[EPFunctionToken class]] && lastObject != nil) {
						// insert multiplication operator
						[tokens addObject:[[[EPMulDivOperator alloc] initWithString:@"*"] autorelease]];
					}
				}
				[tokens addObject:token];
				lastObject = token;
			}
		}
	}
	return self;
}

- (EPNumericalToken *)evaluateToToken {
	// Here we use PEMDAS to evaluate the expression
	if (![self evaluateSubExpressions]) return nil;
	if (![self performFunctions]) return nil;
	if (![self performOperatorsOfClass:[EPPowerOperator class]]) return nil;
	if (![self performOperatorsOfClass:[EPMulDivOperator class]]) return nil;
	if (![self performOperatorsOfClass:[EPAddSubOperator class]]) return nil;
	if ([tokens count] != 1) {
		return nil;
	}
	if (![[tokens objectAtIndex:0] isKindOfClass:[EPNumericalToken class]]) {
		return nil;
	}
	return [tokens objectAtIndex:0];
}

- (void)dealloc {
	[tokens release];
	[super dealloc];
}

#pragma mark Private

- (EPTokenString *)subExpression:(EPTokenString *)aString fromIndex:(NSUInteger *)i {
	int level = 0;
	NSUInteger startParen = *i + 1;
	NSUInteger endParen = *i + 1;
	for (NSUInteger j = *i; j < [[aString tokenArray] count]; j++) {
		EPToken * aToken = [[aString tokenArray] objectAtIndex:j];
		if ([aToken isKindOfClass:[EPParenthesesToken class]]) {
			EPParenthesesToken * pToken = (EPParenthesesToken *)aToken;
			if ([pToken direction] == EPTParenthesesClose) {
				level--;
			} else {
				level++;
			}
		}
		if (level == 0) {
			*i = j; // will get incremented again
			endParen = *i;
			break;
		}
	}
	if (level != 0) {
		return nil;
	}
	EPTokenString * substr = [aString substringWithRange:NSMakeRange(startParen, endParen - startParen)];
	return substr;
}

- (BOOL)performFunctions {
	for (NSUInteger i = 0; i < [tokens count]; i++) {
		NSObject * obj = [tokens objectAtIndex:i];
		if ([obj isKindOfClass:[EPFunctionToken class]]) {
			EPFunctionToken * funct = (EPFunctionToken *)obj;
			if (i + 1 == [tokens count]) {
				return NO;
			}
			NSObject * nextObj = [tokens objectAtIndex:(i + 1)];
			EPNumericalToken * answer = [funct applyToOperand:nextObj];
			if ([answer respondsToSelector:@selector(doubleValue)]) {
				NSArray * ansArray = [NSArray arrayWithObject:answer];
				[tokens replaceObjectsInRange:NSMakeRange(i, 2) withObjectsFromArray:ansArray];
			} else {
				return NO;
			}
		}
	}
	return YES;
}

- (BOOL)performOperatorsOfClass:(Class)aClass {
	// TODO: perform operators here
	for (NSUInteger i = 0; i < [tokens count]; i++) {
		NSObject * obj = [tokens objectAtIndex:i];
		if ([obj isKindOfClass:aClass]) {
			if (i == 0 || i + 1 == [tokens count]) {
				return NO;
			}
			EPNumericalToken * answer = [(EPOperator *)obj applyLeftOperand:[tokens objectAtIndex:(i - 1)] 
																   toRight:[tokens objectAtIndex:(i + 1)]];
			if (!answer) return NO;
			NSArray * ansArray = [NSArray arrayWithObject:answer];
			[tokens replaceObjectsInRange:NSMakeRange(i - 1, 3) withObjectsFromArray:ansArray];
			i--;
		}
	}
	return YES;
}

- (BOOL)evaluateSubExpressions {
	for (NSUInteger i = 0; i < [tokens count]; i++) {
		NSObject * obj = [tokens objectAtIndex:i];
		if ([obj isKindOfClass:[EPExpression class]]) {
			EPNumericalToken * numTok = [(EPExpression *)obj evaluateToToken];
			if (!numTok) return NO;
			[tokens replaceObjectAtIndex:i withObject:numTok];
		}
	}
	return YES;
}

@end
