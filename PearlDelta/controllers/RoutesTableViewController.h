//
//  RoutesTableViewController.h
//  PearlDelta
//
//  Created by JERRY LIU on 12/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoutesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) NSString* departCity;
@property (nonatomic, strong) NSString* arrivalCity;
@property (nonatomic, strong) NSString* travelBy;

@end
