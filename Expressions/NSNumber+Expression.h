//
//  NSNumber+Expression.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPExpression.h"
#import "EPDictionaryVariableSource.h"
#import "EPStandardFunctionSource.h"

@interface NSNumber (Expression)

+ (NSNumber *)numberByParsingExpression:(NSString *)expression;
+ (NSNumber *)numberByParsingExpression:(NSString *)expression withVariables:(NSDictionary *)varDictionary;

@end
