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

    nameLabel.text = station.name;
    addressLabel.text = station.address;
    busLabel.text = station.bus;
    busLabel.numberOfLines = 0;
    
    subwayLabel.text = station.subway;
    subwayLabel.numberOfLines = 0;
    
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

    if(self.station.latitude && self.station.longitude) {
        [self.mapView addAnnotation:self.station];
        [self.mapView selectAnnotation:self.station animated:YES];
    } else {
        NSString* title = NSLocalizedString(@"MAP_NOT_FOUND_TITLE", nil);
        NSString* message = NSLocalizedString(@"MAP_NOT_FOUND_MSG", nil);
        NSString* btnText = NSLocalizedString(@"MAP_NOT_FOUND_BTN", nil);
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:btnText otherButtonTitles:nil, nil];
        [alert show];
    }
}

# pragma mark - tableviewcelldelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //subway and bus cells only
    if (indexPath.row == 2 || indexPath.row == 3){
        
        UILabel* stretchLabel;
        switch (indexPath.row) {
            case 2:
                stretchLabel = busLabel;
                break;
            case 3:
                stretchLabel = subwayLabel;
            default:
                break;
        }
        CGSize constraintSize = CGSizeMake(200.0f, MAXFLOAT);
        CGSize labelSize = [stretchLabel.text sizeWithFont:[UIFont systemFontOfSize:12]
                            constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
            
        return fmax(labelSize.height+20,44.0);
    }
    return 44.0;
}
@end
