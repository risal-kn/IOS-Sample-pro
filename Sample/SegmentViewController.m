//
//  SegmentViewController.m
//  Sample
//
//  Created by Risal on 09/01/17.
//  Copyright © 2017 FLY. All rights reserved.
//

#import "SegmentViewController.h"

@interface SegmentViewController ()
@property (weak, nonatomic) IBOutlet UIView *View1;
@property (weak, nonatomic) IBOutlet UIView *View2;
@property (weak, nonatomic) IBOutlet UIView *View3;
@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.View1 setBackgroundColor:[UIColor redColor]];
     [self.View2 setBackgroundColor:[UIColor blueColor]];
    [self.View3 setBackgroundColor:[UIColor greenColor]];
}
- (IBAction)change_index:(id)sender {
 
    switch (self.segmentCotrol.selectedSegmentIndex)
    {
        case 0:
            [_View1 setHidden:NO];
            [_View2 setHidden:YES];
            [_View3 setHidden:YES];
            break;
        case 1:
            [_View1 setHidden:YES];
            [_View2 setHidden:NO];
            [_View3 setHidden:YES];
            break;
        case 2:
            [_View1 setHidden:YES];
            [_View2 setHidden:YES];
            [_View3 setHidden:NO];
            break;
        default:
            break; 
    }
    
}


@end
