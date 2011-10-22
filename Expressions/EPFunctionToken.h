//
//  EPFunctionToken.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPNumericalToken.h"

/**
 * This is an abstract class for a mathematical function.  This should be subclassed,
 * and the applyToOperand method should be overridden.
 */
@interface EPFunctionToken : EPToken <NSCopying> {
	NSString * functionName;
	BOOL negated;
}

@property (readwrite) BOOL negative;

- (id)initWithString:(NSString *)aString;

- (NSString *)functionName;

/**
 * Method must be overridden by a subclass.
 */
- (EPNumericalToken *)applyToOperandAbsolute:(id)anOperand;

/**
 * Returns result of passing -applyToOperandAbsolute to -applyNegationToPositive.
 */
- (EPNumericalToken *)applyToOperand:(id)anOperand;
- (EPNumericalToken *)applyNegationToPositive:(EPNumericalToken *)theResult;

@end
