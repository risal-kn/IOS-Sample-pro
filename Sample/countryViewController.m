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
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)

@interface countryViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *arr;
    NSMutableArray *countrylist,*tempcountrylist;
}

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UITableView *tbl_country;
@property (weak, nonatomic) IBOutlet UISearchBar *txt_search;
@property (weak, nonatomic) IBOutlet UITextField *tf_search;

@end

@implementation countryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITextField *searchField;
    NSUInteger numViews = [_txt_search.subviews count];
    for (int i = 0; i < numViews; i++) {
        if ([[_txt_search.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) { //conform?
            searchField = [_txt_search.subviews objectAtIndex:i];
        }
    }
    if (searchField) {
        searchField.textColor = [UIColor redColor];
        searchField.placeholder=@"Search";
        [searchField setBackgroundColor:[UIColor whiteColor]]; //set your gray background image here
        [searchField setBorderStyle:UITextBorderStyleNone];
    }
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



- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.map setRegion:[self.map regionThatFits:region] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*1000, 0.5*1000);
    [_map setRegion:viewRegion animated:YES];
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
    }
    else
    {
        [countrylist addObjectsFromArray:tempcountrylist];
    }
    
    [_tbl_country reloadData];
}


-(void)fetchData
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setColor:[UIColor redColor]];
    CGRect frame = spinner.frame;
    frame.origin.x = (SCREEN_WIDTH/ 2 - frame.size.width / 2);
    frame.origin.y = (SCREEN_HEIGHT / 2 - frame.size.height / 2);
    spinner.frame = frame;
    [self.view addSubview:spinner];
    [spinner startAnimating];
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
             //[spinner stopAnimating];
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
- (IBAction)Back_action:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    cell.image_view.layer.cornerRadius=cell.image_view.frame.size.width/2;
    cell.image_view.clipsToBounds = YES;
    cell.lbl_name.text=cntry.name;
    cell.lbl_capital.text=cntry.capital;
    cell.lbl_population.text=cntry.population;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.layer.borderWidth=1;
    cell.view_single.layer.cornerRadius=10;
    cell.view_single.backgroundColor=[UIColor whiteColor];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    //cell.layer.cornerRadius=10;
    //cell.layer.borderColor=[UIColor grayColor].CGColor;
    // Configure the cell...
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    //this is the space
    return 10;
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
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                                   [self.deligate didSelectCountry:self name:cntry.name];
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
