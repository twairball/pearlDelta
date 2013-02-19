//
//  Station.h
//  PearlDelta
//
//  Created by JERRY LIU on 19/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Route;

@interface Station : NSManagedObject <MKAnnotation>

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * bus;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * subway;
@property (nonatomic, retain) NSDecimalNumber * latitude;
@property (nonatomic, retain) NSDecimalNumber * longitude;
@property (nonatomic, retain) NSSet *routes;
@end

@interface Station (CoreDataGeneratedAccessors)

- (void)addRoutesObject:(Route *)value;
- (void)removeRoutesObject:(Route *)value;
- (void)addRoutes:(NSSet *)values;
- (void)removeRoutes:(NSSet *)values;

@end
