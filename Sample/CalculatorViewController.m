//
//  CalculatorViewController.m
//  Sample
//
//  Created by Risal on 29/12/16.
//  Copyright © 2016 FLY. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
{
    double tempResult;
    double result;
    bool clearFlag;
    bool isOperation;
    NSInteger op;
}
@property (weak, nonatomic) IBOutlet UILabel *txt_value;
@end

@implementation CalculatorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    result=0;
    tempResult = 0;
    op=0;
    clearFlag = true;
    isOperation = false;
    // Do any additional setup after loading the view.
}

- (IBAction)onClick:(UIButton *)sender {
    if (clearFlag) {
        _txt_value.text = @"";
        clearFlag = false;
    }
    isOperation = false;
    switch (sender.tag) {
        case 1:
            self.txt_value.text=[_txt_value.text stringByAppendingString:@"1"];
            break;
        case 2:
            _txt_value.text=[_txt_value.text stringByAppendingString:@"2"];
            break;
        case 3:
            _txt_value.text=[_txt_value.text stringByAppendingString:@"3"];
            break;
        case 4:
            _txt_value.text=[_txt_value.text stringByAppendingString:@"4"];
            break;
        case 5:
            _txt_value.text=[_txt_value.text stringByAppendingString:@"5"];
            break;
        case 6:
            _txt_value.text=[_txt_value.text stringByAppendingString:@"6"];
            break;
        case 7:
            _txt_value.text=[_txt_value.text stringByAppendingString:@"7"];
            break;
        case 8:
            _txt_value.text=[_txt_value.text stringByAppendingString:@"8"];
            break;
        case 9:
            _txt_value.text=[_txt_value.text stringByAppendingString:@"9"];
            break;
        case 0:
            _txt_value.text=[_txt_value.text stringByAppendingString:@"0"];
            break;
        case 10:
            _txt_value.text=[_txt_value.text stringByAppendingString:@"."];
            break;
    
        default:
            break;
    }
    
}

- (IBAction)equalAction:(id)sender {
    [self calculation:0];
    result=0;
   }

- (IBAction)operatorAction:(UIButton *)sender {
 
    if (!isOperation)
    {
    [self calculation:sender.tag];
        isOperation = true;
    }
    else
    {
        op = sender.tag;
    }
}

-(void) calculation:(NSInteger)sender
{
    tempResult = [_txt_value.text doubleValue];
    switch (op) {
        case 100:
            result+= [_txt_value.text doubleValue];
            break;
        case 101:
            result-= [_txt_value.text doubleValue];
            break;
            
        case 102:
            result*= [_txt_value.text doubleValue];
            break;
            
        case 103:
            result/= [_txt_value.text doubleValue];
            break;
            
        default:
            result = tempResult;
            break;
    }
    op=sender;
    NSNumber *resultNumber = [NSNumber numberWithDouble:result];
    _txt_value.text=[resultNumber stringValue];
    clearFlag = true;
}

@end
