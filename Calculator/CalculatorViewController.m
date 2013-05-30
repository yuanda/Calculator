//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Feerin Fu on 5/24/13.
//  Copyright (c) 2013 TheBest. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"


@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize display = _display;
//synthesize creates setter(used by ios to set the pointer) and getter(called by the code to talk to the label)
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

-(CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    //UILabel *myDisplay = self.display; //[self display];
    //NSString *currentText = self.display.text; //[myDisplay text];
    //NSString *newText = [self.display.text stringByAppendingString:digit];
    if (self.userIsInTheMiddleOfEnteringANumber){
    self.display.text= [self.display.text stringByAppendingString:digit]; //[myDisplay setText:newText];
    }else{
        self.display.text=digit;
        self.userIsInTheMiddleOfEnteringANumber=YES;
    }
    
    //NSLog(@"digit pressed = %@", digit);
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber)[self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text= resultString;
    
}

@end
