//
//  PearlDeltaAppDelegate.h
//  PearlDelta
//
//  Created by JERRY LIU on 8/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PearlDeltaAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
