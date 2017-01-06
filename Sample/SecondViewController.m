//
//  SecondViewController.m
//  Sample
//
//  Created by Risal on 29/12/16.
//  Copyright © 2016 FLY. All rights reserved.
//

#import "SecondViewController.h"
#import "student.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *wview;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlString = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_wview loadRequest:urlRequest];
    student *stud=[[student alloc] init];
   
}
- (IBAction)back:(id)sender {
    
    if ([_wview canGoBack]) {
        [_wview goBack];
    }
}
- (IBAction)forward:(id)sender {
    if ([_wview canGoForward]) {
        [_wview goForward];
    }
}

@end
