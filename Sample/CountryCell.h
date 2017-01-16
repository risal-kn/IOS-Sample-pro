//
//  CountryCell.h
//  Sample
//
//  Created by Risal on 02/01/17.
//  Copyright © 2017 FLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_single;
@property (weak, nonatomic) IBOutlet UIImageView *image_view;

@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_capital;
@property (weak, nonatomic) IBOutlet UILabel *lbl_population;

@end
