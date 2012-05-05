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
- (void)substituteVariables;
- (BOOL)performFunctions;
- (BOOL)performOperatorsOfClass:(Class)aClass;
- (BOOL)evaluateSubExpressions;

@end

@implementation EPExpression

@synthesize negateExpression;

- (id)initWithTokenString:(EPTokenString *)tString {
	if ((self = [super init])) {
		BOOL mulNeeded = NO, negateNext = NO;
		EPToken * lastToken = nil;
		tokens = [[NSMutableArray alloc] init];
		
		for (NSUInteger i = 0; i < [[tString tokenArray] count]; i++) {
			EPToken * token = [[tString tokenArray] objectAtIndex:i];
			if ([token isKindOfClass:[EPParenthesesToken class]]) {
				EPParenthesesToken * pt = (EPParenthesesToken *)token;
				if ([pt direction] == EPTParenthesesClose) {
#if !__has_feature(objc_arc)
                    [super dealloc];
#endif
					return nil;
				}
				// go until we find a matching end-paren
				EPTokenString * subExpr = [self subExpression:tString fromIndex:&i];
				if (!subExpr) {
#if !__has_feature(objc_arc)
                    [super dealloc];
#endif
					return nil;
				}
#if __has_feature(objc_arc)
				EPExpression * expr = [[EPExpression alloc] initWithTokenString:subExpr];
#else
                EPExpression * expr = [[[EPExpression alloc] initWithTokenString:subExpr] autorelease];
#endif
				if (!expr) {
#if !__has_feature(objc_arc)
                    [super dealloc];
#endif
					return nil;
				}
				if (mulNeeded) {
					// insert unwritten multiplication operator
                    id obj = [[EPMulDivOperator alloc] initWithString:@"*"];
#if !__has_feature(objc_arc)
					[tokens addObject:[obj autorelease]];
#else
                    [tokens addObject:obj];
#endif
				}
				[expr setNegateExpression:negateNext];
				[tokens addObject:expr];
				negateNext = NO;
				mulNeeded = YES;
			} else {
				BOOL insertToken = YES;
				if (![token isKindOfClass:[EPOperator class]] && mulNeeded) {
					// insert unwritten multiplication operator
                    id obj = [[EPMulDivOperator alloc] initWithString:@"*"];
#if !__has_feature(objc_arc)
					[tokens addObject:[obj autorelease]];
#else
                    [tokens addObject:obj];
#endif
				}
				if ([token isKindOfClass:[EPOperator class]] && ([lastToken isKindOfClass:[EPOperator class]] || lastToken == nil)) {
					if ([token isKindOfClass:[EPAddSubOperator class]]) {
						if ([(EPAddSubOperator *)token isSubtraction]) {
							// if the last token was a carrot (exponent), then negate the next token.
							// otherwise, replace - with * -1
							if ([lastToken isKindOfClass:[EPPowerOperator class]]) {
								negateNext = YES;
							} else {
								negateNext = NO;
								[tokens addObject:[EPNumericalToken numericalTokenWithDouble:-1]];
                                id obj = [[EPMulDivOperator alloc] initWithString:@"*"];
#if !__has_feature(objc_arc)
                                [tokens addObject:[obj autorelease]];
#else
                                [tokens addObject:obj];
#endif
							}
							insertToken = NO;							
						}
					}
				}
				if (insertToken) {
					if (negateNext) {
						[tokens addObject:[token negativeToken]];
					} else {
						[tokens addObject:token];
					}
					negateNext = NO;
				}
				mulNeeded = (![token isKindOfClass:[EPOperator class]] && ![token isKindOfClass:[EPFunctionToken class]] && token != nil);
			}
			lastToken = token;
		}
	}
	return self;
}

- (EPNumericalToken *)evaluateToToken {
	// Here we use PEMDAS to evaluate the expression
    [self substituteVariables];
	if (![self evaluateSubExpressions]) return nil; // P
	if (![self performFunctions]) return nil; // (implied)
	if (![self performOperatorsOfClass:[EPPowerOperator class]]) return nil; // E
	if (![self performOperatorsOfClass:[EPMulDivOperator class]]) return nil; // MD
	if (![self performOperatorsOfClass:[EPAddSubOperator class]]) return nil; // AS
	if ([tokens count] != 1) {
		return nil;
	}
    
    // if the expression is simply a variable, we can still evaluate it...
	if (![[tokens objectAtIndex:0] isKindOfClass:[EPNumericalToken class]]) {
        id obj = [tokens objectAtIndex:0];
        if (![obj isKindOfClass:[EPVariableToken class]]) return nil;
        EPNumericalToken * token = [EPNumericalToken numericalTokenWithDouble:[obj doubleValue]];
        [tokens replaceObjectAtIndex:0 withObject:token];
	}
	if (!negateExpression) {
		return [tokens objectAtIndex:0];
	} else {
		EPNumericalToken * token = [tokens objectAtIndex:0];
        id obj = [[EPNumericalToken alloc] initWithDouble:-[token doubleValue]];
#if !__has_feature(objc_arc)
		return [obj autorelease];
#else
        return obj;
#endif
	}
}

#if !__has_feature(objc_arc)
- (void)dealloc {
	[tokens release];
	[super dealloc];
}
#endif

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

- (void)substituteVariables {
    for (NSUInteger i = 0; i < [tokens count]; i++) {
        if ([[tokens objectAtIndex:i] isKindOfClass:[EPVariableToken class]]) {
            id obj = [tokens objectAtIndex:i];
            EPNumericalToken * number = [EPNumericalToken numericalTokenWithDouble:[obj doubleValue]];
            [tokens replaceObjectAtIndex:i withObject:number];
        }
    }
    return;
}

- (BOOL)performFunctions {
	for (NSUInteger i = 0; i < [tokens count]; i++) {
		NSObject * obj = [tokens objectAtIndex:i];
		if ([obj isKindOfClass:[EPFunctionToken class]]) {
			EPFunctionToken * funct = (EPFunctionToken *)obj;
			if (i + 1 >= [tokens count]) {
				return NO;
			}
			id nextObj = [tokens objectAtIndex:(i + 1)];
			EPNumericalToken * answer = [funct applyToOperand:nextObj];
			if ([answer respondsToSelector:@selector(doubleValue)] && answer != nil) {
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
		if ([obj isKindOfClass:aClass] && [obj isKindOfClass:[EPOperator class]]) {
			if (i == 0 || i + 1 >= [tokens count]) {
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
