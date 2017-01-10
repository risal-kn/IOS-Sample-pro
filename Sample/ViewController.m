//
//  ViewController.m
//  Sample
//
//  Created by Risal on 29/12/16.
//  Copyright © 2016 FLY. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "countryViewController.h"
#import "CollectionPageViewController.h"
#import "TabedViewController.h"
@interface ViewController ()
{
    NSArray *arr;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (IBAction)onClick:(id)sender {
    [self NavigationSecond];
    NSLog(@"%@",@"Hello World");
   }
- (IBAction)StoryBord_Action:(UIButton *)sender {
    [self storybordNavigation];
    NSLog(@"%@",@"Hello World");
}
- (IBAction)Collection_PageAction:(UIButton *)sender {
    [self GotoCollectionPage];
}

- (IBAction)TabedView_action:(id)sender {
    [self GotoTabedAction];
}

-(void)GotoTabedAction
{
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TabedViewController *cs=[storybord instantiateViewControllerWithIdentifier:@"TabedView"];
    [self.navigationController pushViewController:cs animated:YES];
}

- (IBAction)GotoSegmentControl:(UIButton *)sender {
    [self GotoSegmentAction];
}


-(void)GotoSegmentAction
{
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TabedViewController *cs=[storybord instantiateViewControllerWithIdentifier:@"SegmentView"];
    [self.navigationController pushViewController:cs animated:YES];
}


// show alers
-(void)alertDisplay
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"My Title"
                                  message:@"Enter User Credentials"
                                  
                                  preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
  
}
-(void) NavigationSecond
{
    
         UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
         countryViewController *cs=[storybord instantiateViewControllerWithIdentifier:@"CountryView"];
         [self.navigationController pushViewController:cs animated:YES];

    
}

-(void) GotoCollectionPage
{
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CollectionPageViewController *cs=[storybord instantiateViewControllerWithIdentifier:@"CollectionView"];
    [self.navigationController pushViewController:cs animated:YES];
}



-(void) storybordNavigation
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    UINavigationController *cs = [storyBoard instantiateViewControllerWithIdentifier:@"SecondView"];
    [self.navigationController pushViewController:cs animated:YES];
}
@end
