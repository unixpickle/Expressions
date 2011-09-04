Mathematical Expressions
========================

"In mathematics, an expression is a finite combination of symbols that are well-formed according to the rules applicable in the context at hand." --Wikipedia

What Can it Do?
===============

This expression parser can process and evaluate a string as an expression, returning a numerical result that can be better interpreted by the program.  This can be used for applications such as graphers and calculators.  The parser can even take custom functions and variables into account while parsing.

Usage
=====

Using the expression parser is quite straight forward and makes expression parsing a one-liner.  In order to use the set of parsing classes with your project, you will have to manually copy over all of the source files from this project.  Once that is done, you can parse expressions like this:

```Objective-C
#import "NSNumber+Expression.h"
...
NSDictionary * vars = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithDouble:90], @"x",
                                       [NSNumber numberWithDouble:180], @"y", nil];

NSNumber * parsed90 = [NSNumber numberByParsingExpression:@"sin(x(pi/180))" withVariables:vars];
NSLog(@"sin(90): %@", parsed90);

NSNumber * parsed180 = [NSNumber numberByParsingExpression:@"sin ( y * ( pi / 180 ) )" withVariables:vars];
NSLog(@"sin(180): %@", parsed180);
```

If an invalid expression or an expression with non-existing functions or variables is passed to ```numberByParsingExpression:withVariables:```, the returned NSNumber will be ```nil```.