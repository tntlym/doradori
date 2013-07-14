//
//  MapViewController.m
//  mapper
//
//  Created by jimmy on 7/7/13.
//
//

#import "MapViewController.h"
#import "Annotation.h"


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
        Annotation *annotation = [[Annotation alloc] initWithLatitude:geometry_lat
                                                         andLongitude:geometry_lng];
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
