//
//  EPTokenString.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPFunctionToken.h"
#import "EPAddSubOperator.h"
#import "EPMulDivOperator.h"
#import "EPPowerOperator.h"
#import "EPVariableToken.h"
#import "EPNumericalToken.h"
#import "EPParenthesesToken.h"

@protocol EPTokenStringVariableSource

- (BOOL)variableExists:(NSString *)varName;
- (double)variableValue:(NSString *)varName;

@end

@protocol EPTokenStringFunctionSource

- (BOOL)functionExists:(NSString *)funcName;
- (EPFunctionToken *)functionTokenForName:(NSString *)funcName;

@end

/**
 * This class encapsulates a string (or array) of tokens parsed
 * from a string.  If can also be used to parse a regular string
 * as a string of tokens.
 */
@interface EPTokenString : NSObject {
	NSArray * tokenArray;
}

/**
 * Create a new token string by parsing a mathematical expression.
 * @param expression The expression to parse.  If this expression is invalid, nil
 * will be returned.
 * @param variables The variable source to use for this expression.  If this is nil,
 * the expression will be assumed to have no variables.
 * @param functions The function source to use for this expression.  If this is nil,
 * the expression will be assumedd to have no functions.
 * @return A newly allocated token string, or nil if the expression could not be parsed.
 * @discussion It is important to remember that this does not fully evaluate the expression,
 * and therefore is not the best indicator of whether or not the expression is valid.
 */
- (id)initWithExpression:(NSString *)expression varSource:(id<EPTokenStringVariableSource>)variables
			  funcSource:(id<EPTokenStringFunctionSource>)functions;

/**
 * @return An array of tokens that were extracted from the expression.
 */
- (NSArray *)tokenArray;

/**
 * Cut out a series of tokens from the token string.
 * @param tokenRange The range of tokens to get.
 * @throws NSRangeException Thrown if the given range does not fit within the string.
 */
- (EPTokenString *)substringWithRange:(NSRange)tokenRange;

@end
