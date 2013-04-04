//
//  Operator.h
//  PearlDelta
//
//  Created by JERRY LIU on 13/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Route;

@interface Operator : NSManagedObject

@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *routes;
@end

@interface Operator (CoreDataGeneratedAccessors)

- (void)addRoutesObject:(Route *)value;
- (void)removeRoutesObject:(Route *)value;
- (void)addRoutes:(NSSet *)values;
- (void)removeRoutes:(NSSet *)values;

@end
