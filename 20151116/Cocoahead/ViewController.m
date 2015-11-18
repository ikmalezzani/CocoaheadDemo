//
//  ViewController.m
//  Cocoahead
//
//  Created by Ikmal Ezzani on 11/13/15.
//  Copyright © 2015 Mindvalley. All rights reserved.
//

#import "ViewController.h"
#import "NSNumber+Math.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField      *textFieldOutput;
@property (nonatomic, strong)          NSString         *operator;
@property (nonatomic, strong)          NSMutableArray   *values;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.values = @[].mutableCopy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedOperator:(UIButton *)button
{
    NSString *operator = button.titleLabel.text;
    if ([operator isEqualToString:@"="]) {
        [self sum];
    }
    else {
        self.operator = operator;
    }
}

- (IBAction)tappedValues:(UIButton *)button
{
    NSNumber *value = @([button.titleLabel.text integerValue]);
    [self.textFieldOutput setText:[value stringValue]];
    
    // @warning: for simplication, there will be bug when values is added more than one.
    // instead of "21", it will become "2, 1"
    // @see Formulas project for better calculator App
    [self.values addObject:value];
}

- (void)sum
{
    NSNumber *lhs = [self.values objectAtIndex:0];
    NSNumber *rhs = [self.values objectAtIndex:1];
    
    NSNumber *sum = @(0);

    if ([self.operator isEqualToString:@"+"]) {
        sum = [lhs plus:rhs];
        [self.textFieldOutput setText:[sum stringValue]];
    }
    else if ([self.operator isEqualToString:@"-"]) {
        sum = [lhs minus:rhs];
        [self.textFieldOutput setText:[sum stringValue]];
    }


    self.values = @[].mutableCopy;
}

@end
