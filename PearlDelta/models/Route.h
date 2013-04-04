//
//  Route.h
//  PearlDelta
//
//  Created by JERRY LIU on 17/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Operator, Station;

@interface Route : NSManagedObject

@property (nonatomic, retain) NSString * arrivalCity;
@property (nonatomic, retain) NSString * departCity;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSString * travelBy;
@property (nonatomic, retain) NSString * schedule;
@property (nonatomic, retain) Station *arrivalStation;
@property (nonatomic, retain) Station *departStation;
@property (nonatomic, retain) Operator *operator;

@end
