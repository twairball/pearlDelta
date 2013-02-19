//
//  Station.m
//  PearlDelta
//
//  Created by JERRY LIU on 19/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import "Station.h"
#import "Route.h"


@implementation Station

@dynamic address;
@dynamic address2;
@dynamic bus;
@dynamic name;
@dynamic subway;
@dynamic latitude;
@dynamic longitude;
@dynamic routes;

#pragma mark - MKAnnotation methods
-(CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString*)title {
    return self.name;
}

-(NSString*)subtitle {
    return self.address;
}

@end
