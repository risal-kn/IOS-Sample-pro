//
//  ViewController.h
//  Sample
//
//  Created by Risal on 29/12/16.
//  Copyright © 2016 FLY. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "countryViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#include <mach/machine.h>


@interface ViewController : UIViewController <countryDeligate>

@property (weak, nonatomic) IBOutlet UIButton *btn_google;

- (IBAction)onClick:(id)sender;

@end

