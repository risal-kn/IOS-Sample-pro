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
#import "CoreDataViewControl.h"
#import <sys/utsname.h>

@interface ViewController ()
{
    NSArray *arr;
    
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@end

@implementation ViewController

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
// if([segue.identifier isEqualToString:@"CountryViewSeg"])
// {
//     countryViewController *cnt=[segue destinationViewController];
//     cnt.deligate=self;
//     
// }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self PhoneInformation];
    
}

-(void)PhoneInformation
{
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    NSString *name = [carrier carrierName];
    NSLog(@"%@ MCC......",mcc);
    NSLog(@"%@ MNC.......",mnc);
    NSLog(@"%@ MNC.......",name);
    
    NSString* UDID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"output is : %@", UDID);
    
    NSString *ss=[self deviceModelDetailsName];
    NSLog(@"Model output is : %@....", ss);
    NSString *cputype=[self getCPUtypeDetails];
    NSLog(@"CPU output is : %@....", cputype);
    
}

- (IBAction)callCoreData:(UIButton *)sender {
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CoreDataViewControl *cs=[storybord instantiateViewControllerWithIdentifier:@"coreDataViewControll"];
    [self.navigationController pushViewController:cs animated:YES];
 
}

-(NSString *)getCPUtypeDetails
{
    NSMutableString *cpu = [[NSMutableString alloc] init];
    size_t size;
    cpu_type_t type;
    cpu_subtype_t subtype;
    size = sizeof(type);
    sysctlbyname("hw.cputype", &type, &size, NULL, 0);
    
    size = sizeof(subtype);
    sysctlbyname("hw.cpusubtype", &subtype, &size, NULL, 0);
    
    // values for cputype and cpusubtype defined in mach/machine.h
    if (type == CPU_TYPE_X86)
    {
        [cpu appendString:@"x86 "];
        // check for subtype ...
        
    } else if (type == CPU_TYPE_ARM)
    {
        [cpu appendString:@"ARM"];
        switch(subtype)
        {
            case CPU_SUBTYPE_ARM_V7:
                [cpu appendString:@"V7"];
                break;
                // ...
        }
    }
    return cpu;
    
}

- (IBAction)Notification_action:(id)sender
{
//    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
//    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification)
    {
        NSDate *fireTime = [[NSDate date] addTimeInterval:5]; // adds 10 secs
        notification.fireDate = fireTime;
        notification.alertBody = @"Alert!";
        
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber = 1;
        notification.soundName = UILocalNotificationDefaultSoundName;
//        switch (_frequencySegmentedControl.selectedSegmentIndex) {
//            case 0:
//                notification.repeatInterval = NSCalendarUnitDay;
//                break;
//            case 1:
//                notification.repeatInterval = NSCalendarUnitWeekOfYear;
//                break;
//            case 2:
//                
//                
//                notification.repeatInterval = NSCalendarUnitYear;
//                break;
//            default:
//                notification.repeatInterval = 0;
//                break;
//        }
        notification.alertBody = @"_customMessage.text";
    }
    // this will schedule the notification to fire at the fire date
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    // this will fire the notification right away, it will still also fire at the date we set
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];

}




-(NSString *) deviceModelDetailsName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
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
            cs.deligate = self;
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

-(void)didSelectCountry:(countryViewController *)controler name:(NSString *)name{
    //[controler dismissViewControllerAnimated:YES completion:nil];
    [_lbl_name setText:name];
}

@end
