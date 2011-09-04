//
//  EPDictionaryVariableSource.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPDictionaryVariableSource.h"

@implementation EPDictionaryVariableSource

- (id)init {
	if ((self = [super init])) {
		// Initialization code here.
	}
	return self;
}

- (id)initWithDictionary:(NSDictionary *)varInfo {
	if ((self = [super init])) {
		varDictionary = [varInfo copyWithZone:NSDefaultMallocZone()];
	}
	return self;
}

- (BOOL)variableExists:(NSString *)varName {
	if ([varDictionary objectForKey:varName]) return YES;
	if ([varName isEqualToString:@"pi"]) return YES;
	return NO;
}

- (double)variableValue:(NSString *)varName {
	if ([varName isEqualToString:@"pi"]) {
		return M_PI;
	}
	return [[varDictionary objectForKey:varName] doubleValue];
}

- (void)dealloc {
	[varDictionary release];
	[super dealloc];
}

@end
