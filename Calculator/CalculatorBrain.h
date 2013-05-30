//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Feerin Fu on 5/24/13.
//  Copyright (c) 2013 TheBest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;

@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;


@end
