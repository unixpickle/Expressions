//
//  EPDictionaryVariableSource.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPTokenString.h"

@interface EPDictionaryVariableSource : NSObject <EPTokenStringVariableSource> {
	NSDictionary * varDictionary;
}

- (id)initWithDictionary:(NSDictionary *)varInfo;

@end
