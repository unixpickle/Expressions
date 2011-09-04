//
//  EPTParentheses.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPToken.h"

typedef enum {
	EPTParenthesesOpen,
	EPTParenthesesClose
} EPTParenthesesDirection;

@interface EPParenthesesToken : EPToken {
	EPTParenthesesDirection direction;
}

- (EPTParenthesesDirection)direction;

@end
