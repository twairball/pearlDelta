//
//  Trip.h
//  PearlDelta
//
//  Created by JERRY LIU on 11/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip : NSObject

@property (nonatomic, strong) NSString* departCity;
@property (nonatomic, strong) NSString* arrivalCity;

-(id)initWithDepartCity:(NSString*)thisDepartCity arrivalCity:(NSString*)thisArrivalCity;
-(NSArray*)cityListForArrival;
-(NSArray*)cityListForDeparture;
+(NSMutableArray*)cityList;

@end
