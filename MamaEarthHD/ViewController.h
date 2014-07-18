//
//  ViewController.h
//  MamaEarthHD
//
//  Created by Calla on 7/18/14.
//  Copyright (c) 2014 Calla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <iAd/iAd.h>
@interface ViewController : UIViewController <CLLocationManagerDelegate, ADBannerViewDelegate> {
}
@property (weak, nonatomic) IBOutlet UILabel *currentLocation;
@property (weak, nonatomic) IBOutlet UILabel *currentTemp;
@property (weak, nonatomic) IBOutlet UILabel *lastRetrieved;
@property (weak, nonatomic) IBOutlet UILabel *currentDesc;
@property (weak, nonatomic) IBOutlet UIImageView *mamaSays;
@property (weak, nonatomic) IBOutlet UIButton *refresh;

- (IBAction)refreshTemp:(UIButton *)sender;
@end
