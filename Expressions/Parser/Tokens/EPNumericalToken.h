//
//  EPNumericalToken.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPToken.h"

@interface EPNumericalToken : EPToken {
	double doubleValue;
}

- (id)initWithDouble:(double)dVal;
+ (EPNumericalToken *)numericalTokenWithDouble:(double)dVal;

- (double)doubleValue;

@end
