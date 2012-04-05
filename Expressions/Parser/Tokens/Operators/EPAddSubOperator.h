//
//  EPAddSubOperator.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPOperator.h"

/**
 * An operator that will result in either the addition or subtraction
 * of the second operator from the first.
 */
@interface EPAddSubOperator : EPOperator {
	BOOL isSubtraction;
}

- (BOOL)isSubtraction;

@end
