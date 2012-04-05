//
//  EPLogLnToken.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPFunctionToken.h"

@interface EPLogLnFunction : EPFunctionToken {
	BOOL natural;
}

- (BOOL)isNatural;

@end
