//
//  ShackViewController.m
//  mapper
//
//  Created by jimmy on 7/6/13.
//
//

#import <AudioToolbox/AudioToolbox.h>

#import "ShackViewController.h"
#import "ThemeListController.h"


#define GOOGLE_PLACE_BASE_URL @"https://maps.googleapis.com/maps/api/place/nearbysearch/"
#define GOOGLE_API_KEY @"AIzaSyAtK3jGI1fZaf_ykuLnq1T3ZMJ440S4vYc"
#define RADIUS @"1000"
#define OUTPUT @"json"
#define SENSOR @"true"
#define TYPES @"food"

@interface ShackViewController ()
{
    CLLocationManager *locMgr;
    NSString *location;
    
    
    NSDictionary *oneRes;
    NSString *name;
    NSString *geometry_lat;
    NSString *geometry_lng ;
    NSString *formatted_address;
    NSString *rating ;
    
    NSData *googlePlaceJson;
    CLLocation *loc;

}

@end

@implementation ShackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake.png"]];
    // TODO: fix lator
    img.frame =CGRectMake(0, 0, 320, 568);
    [self.view addSubview:img];
    */
    
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"bg.png"]];
    [self.view setBackgroundColor:bgColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}


#pragma mark - motion delegate

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    // you can do any thing at this stage what ever you want. Change the song in playlist, show photo, change photo or whatever you want to do

    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
	NSLog(@"Shack Cancelled");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    // you can do any thing at this stage what ever you want. Change the song in playlist, show photo, change photo or whatever you want to do
	NSLog(@"Shake Ended");
    
    if(motion == UIEventSubtypeMotionShake){
        // We just detected a motion-shake event
        
        locMgr = [[CLLocationManager alloc] init];
        locMgr.delegate = self;
        locMgr.distanceFilter = kCLDistanceFilterNone;
        locMgr.desiredAccuracy = kCLLocationAccuracyBest;
        
        [self getCurrentLocation];
    }
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

}


#pragma mark - CLLocation Delegate

- (void)getCurrentLocation
{
    [locMgr startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    loc =  [locations lastObject];
    NSLog(@"x: %f y: %f", loc.coordinate.latitude, loc.coordinate.longitude);
    
    location = [[NSString alloc] initWithFormat:@"%f,%f", loc.coordinate.latitude, loc.coordinate.longitude];
    
    if (loc != nil) {
        [locMgr stopUpdatingLocation];
        [self requestGooglePlaceApi];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Fail with error %@", error);
}



#pragma mark - Prepare Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"ThemeListController"])
    {
        // Get reference to the destination view controller
        ThemeListController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setGooglePlaceJson:googlePlaceJson];
        [vc setCurrentLocation:loc];
    }
}

#pragma makr - Google Place API

- (void) requestGooglePlaceApi
{
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%@&radius=%@&types=%@&sensor=true&key=%@", location, RADIUS, TYPES, GOOGLE_API_KEY];
    
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

-(void)fetchedData:(NSData *)responseData {
    googlePlaceJson = responseData;
    [self performSegueWithIdentifier:@"ThemeListController" sender:nil];
    
}


@end
