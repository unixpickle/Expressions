//
//  ExpressionToken.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPToken.h"

@implementation EPToken

- (id)initWithString:(NSString *)aString {
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"This is an abstract class and must be subclassed."
								 userInfo:nil];
}

- (NSString *)toString {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"This is an abstract class and must be subclassed."
								 userInfo:nil];
}

- (id)negativeToken {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"This is an abstract class and must be subclassed."
								 userInfo:nil];
}

- (id)copyWithZone:(NSZone *)zone {
	return nil;
}

@end
