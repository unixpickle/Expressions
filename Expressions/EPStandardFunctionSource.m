//
//  EPStandardFunctionSource.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPStandardFunctionSource.h"

@implementation EPStandardFunctionSource

- (id)init {
	if ((self = [super init])) {
		// Initialization code here.
	}
	return self;
}

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
	
	return NO;
}

- (EPFunctionToken *)functionTokenForName:(NSString *)funcName {
	if ([funcName isEqualToString:@"cos"] || [funcName isEqualToString:@"sin"]) {
		return [[[EPSinCosFunction alloc] initWithString:funcName] autorelease];
	} else if ([funcName isEqualToString:@"atan"] || [funcName isEqualToString:@"tan"]) {
		return [[[EPTanAtanFunction alloc] initWithString:funcName] autorelease];
	} else if ([funcName isEqualToString:@"ln"] || [funcName isEqualToString:@"log"]) {
		return [[[EPLogLnToken alloc] initWithString:funcName] autorelease];
	}
	return nil;
}

@end
