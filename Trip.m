//
//  Trip.m
//  PearlDelta
//
//  Created by JERRY LIU on 11/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import "Trip.h"

@implementation Trip 

@synthesize departCity, arrivalCity;

-(id)initWithDepartCity:(NSString*)thisDepartCity arrivalCity:(NSString*)thisArrivalCity {
    if ((self = [super init])) {
        self.departCity = thisDepartCity;
        self.arrivalCity = thisArrivalCity;
    }
    return self;
}

-(NSArray*)cityListForDeparture {
    NSMutableArray* list = [Trip cityList];
    [list removeObject:self.arrivalCity];
    return (NSArray*)list;
}

-(NSArray*)cityListForArrival {
    NSMutableArray* list = [Trip cityList];
    [list removeObject:self.departCity];
    return (NSArray*)list;
}

+(NSMutableArray*)cityList {
    
    NSArray *languagesArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languagesArray objectAtIndex:0];

    return [Trip cityListForLanguage:currentLanguage];
}

+(NSMutableArray*)cityListForLanguage:(NSString*)lang {
    NSMutableArray* cityList = nil;
    NSLog(@"cityListForLanguage: %@", lang);
    
    if ([lang isEqualToString:@"en"]) {
        cityList = [NSMutableArray arrayWithObjects:@"Hong Kong", @"Guangzhou", @"Shenzhen", @"Zhongshan", @"Dongguan", @"Zhuhai", @"Macau", nil];
    } else {
        cityList = [NSMutableArray arrayWithObjects:@"香港", @"廣州", @"深圳", @"中山", @"東莞", @"珠海", @"澳門",nil];
    }
    return cityList;
}

@end
