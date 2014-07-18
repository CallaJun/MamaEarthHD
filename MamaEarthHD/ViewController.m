//
//  ViewController.m
//  MamaEarthHD
//
//  Created by Calla on 7/18/14.
//  Copyright (c) 2014 Calla. All rights reserved.
//

#import "ViewController.h"
#import "GetWeather.h"
#import <iAd/iAd.h>

@interface ViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation ViewController
BOOL weatherCalled = 0;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
	// Do any additional setup after loading the view, typically from a nib.
    
    [_refresh setTitle:@"Refresh" forState:UIControlStateNormal];
    
    self.canDisplayBannerAds = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getWeather:(CLLocation *)location {
    if (weatherCalled == 0) {
        CLLocationCoordinate2D currentLocation = location.coordinate;
        NSLog(@"%f, %f", currentLocation.latitude, currentLocation.longitude);
        GetWeather *weather = [[GetWeather alloc] init];
        [weather getWeatherAtCurrentLocation:currentLocation];
        self.currentLocation.text = weather.currentLocation;
        self.currentTemp.text = weather.currentTemperature;
        self.currentDesc.text = weather.currentDescription;
        
        //WEATHER CASES
        if([weather.currentDescription rangeOfString:@"Sunny"].location != NSNotFound) {
            UIImage *Sunny1 = [UIImage imageNamed:@"Sunny1.png"];
            [_mamaSays setImage:Sunny1];
        }
        //Cloudy or overcast
        else if(60 <= weather.Fvalue && (([weather.currentDescription rangeOfString:@"Clear"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Cloudy"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Overcast"].location != NSNotFound))) {
            UIImage *CloudyOvercast1 = [UIImage imageNamed:@"CloudyOvercast1.png"];
            [_mamaSays setImage:CloudyOvercast1];
        }
        else if(60 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"Clear"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Cloudy"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Overcast"].location != NSNotFound))){
            UIImage *CloudyOvercast2 = [UIImage imageNamed:@"CloudyOvercast2.png"];
            [_mamaSays setImage:CloudyOvercast2];
        }
        //Mist and fog
        else if(60 <= weather.Fvalue && (([weather.currentDescription rangeOfString:@"Mist"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Fog"].location != NSNotFound))) {
            UIImage *MistFog1 = [UIImage imageNamed:@"MistFog1.png"];
            [_mamaSays setImage:MistFog1];
        }
        else if(60 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"Mist"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Fog"].location != NSNotFound))) {
            UIImage *MistFog2 = [UIImage imageNamed:@"MistFog2.png"];
            [_mamaSays setImage:MistFog2];
        }
        //Patchy rain nearby
        else if(50 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy rain nearby"].location != NSNotFound) {
            UIImage *PatchyRainNearby1 = [UIImage imageNamed:@"PatchyRainNearby1.png"];
            [_mamaSays setImage:PatchyRainNearby1];
        }
        else if(50 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy rain nearby"].location != NSNotFound) {
            UIImage *PatchyRainNearby2 = [UIImage imageNamed:@"PatchyRainNearby2.png"];
            [_mamaSays setImage:PatchyRainNearby2];
        }
        //Patchy snow nearby
        else if(15 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy snow nearby"].location != NSNotFound) {
            UIImage *PatchySnowNearby1 = [UIImage imageNamed:@"PatchySnowNearby1.png"];
            [_mamaSays setImage:PatchySnowNearby1];
        }
        else if(15 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy snow nearby"].location != NSNotFound) {
            UIImage *PatchySnowNearby2 = [UIImage imageNamed:@"PatchySnowNearby2.png"];
            [_mamaSays setImage:PatchySnowNearby2];
        }
        //Patchy sleet nearby
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy sleet nearby"].location != NSNotFound) {
            UIImage *PatchySleetNearby1 = [UIImage imageNamed:@"PatchySleetNearby1.png"];
            [_mamaSays setImage:PatchySleetNearby1];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy sleet nearby"].location != NSNotFound) {
            UIImage *PatchySleetNearby2 = [UIImage imageNamed:@"PatchySleetNearby2.png"];
            [_mamaSays setImage:PatchySleetNearby2];
        }
        //Freezing drizzle and heavy freezing drizzle
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Freezing drizzle"].location != NSNotFound) {
            UIImage *FreezingDrizzle1 = [UIImage imageNamed:@"FreezingDrizzle1.png"];
            [_mamaSays setImage:FreezingDrizzle1];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Freezing drizzle"].location != NSNotFound) {
            UIImage *FreezingDrizzle2 = [UIImage imageNamed:@"FreezingDrizzle2.png"];
            [_mamaSays setImage:FreezingDrizzle2];
        }
        //Thundery outbreaks nearby
        else if(40 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Thundery"].location != NSNotFound) {
            UIImage *Thundery1 = [UIImage imageNamed:@"Thundery1.png"];
            [_mamaSays setImage:Thundery1];
        }
        else if(40 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Thundery"].location != NSNotFound) {
            UIImage *Thundery2 = [UIImage imageNamed:@"Thundery2.png"];
            [_mamaSays setImage:Thundery2];
        }
        //Blowing snow
        else if(10 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Blowing snow"].location != NSNotFound) {
            UIImage *BlowingSnow1 = [UIImage imageNamed:@"BlowingSnow1.png"];
            [_mamaSays setImage:BlowingSnow1];
        }
        else if(10 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Blowing snow"].location != NSNotFound) {
            UIImage *BlowingSnow2 = [UIImage imageNamed:@"BlowingSnow2.png"];
            [_mamaSays setImage:BlowingSnow2];
        }
        //Blizzard
        else if(10 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Blizzard"].location != NSNotFound) {
            UIImage *Blizzard1 = [UIImage imageNamed:@"Blizzard1.png"];
            [_mamaSays setImage:Blizzard1];
        }
        else if(10 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Blizzard"].location != NSNotFound) {
            UIImage *Blizzard2 = [UIImage imageNamed:@"Blizzard2.png"];
            [_mamaSays setImage:Blizzard2];
        }
        //Light drizzle and patchy light drizzle
        else if(50 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Light drizzle"].location != NSNotFound) {
            UIImage *LightDrizzle1 = [UIImage imageNamed:@"LightDrizzle1.png"];
            [_mamaSays setImage:LightDrizzle1];
        }
        else if(50 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Light drizzle"].location != NSNotFound) {
            UIImage *LightDrizzle2 = [UIImage imageNamed:@"LightDrizzle2.png"];
            [_mamaSays setImage:LightDrizzle2];
        }
        //Light rain and patchy light rain
        else if(40 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Light rain"].location != NSNotFound) {
            UIImage *LightRain1 = [UIImage imageNamed:@"LightRain1.png"];
            [_mamaSays setImage:LightRain1];
        }
        //freezing rain
        else if(40 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"Light rain"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"light freezing rain"].location != NSNotFound))) {
            UIImage *LightRain2 = [UIImage imageNamed:@"LightRain2.png"];
            [_mamaSays setImage:LightRain2];
        }
        //Moderate rain and moderate rain at times
        else if(40 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Moderate rain"].location != NSNotFound) {
            UIImage *ModerateRain1 = [UIImage imageNamed:@"ModerateRain1.png"];
            [_mamaSays setImage:ModerateRain1];
        }
        else if(40 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"Moderate rain"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"moderate freezing rain"].location != NSNotFound))) {
            UIImage *ModerateRain2 = [UIImage imageNamed:@"ModerateRain2.png"];
            [_mamaSays setImage:ModerateRain2];
        }
        //heavy rain and heavy rain at times or Torrential
        else if(40 <= weather.Fvalue && (([weather.currentDescription rangeOfString:@"Heavy rain"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Torrential rain"].location != NSNotFound))) {
            UIImage *HeavyRain1 = [UIImage imageNamed:@"HeavyRain1.png"];
            [_mamaSays setImage:HeavyRain1];
        }
        //freezing rain
        else if(40 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"Torrential rain"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Heavy rain"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Heavy freezing rain"].location != NSNotFound))) {
            UIImage *HeavyRain2 = [UIImage imageNamed:@"HeavyRain2.png"];
            [_mamaSays setImage:HeavyRain2];
        }
        //light snow or light sleet or patchy light snow
        else if(20 <= weather.Fvalue && (([weather.currentDescription rangeOfString:@"Light snow"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Light sleet"].location != NSNotFound))) {
            UIImage *LightSnow1 = [UIImage imageNamed:@"LightSnow1.png"];
            [_mamaSays setImage:LightSnow1];
        }
        else if(20 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"Light snow"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Light sleet"].location != NSNotFound))) {
            UIImage *LightSnow2 = [UIImage imageNamed:@"LightSnow2.png"];
            [_mamaSays setImage:LightSnow2];
        }
        //moderate or heavy sleet
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Moderate or heavy sleet"].location != NSNotFound) {
            UIImage *ModerateHeavySleet1 = [UIImage imageNamed:@"ModerateHeavySleet1.png"];
            [_mamaSays setImage:ModerateHeavySleet1];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Moderate or heavy sleet"].location != NSNotFound) {
            UIImage *ModerateHeavySleet2 = [UIImage imageNamed:@"ModerateHeavySleet2.png"];
            [_mamaSays setImage:ModerateHeavySleet2];
        }
        //Moderate snow or patchy moderate snow
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Moderate snow"].location != NSNotFound) {
            UIImage *ModerateSnow1 = [UIImage imageNamed:@"ModerateSnow1.png"];
            [_mamaSays setImage:ModerateSnow1];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Moderate snow"].location != NSNotFound) {
            UIImage *ModerateSnow2 = [UIImage imageNamed:@"ModerateSnow2.png"];
            [_mamaSays setImage:ModerateSnow2];
        }
        //heavy snow or patchy heavy snow
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Heavy snow"].location != NSNotFound) {
            UIImage *HeavySnow1 = [UIImage imageNamed:@"HeavySnow1.png"];
            [_mamaSays setImage:HeavySnow1];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Heavy snow"].location != NSNotFound) {
            UIImage *HeavySnow2 = [UIImage imageNamed:@"HeavySnow2.png"];
            [_mamaSays setImage:HeavySnow2];
        }
        //light, moderate, heavy showers of ice pellets, ice pellets
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"ice pellets"].location != NSNotFound) {
            UIImage *IcePellets1 = [UIImage imageNamed:@"IcePellets1.png"];
            [_mamaSays setImage:IcePellets1];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"ice pellets"].location != NSNotFound) {
            UIImage *IcePellets2 = [UIImage imageNamed:@"IcePellets2.png"];
            [_mamaSays setImage:IcePellets2];
        }
        //Else
        else {
            UIImage *DoesntKnow = [UIImage imageNamed:@"DoesntKnow.png"];
            [_mamaSays setImage:DoesntKnow];
        }
        
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        NSString *dateTime = [formatter stringFromDate:now];
        
        NSString * lastUpdated = [NSString stringWithFormat:@"Last updated: %@", dateTime];
        self.lastRetrieved.text = lastUpdated;
        
        weatherCalled = 0;
        
    } else {
        NSLog(@"Weather Check Already in Progress");
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    [self getWeather:location];
    weatherCalled = 1;
}
- (IBAction)refreshTemp:(UIButton *)sender {
    weatherCalled = 0;
    
    [self.locationManager startUpdatingLocation];
}
#pragma mark iAd Delegate Methods
-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0 ];
    [UIView commitAnimations];
}
@end
