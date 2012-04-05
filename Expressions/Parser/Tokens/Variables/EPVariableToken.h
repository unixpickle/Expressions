//
//  EPVariableToken.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPToken.h"

@interface EPVariableToken : EPToken {
	NSString * variableName;
	double doubleValue;
}

@property (readwrite) double doubleValue;

- (NSString *)variableName;

@end
