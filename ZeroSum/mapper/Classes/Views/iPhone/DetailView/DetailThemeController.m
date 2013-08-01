//
//  DetailThemeController.m
//  mapper
//
//  Created by Tope on 27/01/2012.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "DetailThemeController.h"
#import "MyAnnotation.h"
#import "AppDelegate.h"

@implementation DetailThemeController
CLLocation * newLocation;
NSString *name;
NSString *address;
NSString *ratingFromShack;
NSString *distFromShack;

@synthesize titleLabel, distanceLabel, locationLabel, paidTypeLabel;

@synthesize distanceMetricLabel, zipCodeLabel, model, nearestLabel, furthestLabel, mapView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setNewLocal:(CLLocation *)local
{
    newLocation = local;
}

-(void)setNewName:(NSString *)Name
{
    name = Name;
}
-(void)setNewaddress:(NSString *)Address
{
    address = Address;
}

- (void)setDistance:(NSString *)dist
{
    distFromShack = dist;
}

- (void)setRating:(NSString *)rating
{
    ratingFromShack = rating;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //[nearestLabel setText:@"0.43"];
    //[furthestLabel setText:@"4.34"];
    
    [titleLabel setText:name];
    [locationLabel setText:address];
    [paidTypeLabel setText:ratingFromShack];
    [distanceMetricLabel setText:@"km"];
    [distanceLabel setText:distFromShack];
    
    [paidTypeLabel setTextColor:[[AppDelegate instance].colorSwitcher textColor]];
    [locationLabel setTextColor:[[AppDelegate instance].colorSwitcher textColor]];
    
    
    MyAnnotation *annotation = [[MyAnnotation alloc] init];
    [annotation setCo:newLocation.coordinate];
    [annotation setAddress:address];
    [annotation setName:name];
    
    [mapView addAnnotation:annotation];
    
    MKCoordinateRegion region;
    float latitude = newLocation.coordinate.latitude;
    float longitude = newLocation.coordinate.longitude;
    
    region.span.latitudeDelta=1.0/69*0.5;
    region.span.longitudeDelta=1.0/69*0.5;
    
    region.center.latitude=latitude;
    region.center.longitude=longitude;
    
    [mapView setRegion:region animated:YES];
    [mapView regionThatFits:region];
    
    mapView.showsUserLocation=YES;

    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
