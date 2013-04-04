//
//  RoutesTableViewController.m
//  PearlDelta
//
//  Created by JERRY LIU on 12/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import "RoutesTableViewController.h"
#import "RouteDetailViewController.h"
#import "Route.h"
#import "Station.h"

@interface RoutesTableViewController ()

@end

@implementation RoutesTableViewController {
    BOOL noResultsToDisplay;
    Route* selectedRoute;
}

@synthesize departCity, arrivalCity, travelBy, managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

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
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    noResultsToDisplay = (BOOL)([[[self fetchedResultsController] fetchedObjects] count] == 0);
        
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.backBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil];
    
    self.title = [NSString stringWithFormat:@"%@ - %@",self.departCity, self.arrivalCity];
}

- (void)viewWillAppear:(BOOL)animated  {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidUnload {
    self.fetchedResultsController = nil;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    //fetch entity Route
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Route" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
 
    //fetch predicate based on request variables
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"departCity == %@ AND arrivalCity == %@",
                              self.departCity, self.arrivalCity];
    NSLog(@"predicate: %@", predicate);
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *departStationSort = [[NSSortDescriptor alloc]
                              initWithKey:@"departStation" ascending:YES];
    NSSortDescriptor *travelBySort = [[NSSortDescriptor alloc]
                                           initWithKey:@"travelBy" ascending:YES];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:departStationSort, travelBySort, nil]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:@"travelBy"
                                                   cacheName:nil];
    
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"routeDetail"]) {
        
        RouteDetailViewController* routeDetail= segue.destinationViewController;
        
        routeDetail.managedObjectContext = self.managedObjectContext;
        routeDetail.route = sender;
    }
}


#pragma mark - Table view data source

- (void)configureCell:(UITableViewCell *)cell atIndexPath:indexPath {
    Route* route = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    UILabel* departStationLabel = (UILabel*)[cell viewWithTag:3001];
    UILabel* arrivalStationLabel = (UILabel*)[cell viewWithTag:3002];
    UILabel* durationLabel = (UILabel*)[cell viewWithTag:3003];
    UILabel* priceLabel = (UILabel*)[cell viewWithTag:3004];
    UIImageView* travelByIcon = (UIImageView*)[cell viewWithTag:3005];
    
    departStationLabel.text = route.departStation.name;
    arrivalStationLabel.text = route.arrivalStation.name;
    durationLabel.text = [NSString stringWithFormat:@"%@%@", route.duration,NSLocalizedString(@"MINS", nil)];
    priceLabel.text = [NSString stringWithFormat:@"$%@", route.price];
    travelByIcon.image = [UIImage imageNamed:route.travelBy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(noResultsToDisplay) {
        return 1;
    } else {
        id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (noResultsToDisplay && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"noResultsCell" forIndexPath:indexPath];
        cell.textLabel.text = NSLocalizedString(@"NO_RESULTS_CELL", nil);
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"routeCell" forIndexPath:indexPath];
        // Configure the cell...
        [self configureCell:cell atIndexPath:indexPath];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Route* route = [_fetchedResultsController objectAtIndexPath:indexPath];
    selectedRoute = route;
    [self performSegueWithIdentifier:@"routeDetail" sender:route];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    
    NSString* title;
    if ([[sectionInfo name] isEqualToString:@"train"]) {
        title = NSLocalizedString(@"TRAIN", nil);
    } else if ([[sectionInfo name] isEqualToString:@"ferry"]) {
        title = NSLocalizedString(@"FERRY", nil);
    } else {
        title = [sectionInfo name];
    }
    return title;
}

#pragma mark - Fetched controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


@end
