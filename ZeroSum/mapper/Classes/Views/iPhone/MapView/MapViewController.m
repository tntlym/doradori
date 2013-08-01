//
//  MapViewController.m
//  mapper
//
//  Created by jimmy on 7/7/13.
//
//

#import "MapViewController.h"
#import "MyAnnotation.h"


@interface MapViewController () {
    NSArray *googleJson;
    IBOutlet MKMapView* mapView;
    float geometry_lat;
    float geometry_lng ;
    CLLocation *myLocation;

}

@end

@implementation MapViewController

- (void)setLocArray:(NSArray *)json
{
    googleJson = json;
}
-(void)setCenter:(CLLocation *)location
{
    myLocation = location;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    for (int i=0; i<[googleJson count]; i++) {
        geometry_lat = [[[[[googleJson objectAtIndex:i] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] doubleValue];
        geometry_lng = [[[[[googleJson objectAtIndex:i] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] doubleValue];
        
        NSString *placeAddress = [[googleJson objectAtIndex:i] objectForKey:@"vicinity"];
        NSString *placeName = [[googleJson objectAtIndex:i] objectForKey:@"name"];

        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(geometry_lat, geometry_lng);
        MyAnnotation *annotation = [[MyAnnotation alloc] init];
        [annotation setCo:coordinate];
        [annotation setAddress:placeAddress];
        [annotation setName:placeName];
        
        [mapView addAnnotation:annotation];
    }
            
    mapView.showsUserLocation=YES;
    
    MKCoordinateRegion region;
    
    region.span.latitudeDelta=1.0/69*0.5;
    region.span.longitudeDelta=1.0/69*0.5;
    
    region.center = myLocation.coordinate;
    
    [mapView setRegion:region animated:YES];
    [mapView regionThatFits:region];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // in case it's the user location, we already have an annotation, so just return nil
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    // handle our three custom annotations
    //
    if ([annotation isKindOfClass:[MyAnnotation class]]) // for Golden Gate Bridge
    {
        // try to dequeue an existing pin view first
        static NSString *BridgeAnnotationIdentifier = @"myAnnotationIdentifier";
        
        MKPinAnnotationView *pinView =
        (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
        if (pinView == nil)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]
                                                  initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
