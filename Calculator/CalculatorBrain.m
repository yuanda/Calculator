			//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Feerin Fu on 5/24/13.
//  Copyright (c) 2013 TheBest. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)operandStack
{
    if (!_programStack) _programStack = [[NSMutableArray alloc] init]; // lazy instantiaztion
    return _programStack;
}


-(void)pushOperand:(double)operand{
    //NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

-(double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject != nil) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

-(double)performOperation:(NSString *)operation{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

- (id) program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this in Assignment 2";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]){
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]){
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([@"*" isEqualToString:operation]){
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([@"-" isEqualToString:operation]){
            result = [self popOperandOffStack:stack] - [self popOperandOffStack:stack];
        }else if([@"/" isEqualToString:operation]){
            double divisor = [self popOperandOffStack:stack];
            if(divisor){
                result = [self popOperandOffStack:stack] / divisor;
            }else{
                result = 0;
            }
            
        }
         
    }
    //[self pushOperand:result];
    return result;
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"stack = %@", self.operandStack];
}

@end
