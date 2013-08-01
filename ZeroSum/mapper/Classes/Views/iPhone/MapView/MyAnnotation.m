//
//  MyAnnotation.m
//  mapper
//
//  Created by bluemol on 8/1/13.
//
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize myCoordinate;
@synthesize placeAddress;
@synthesize placeName;

- (void)setCo:(CLLocationCoordinate2D)coor
{
    myCoordinate = coor;
}

- (void)setName:(NSString *)name
{
    placeName = name;
}

- (void)setAddress:(NSString *)address
{
    placeAddress = address;
}


- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = myCoordinate.latitude;
    theCoordinate.longitude = myCoordinate.longitude;
    return theCoordinate;
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return placeName;
}

// optional
- (NSString *)subtitle
{
    return placeAddress;
}

@end
