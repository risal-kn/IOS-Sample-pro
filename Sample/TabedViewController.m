//
//  TabedViewController.m
//  Sample
//
//  Created by Risal on 05/01/17.
//  Copyright © 2017 FLY. All rights reserved.
//

#import "TabedViewController.h"
#import "countryViewController.h"
#import "CalculatorViewController.h"
@interface TabedViewController ()

@end

@implementation TabedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    countryViewController *cs=[storybord instantiateViewControllerWithIdentifier:@"CountryView"];
    
    [self addChildViewController:cs];
    
        CalculatorViewController *cs1=[storybord instantiateViewControllerWithIdentifier:@"Calculatorview"];
    
    
    [self addChildViewController:cs1];
}



@end
