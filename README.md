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

# License

Expressions is licensed under the BSD 2-clause license.

```
Copyright (c) 2014, Alex Nichol.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer. 
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```