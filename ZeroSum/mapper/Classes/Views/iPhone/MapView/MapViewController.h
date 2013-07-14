//
//  MapViewController.h
//  mapper
//
//  Created by jimmy on 7/7/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<CLLocationManagerDelegate>


- (void)setLocArray:(NSArray *)json;
-(void)setCenter:(CLLocation *)location;

@end
