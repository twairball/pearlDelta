//
//  PearlDeltaViewController.m
//  PearlDelta
//
//  Created by JERRY LIU on 8/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import "PearlDeltaViewController.h"
#import "Trip.h"
#import "RoutesTableViewController.h"

@interface PearlDeltaViewController ()

@end

@implementation PearlDeltaViewController {
    Trip* trip;
}

@synthesize managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDefaults];
    [self makeButtons];
    [self updateLabels];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeButtons {
    UIImage *orangeButtonImage = [[UIImage imageNamed:@"orangeButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *orangeButtonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    // doneButton in orange bg / white text
    [self.doneButton setBackgroundImage:orangeButtonImage forState:UIControlStateNormal];
    [self.doneButton setBackgroundImage:orangeButtonImageHighlight forState:UIControlStateHighlighted];
    
    UIImage *blueButtonImage = [[UIImage imageNamed:@"blueButton.png"]
                                  resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *blueButtonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight.png"]
                                           resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    // departButton & arrivalButton in blue background / white text
    [self.departButton setBackgroundImage:blueButtonImage forState:UIControlStateNormal];
    [self.departButton setBackgroundImage:blueButtonImageHighlight forState:UIControlStateHighlighted];
    [self.arrivalButton setBackgroundImage:blueButtonImage forState:UIControlStateNormal];
    [self.arrivalButton setBackgroundImage:blueButtonImageHighlight forState:UIControlStateHighlighted];
    
}

- (void)setDefaults {
    trip = [[Trip alloc] initWithDepartCity:NSLocalizedString(@"INIT_DEPART_CITY", nil)
                                arrivalCity: NSLocalizedString(@"INIT_ARRIVAL_CITY", nil)];
}

- (void)updateLabels {
    self.departLabel.text = trip.departCity;
    self.arrivalLabel.text = trip.arrivalCity;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    if ([segue.identifier isEqualToString:@"departCity"]) {
        CityPickerViewController *cityPicker = segue.destinationViewController;
        cityPicker.delegate = self;
        cityPicker.cities = [trip cityListForDeparture];
        cityPicker.pickCity = trip.departCity;
        cityPicker.pickingFor = @"departCity";
        
    } else if ([segue.identifier isEqualToString:@"arrivalCity"]) {
        CityPickerViewController *cityPicker = segue.destinationViewController;
        cityPicker.delegate = self;
        cityPicker.cities = [trip cityListForArrival];
        cityPicker.pickCity = trip.arrivalCity;
        cityPicker.pickingFor = @"arrivalCity";
    
    } else if ([segue.identifier isEqualToString:@"findRoutes"]) {
        
        RoutesTableViewController* routesController = segue.destinationViewController;
        routesController.departCity = trip.departCity;
        routesController.arrivalCity = trip.arrivalCity;
        routesController.managedObjectContext = self.managedObjectContext;
        
    }
    
    
}
#pragma mark -
#pragma CityPickerViewControllerDelegate methods
- (void)cityPickerDidCancel:(CityPickerViewController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cityPicker:(CityPickerViewController *)picker didPickCity:(NSString *)city {
    
    if ([picker.pickingFor isEqualToString:@"departCity"]) {
        trip.departCity = city;
        [self updateLabels];
        
    } else if ([picker.pickingFor isEqualToString:@"arrivalCity"]) {
        trip.arrivalCity = city;
        [self updateLabels];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
