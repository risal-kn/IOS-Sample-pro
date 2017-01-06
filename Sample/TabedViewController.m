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
   
    [self loadtabItems];
    
    
//    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    countryViewController *cs=[storybord instantiateViewControllerWithIdentifier:@"CountryView"];
//    [self addChildViewController:cs];
//    CalculatorViewController *cs1=[storybord instantiateViewControllerWithIdentifier:@"Calculatorview"];
//    [self addChildViewController:cs1];
}

-(void) loadtabItems
{
    
    
    for (int i=0;i<4;i++) {
        UIViewController *view1 = [[UIViewController alloc] init];
        switch (i) {
            case 0:
                [view1.view setBackgroundColor:[UIColor grayColor]];
                break;
            case 1:
                [view1.view setBackgroundColor:[UIColor greenColor]];
                break;
            case 2:
                [view1.view setBackgroundColor:[UIColor cyanColor]];
                break;
                
            default:
                 [view1.view setBackgroundColor:[UIColor greenColor]];
                break;
        }
        
        UITabBarItem *tabitem=[[UITabBarItem alloc] init];
        [tabitem setTitle:@"google"];
        [tabitem setImage:[UIImage imageNamed:@"email.png" ]];
        [tabitem setTag:2];
        [tabitem setBadgeColor:[UIColor redColor]];
        [tabitem setBadgeValue:@"2"];        [view1 setTabBarItem:tabitem];
        [self addChildViewController:view1];
    
    }
        //can't set this until after its added to the tab bar
  
   }
@end
