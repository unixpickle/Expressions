//
//  ExpressionToken.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This is an abstract class that represents a token in a mathematical
 * expression.  This should always be subclassed, and all of it's instance
 * methods should be overridden.
 */
@interface EPToken : NSObject {
	
}

- (id)initWithString:(NSString *)aString;
- (NSString *)toString;

@end
