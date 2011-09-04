//
//  NSNumber+Expression.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSNumber+Expression.h"

@implementation NSNumber (Expression)

+ (NSNumber *)numberByParsingExpression:(NSString *)expression {
	EPStandardFunctionSource * functs = [[[EPStandardFunctionSource alloc] init] autorelease];
	EPTokenString * tString = [[EPTokenString alloc] initWithExpression:expression varSource:nil funcSource:functs];
	if (!tString) return nil;
	EPExpression * exp = [[EPExpression alloc] initWithTokenString:tString];
	[tString release];
	if (!exp) return nil;
	EPNumericalToken * eval = [exp evaluateToToken];
	[exp release];
	if (!eval) return nil;
	return [NSNumber numberWithDouble:[eval doubleValue]];
}

+ (NSNumber *)numberByParsingExpression:(NSString *)expression withVariables:(NSDictionary *)varDictionary {
	EPStandardFunctionSource * functs = [[[EPStandardFunctionSource alloc] init] autorelease];
	EPDictionaryVariableSource * vars = [[[EPDictionaryVariableSource alloc] initWithDictionary:varDictionary] autorelease];
	EPTokenString * tString = [[EPTokenString alloc] initWithExpression:expression varSource:vars funcSource:functs];
	if (!tString) return nil;
	EPExpression * exp = [[EPExpression alloc] initWithTokenString:tString];
	[tString release];
	if (!exp) return nil;
	EPNumericalToken * eval = [exp evaluateToToken];
	[exp release];
	if (!eval) return nil;
	return [NSNumber numberWithDouble:[eval doubleValue]];
}

@end
