//
//  CoreDataViewControl.m
//  Sample
//
//  Created by Risal on 17/01/17.
//  Copyright © 2017 FLY. All rights reserved.
//

#import "CoreDataViewControl.h"
#import "CoreDataCell.h"
@interface CoreDataViewControl ()
@property (weak, nonatomic) IBOutlet UITextField *txt_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_version;
@property (weak, nonatomic) IBOutlet UITextField *txt_company;
@property(strong,nonatomic) NSMutableArray *devices;
@property (nonatomic, strong) NSManagedObjectContext* mainContext;
@end

@implementation CoreDataViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mainContext=[self managedObjectContext];
    //_mainContext=self.managedObjectContext;
      [self selectDataFromDataBase];
}

- (IBAction)saveEntity:(UIBarButtonItem *)sender {

    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:_mainContext];
    [newDevice setValue:self.txt_name.text forKey:@"name"];
    [newDevice setValue:self.txt_version.text forKey:@"version"];
    [newDevice setValue:self.txt_company.text forKey:@"company"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![_mainContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
   [self selectDataFromDataBase];
   // [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)selectDataFromDataBase
{
    //NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
    self.devices = [[_mainContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for (int i=0;i<_devices.count;i++) {
        NSLog(@"Save! %@", @"getdata");
        NSManagedObject *device = [self.devices objectAtIndex:i];
        NSString *name=[NSString stringWithFormat:@"%@",[device valueForKey:@"name"]];
        NSLog(@"Save! %@",[device valueForKey:@"name"]);
    }
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.devices.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"coredataCell";
    CoreDataCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CoreDataCell" owner:self options:nil];
        cell= [nib objectAtIndex:0];
    }
    // Configure the cell...
    NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
    [cell.lb_name setText:[NSString stringWithFormat:@"%@ %@", [device valueForKey:@"name"],[device valueForKey:@"version"]]];
    [cell.lb_version setText:[device valueForKey:@"company"]];
    
    return cell;
}

@end
