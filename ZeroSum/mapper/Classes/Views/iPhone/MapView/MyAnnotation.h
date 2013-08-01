//
//  MyAnnotation.h
//  mapper
//
//  Created by bluemol on 8/1/13.
//
//

#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D myCoordinate;
    NSString *placeName;
    NSString *placeAddress;
}

@property (assign, nonatomic) CLLocationCoordinate2D myCoordinate;
@property (strong, nonatomic) NSString *placeName;
@property (strong, nonatomic) NSString *placeAddress;

- (void)setCo:(CLLocationCoordinate2D)coor;
- (void)setName:(NSString *)name;
- (void)setAddress:(NSString *)address;

@end
