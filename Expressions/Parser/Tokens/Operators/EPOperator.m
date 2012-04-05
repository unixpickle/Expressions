//
//  EPOperator.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPOperator.h"

@implementation EPOperator

- (id)applyLeftOperand:(id)anOperand toRight:(id)anotherOperand {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"This is an abstract class and must be subclassed."
								 userInfo:nil];
}

- (id)negativeToken {
#if !__has_feature(objc_arc)
    return [[self retain] autorelease];
#else
    return self;
#endif
}

- (id)copyWithZone:(NSZone *)zone {
	return [[[self class] allocWithZone:zone] initWithString:[self toString]];
}

@end
