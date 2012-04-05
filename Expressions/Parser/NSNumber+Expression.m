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
#if __has_feature(objc_arc)
	EPStandardFunctionSource * functs = [[EPStandardFunctionSource alloc] init];
	EPDictionaryVariableSource * vars = [[EPDictionaryVariableSource alloc] init];
#else
    EPStandardFunctionSource * functs = [[[EPStandardFunctionSource alloc] init] autorelease];
	EPDictionaryVariableSource * vars = [[[EPDictionaryVariableSource alloc] init] autorelease];
#endif
	EPTokenString * tString = [[EPTokenString alloc] initWithExpression:expression varSource:vars funcSource:functs];
	if (!tString) return nil;
	EPExpression * exp = [[EPExpression alloc] initWithTokenString:tString];
#if !__has_feature(objc_arc)
	[tString release];
#endif
	if (!exp) return nil;
	EPNumericalToken * eval = [exp evaluateToToken];
#if !__has_feature(objc_arc)
	[exp release];
#endif
	if (!eval) return nil;
	return [NSNumber numberWithDouble:[eval doubleValue]];
}

+ (NSNumber *)numberByParsingExpression:(NSString *)expression withVariables:(NSDictionary *)varDictionary {
#if __has_feature(objc_arc)
    EPStandardFunctionSource * functs = [[EPStandardFunctionSource alloc] init];
	EPDictionaryVariableSource * vars = [[EPDictionaryVariableSource alloc] initWithDictionary:varDictionary];
#else
	EPStandardFunctionSource * functs = [[[EPStandardFunctionSource alloc] init] autorelease];
	EPDictionaryVariableSource * vars = [[[EPDictionaryVariableSource alloc] initWithDictionary:varDictionary] autorelease];
#endif
	EPTokenString * tString = [[EPTokenString alloc] initWithExpression:expression varSource:vars funcSource:functs];
	if (!tString) return nil;
	EPExpression * exp = [[EPExpression alloc] initWithTokenString:tString];
#if !__has_feature(objc_arc)
	[tString release];
#endif
	if (!exp) return nil;
	EPNumericalToken * eval = [exp evaluateToToken];
#if !__has_feature(objc_arc)
	[exp release];
#endif
	if (!eval) return nil;
	return [NSNumber numberWithDouble:[eval doubleValue]];
}

@end
