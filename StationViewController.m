//
//  StationViewController.m
//  PearlDelta
//
//  Created by JERRY LIU on 18/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import "StationViewController.h"

@interface StationViewController ()

@end

@implementation StationViewController

@synthesize nameLabel, addressLabel, busLabel, subwayLabel;
@synthesize mapView;
@synthesize station, managedObjectContext;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    nameLabel.text = station.name;
    addressLabel.text = station.address;
    busLabel.text = station.bus;
    subwayLabel.text = station.subway;
    
    [self showMap];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showMap{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([self.station coordinate], 3000, 3000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}
//


@end
