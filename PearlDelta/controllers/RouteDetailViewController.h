//
//  RouteDetailViewController.h
//  PearlDelta
//
//  Created by JERRY LIU on 15/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@interface RouteDetailViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *departLabel;
@property (strong, nonatomic) IBOutlet UILabel *arrivalLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *travelByIcon;

@property (strong, nonatomic) IBOutlet UILabel *departStationLabel;
@property (strong, nonatomic) IBOutlet UILabel *arrivalStationLabel;

@property (strong, nonatomic) IBOutlet UILabel *operatorNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *operatorTelLabel;
@property (strong, nonatomic) IBOutlet UILabel *operatorWebLabel;

@property (strong, nonatomic) Route* route;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@end
