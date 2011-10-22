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
	return [[self retain] autorelease];
}

@end
