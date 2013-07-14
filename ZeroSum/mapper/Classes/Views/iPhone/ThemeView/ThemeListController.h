//
//  ViewController.h
//  PodRadio
//
//  Created by Tope on 08/11/2011.
//  Copyright (c) 2011 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface ThemeListController : UIViewController<UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate>


@property (nonatomic, strong) IBOutlet UITableView* tableListView;
@property (nonatomic, strong) IBOutlet UILabel* nearestLabel;
@property (nonatomic, strong) IBOutlet UILabel* furthestLabel;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) NSArray* models;

- (void)setGooglePlaceJson:(NSData *)data;
- (void)setCurrentLocation:(CLLocation *)curLoc;
-(void)setNewName:(NSString *)Name;
-(void)setNewaddress:(NSString *)Address;



@end
