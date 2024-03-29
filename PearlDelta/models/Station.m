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
    if(self.latitude && self.longitude) {
        return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
    } else {
        return CLLocationCoordinate2DMake(22.2997,114.1668); //center on hk china ferry
    }
}

-(NSString*)title {
    return self.name;
}

-(NSString*)subtitle {
    return self.address;
}

@end
