//
//  PearlDeltaAppDelegate.m
//  PearlDelta
//
//  Created by JERRY LIU on 8/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import "PearlDeltaAppDelegate.h"
#import "PearlDeltaViewController.h"
#import "Route.h"
#import "Operator.h"
#import "Station.h"

@implementation PearlDeltaAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[self makeAndSaveData];
    
    // Test listing all Routes from the store
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Operator"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (Operator* op in fetchedObjects) {
        NSLog(@"Operator:%@, tel:%@, url:%@", op.name, op.tel, op.website);
        for (Route *route in op.routes) {
            NSLog(@"    Depart: %@ / %@, Arrival: %@ / %@, travelBy: %@, duration: %@", route.departCity, route.departStation.name, route.arrivalCity, route.arrivalStation.name, route.travelBy, route.duration);
//            for (Schedule* schedule in route.schedules) {
//                NSLog(@"        depart: %@, arrival: %@", schedule.departTime, schedule.arrivalTime);
//            }
        }
    }
    // pass managedObjectContext;
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    PearlDeltaViewController *controller = (PearlDeltaViewController *)navigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    
    // Override point for customization after application launch.
    return YES;
}

-(void)makeAndSaveData {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    Operator* op1 = [NSEntityDescription insertNewObjectForEntityForName:@"Operator" inManagedObjectContext:context];
    op1.name = @"广深铁路";
    op1.tel = @"+852 555-5555";
    op1.website = @"http://www.gsrc.com/";
    
    Operator* op2 = [NSEntityDescription insertNewObjectForEntityForName:@"Operator" inManagedObjectContext:context];
    op2.name = @"KCRC 九广铁路";
    op2.tel = @"+852 555-5555";
    op2.website = @"http://www.kcrc.com/";
    
    Operator* op3 = [NSEntityDescription insertNewObjectForEntityForName:@"Operator" inManagedObjectContext:context];
    op3.name = @"珠江客运有限公司";
    op3.tel = @"+852 555-5555";
    op3.website = @"http://www.cksp.com.hk/";
    
    Station* st1 = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:context];
    st1.name = @"红磡火车站";
    st1.address = @"香港九龙油尖旺區";
    st1.subway = @"港铁东铁线, 西铁线红磡站";
    st1.bus = @"九巴 11K, 11X, 21, 260X, 87D, N216, N241, N271, N281 城巴 A21, E21X";
    
    Station* st2 = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:context];
    st2.name = @"长平火车站";
    st2.address = @"东莞市常平镇口岸大道";
    st2.subway = @"";
    st2.bus = @"常平1, 1B, A1, 2, A2, 3, A3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 218, 218A, 218B";
    
    Station* st3 = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:context];
    st3.name = @"九龙机铁站";
    st3.address = @"尖沙咀九龍機鐵站地鐵C出口圓方一樓過境巴士站";
    st3.subway = @"机场快线九龙站";
    st3.bus = @"九巴 8, 11, 110, 203E, 215X, 259B, 270A, 281A, 296D 小巴 26, 74, 77M";
    
    Station* st4 = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:context];
    st4.name = @"香港國際機場";
    st4.address = @"香港大嶼山香港國際機場";
    st4.subway = @"机场快线机场站";
    st4.bus = @"九巴 E32, E42, N30, N31, N42, N42A, S1, S64";
    
    Station* st5 = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:context];
    st5.name = @"虎门港澳码头";
    st5.address = @"东莞市虎门长堤路";
    st5.subway = @"";
    st5.bus = @"L1";
    
    Route* r1 = [NSEntityDescription insertNewObjectForEntityForName:@"Route" inManagedObjectContext:context];
    r1.departCity = @"香港";
    r1.arrivalCity = @"东莞";
    r1.travelBy = @"train";
    r1.price = [NSDecimalNumber decimalNumberWithString:@"175.0"];
    r1.duration = [NSNumber numberWithInt:150];
    r1.operator = op2;
    r1.departStation = st1;
    r1.arrivalStation = st2;
    [op2 addRoutesObject:r1];
    [st1 addRoutesObject:r1];
    [st2 addRoutesObject:r1];
    
    Route* r2 = [NSEntityDescription insertNewObjectForEntityForName:@"Route" inManagedObjectContext:context];
    r2.departCity = @"香港";
    r2.arrivalCity = @"东莞";
    r2.travelBy = @"train";
    r2.price = [NSDecimalNumber decimalNumberWithString:@"180.0"];
    r2.duration = [NSNumber numberWithInt:165];
    r2.operator = op2;
    r2.departStation = st3;
    r2.arrivalStation = st2;
    [op2 addRoutesObject:r2];
    [st2 addRoutesObject:r2];
    [st3 addRoutesObject:r2];
    
    Route* r3 = [NSEntityDescription insertNewObjectForEntityForName:@"Route" inManagedObjectContext:context];
    r3.departCity = @"香港";
    r3.arrivalCity = @"东莞";
    r3.travelBy = @"ferry";
    r3.price = [NSDecimalNumber decimalNumberWithString:@"310.0"];
    r3.duration = [NSNumber numberWithInt:60];
    r3.operator = op3;
    r3.departStation = st4;
    r3.arrivalStation = st5;
    [op3 addRoutesObject:r3];
    [st4 addRoutesObject:r3];
    [st5 addRoutesObject:r3];
    
//    Schedule* r1s1 = [NSEntityDescription insertNewObjectForEntityForName:@"Schedule" inManagedObjectContext:context];
//    r1s1.departTime = @"1730";
//    r1s1.arrivalTime = @"1900";
//    r1s1.route = r1;
//    
//    Schedule* r1s2 = [NSEntityDescription insertNewObjectForEntityForName:@"Schedule" inManagedObjectContext:context];
//    r1s2.departTime = @"1000";
//    r1s2.arrivalTime = @"1900";
//    r1s2.route = r1;
//    [r1 addSchedulesObject:r1s2];
    
    // save dummy data
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PearlDelta" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PearlDelta.sqlite"];
    NSLog(@"url: %@", storeURL);
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
