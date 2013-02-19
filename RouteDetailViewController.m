//
//  RouteDetailViewController.m
//  PearlDelta
//
//  Created by JERRY LIU on 15/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import "RouteDetailViewController.h"
#import "Operator.h"
#import "Station.h"
#import "StationViewController.h"

@interface RouteDetailViewController ()

@end

@implementation RouteDetailViewController {
    
}

@synthesize departLabel, arrivalLabel;

@synthesize durationLabel, priceLabel, scheduleLabel, departStationLabel, arrivalStationLabel, operatorNameLabel, operatorTelLabel, operatorWebLabel;

@synthesize route;
@synthesize managedObjectContext;

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

    if (self.route) {
        self.departLabel.text = route.departStation.name;
        self.arrivalLabel.text = route.arrivalStation.name;
        self.durationLabel.text = [NSString stringWithFormat:@"%@分鐘", route.duration];
        self.travelByIcon.image =  [UIImage imageNamed:route.travelBy];
        //schedule TBD
        self.scheduleLabel.text = route.schedule;
        self.scheduleLabel.numberOfLines = 0;
                
        //cell.textLabel.numberOfLines = 0; cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.departStationLabel.text = route.departStation.name;
        self.arrivalStationLabel.text = route.arrivalStation.name;
        
        self.operatorNameLabel.text = route.operator.name;
        self.operatorTelLabel.text = route.operator.tel;
        self.operatorWebLabel.text =  route.operator.website;
        
        self.title = [NSString stringWithFormat:@"%@ - %@",route.departCity, route.arrivalCity];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"stationAddress"]) {
        StationViewController* stationController = segue.destinationViewController;
        
        stationController.managedObjectContext = self.managedObjectContext;
        stationController.station = sender;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows = 4;
    switch (section) {
        case 0: rows = 3;
        case 1: rows = 2;
        case 2: rows = 3;
    }
    return rows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath: %@", indexPath);
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    switch (section) {
        case 1:
            switch (row){
                case 0: [self performSegueWithIdentifier:@"stationAddress" sender:route.departStation];
                    break;
                case 1: [self performSegueWithIdentifier:@"stationAddress" sender:route.arrivalStation];
                    break;
            }
        case 2:
            switch(row) {
                case 1:NSLog(@"operator tel clicked:");
                    break;
                case 2:NSLog(@"operator web clicked:");
                    break;
            }
    }
}


@end
