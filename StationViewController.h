//
//  StationViewController.h
//  PearlDelta
//
//  Created by JERRY LIU on 18/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"

@interface StationViewController : UITableViewController <MKMapViewDelegate, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *busLabel;
@property (strong, nonatomic) IBOutlet UILabel *subwayLabel;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) Station* station;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@end
