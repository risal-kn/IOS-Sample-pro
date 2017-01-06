//
//  countryViewController.m
//  Sample
//
//  Created by Risal on 02/01/17.
//  Copyright © 2017 FLY. All rights reserved.
//

#import "countryViewController.h"
#import "CountryCell.h"
#import "Country.h"
@interface countryViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *arr;
    NSMutableArray *countrylist,*tempcountrylist;
}
@property (weak, nonatomic) IBOutlet UITableView *tbl_country;
@property (weak, nonatomic) IBOutlet UISearchBar *txt_search;

@end

@implementation countryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countrylist=[[NSMutableArray alloc] init];
    tempcountrylist=[[NSMutableArray alloc] init];
    [self fetchData];
    // Do any additional setup after loading the view.
    
    //arr =[[NSArray alloc] initWithObjects:[[NSDictionary alloc] initWithObjectsAndKeys:@"Risal",@"name",@"24",@"age",nil],[[NSDictionary alloc] initWithObjectsAndKeys:@"Abhi",@"name",@"24",@"age", nil],[[NSDictionary alloc] initWithObjectsAndKeys:@"Arun",@"name",@"28",@"age", nil],nil];
    //    for (int i=0; i<arr.count;i++) {
//        NSDictionary *dis=[arr objectAtIndex:i];
//        Country *country=[[Country alloc] init];
//        country.name=[dis objectForKey:@"name"];
//        country.capital=[dis objectForKey:@"age"];
//        [countrylist addObject:country];
//    
//    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(nonnull NSString *)searchText{
    
    if(searchText.length>0)
    {
    [countrylist removeAllObjects];
    for (Country *country in tempcountrylist)
    {
        if([country.name.uppercaseString containsString:searchText.uppercaseString])
        {
            [countrylist addObject:country]; //Store it in NSMutableArray
            //break;
        }
    }
    }else{
        [countrylist addObjectsFromArray:tempcountrylist];
    }
    
    [_tbl_country reloadData];
}
-(void)fetchData
{
    NSURL *url = [NSURL URLWithString:@"https://restcountries.eu/rest/v1/all"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSMutableArray *greeti = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             for(int i=0;i<greeti.count;i++)
             {
                 NSDictionary *item = [greeti objectAtIndex:i];
                 NSString *name=[item objectForKey:@"name"];
                 NSString *capital=[item objectForKey:@"capital"];
                 NSString *region=[item objectForKey:@"region"];
                 NSNumber *population=[item objectForKey:@"population"];
                 NSArray *borders=[item objectForKey:@"borders"];
                 Country *country=[[Country alloc] init];
                 country.name=name;
                 country.capital=capital;
                 country.region=region;
                 country.population=[population stringValue];
                 country.borders=borders;
                 [countrylist addObject:country];
                
             }
            [tempcountrylist addObjectsFromArray:countrylist];
             [_tbl_country reloadData];
        }
        
     }];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [countrylist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CountryCellID";
    
    CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CountryCell" owner:self options:nil];
        cell= [nib objectAtIndex:0];
    }
    //NSLog(@"%@.....",[countrylist objectAtIndex:indexPath.row]);
    Country *cntry=[countrylist objectAtIndex:indexPath.row];
    //cell.lbl_name.text=@"google";
    cell.lbl_name.text=cntry.name;
    cell.lbl_capital.text=cntry.capital;
    cell.lbl_population.text=cntry.population;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.borderWidth=1;
    cell.layer.borderColor=[UIColor grayColor].CGColor;
    // Configure the cell...
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Country *cntry=[countrylist objectAtIndex:indexPath.row];

    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:cntry.name
                                 message:cntry.region
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end