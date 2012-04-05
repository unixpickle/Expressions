//
//  EPStandardFunctionSource.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPStandardFunctionSource.h"

@implementation EPStandardFunctionSource

- (BOOL)functionExists:(NSString *)funcName {
	if ([funcName isEqualToString:@"sin"] || [funcName isEqualToString:@"cos"]) {
		return YES;
	}
	if ([funcName isEqualToString:@"tan"] || [funcName isEqualToString:@"atan"]) {
		return YES;
	}
	if ([funcName isEqualToString:@"log"] || [funcName isEqualToString:@"ln"]) {
		return YES;
	}
	if ([funcName isEqualToString:@"sqrt"]) {
		return YES;
	}
	
	return NO;
}

- (EPFunctionToken *)functionTokenForName:(NSString *)funcName {
#if __has_feature(objc_arc)
    if ([funcName isEqualToString:@"cos"] || [funcName isEqualToString:@"sin"]) {
		return [[EPSinCosFunction alloc] initWithString:funcName];
	} else if ([funcName isEqualToString:@"atan"] || [funcName isEqualToString:@"tan"]) {
		return [[EPTanAtanFunction alloc] initWithString:funcName];
	} else if ([funcName isEqualToString:@"ln"] || [funcName isEqualToString:@"log"]) {
		return [[EPLogLnToken alloc] initWithString:funcName];
	} else if ([funcName isEqualToString:@"sqrt"]) {
		return [[EPSqrtFunction alloc] initWithString:funcName];
	}
	return nil;
#else
	if ([funcName isEqualToString:@"cos"] || [funcName isEqualToString:@"sin"]) {
		return [[[EPSinCosFunction alloc] initWithString:funcName] autorelease];
	} else if ([funcName isEqualToString:@"atan"] || [funcName isEqualToString:@"tan"]) {
		return [[[EPTanAtanFunction alloc] initWithString:funcName] autorelease];
	} else if ([funcName isEqualToString:@"ln"] || [funcName isEqualToString:@"log"]) {
		return [[[EPLogLnToken alloc] initWithString:funcName] autorelease];
	} else if ([funcName isEqualToString:@"sqrt"]) {
		return [[[EPSqrtFunction alloc] initWithString:funcName] autorelease];
	}
	return nil;
#endif
}

@end
