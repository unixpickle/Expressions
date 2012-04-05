//
//  EPOperator.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPNumericalToken.h"

/**
 * An abstract class that represents a numerical operator.
 * This must always be subclassed, and all class methods must
 * be overriden.
 */
@interface EPOperator : EPToken {
	
}

- (EPNumericalToken *)applyLeftOperand:(id)anOperand toRight:(id)anotherOperand;

@end
