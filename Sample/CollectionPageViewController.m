//
//  CollectionPageViewController.m
//  Sample
//
//  Created by Risal on 04/01/17.
//  Copyright © 2017 FLY. All rights reserved.
//

#import "CollectionPageViewController.h"
#import "SingleCell.h"
@interface CollectionPageViewController ()
{
    NSArray *images;
}
@end

@implementation CollectionPageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    images=[NSArray arrayWithObjects :@"image1.jpg",@"india.jpg",@"uk.png",@"image1.jpg",@"india.jpg",@"uk.png", nil ];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SingleCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    SingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
   
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SingleCell" owner:self options:nil];
        cell= [nib objectAtIndex:0];
    }
    [cell setBackgroundColor:[UIColor redColor]];

//      UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    [cell.Img_cell setImage:[UIImage imageNamed:[images objectAtIndex:indexPath.row]]];
    [cell.txt_cell setText:@"google"];
//     recipeImageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];   
  return cell;
}
@end
