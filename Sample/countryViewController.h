//
//  countryViewController.h
//  Sample
//
//  Created by Risal on 02/01/17.
//  Copyright © 2017 FLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class countryViewController;
@protocol countryDeligate <NSObject>

-(void)didSelectCountry:(countryViewController *)controler name:(NSString *)name;

@end

@interface countryViewController : UIViewController

@property (weak,nonatomic) id<countryDeligate>deligate;

@end
