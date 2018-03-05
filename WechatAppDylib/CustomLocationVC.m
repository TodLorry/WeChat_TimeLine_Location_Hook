//
//  CustomLocationVC.m
//  WechatAppDylib
//
//  Created by albus on 2018/2/27.
//  Copyright © 2018年 albus. All rights reserved.
//

#import "CustomLocationVC.h"
#import <Mapbox/Mapbox.h>
#import "WechatAppInterface.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIColor+Hex.h"
#import "Macro.h"

@interface CustomLocationVC ()<MGLMapViewDelegate>

@property (nonatomic) MGLMapView* mapView;
@property (nonatomic, strong) MGLUserLocation* userLocation;

@end

@implementation CustomLocationVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [MGLAccountManager setAccessToken:MAPBOX_TOKEN];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor colorWithHexString:@"fcfcfd"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定   " style:UIBarButtonItemStyleDone target:self action:@selector(confirmLocation)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"fcfcfd"];
    
    self.mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds styleURL:[MGLStyle streetsStyleURL]];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.tintColor = [UIColor darkGrayColor];
//    self.mapView.backgroundColor = [UIColor redColor];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    // 禁用rotate和pitch功能
//    self.mapView.rotateEnabled = NO;
    self.mapView.pitchEnabled = NO;
    //隐藏左下角和右下角的图标或按钮
    self.mapView.logoView.hidden = YES;
    self.mapView.attributionButton.alpha = 0.0;
    self.mapView.zoomLevel = 12.0;
    [self.view addSubview:self.mapView];
    
    UIImageView* imgv = [[UIImageView alloc] init];
    imgv.contentMode = UIViewContentModeScaleAspectFit;
    NSString* imagePath = [[[NSBundle mainBundle] pathForResource:@"Images" ofType:@"bundle"] stringByAppendingString:@"/location"];
    imgv.image = [UIImage imageWithContentsOfFile:imagePath];
    imgv.frame = CGRectMake((self.view.frame.size.width - imgv.image.size.width)/2.0, (self.view.frame.size.height - imgv.image.size.height)/2.0 + 17, imgv.image.size.width, imgv.image.size.height);
    [self.view addSubview:imgv];
    
    // 按钮，将用户位置放置于屏幕中间
    UIButton* btnToShowUserLocation = [UIButton buttonWithType:UIButtonTypeSystem];
    btnToShowUserLocation.layer.cornerRadius = 18;
    btnToShowUserLocation.layer.masksToBounds = YES;
    btnToShowUserLocation.backgroundColor = [UIColor whiteColor];
    [btnToShowUserLocation setTintColor:[UIColor colorWithHexString:@"2f4050"]];
    [btnToShowUserLocation setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"Images" ofType:@"bundle"] stringByAppendingString:@"/Ic-my_position_at_mapview"]] forState:UIControlStateNormal];
    [btnToShowUserLocation addTarget:self action:@selector(presentRegionUserCenteredIn:) forControlEvents:UIControlEventTouchUpInside];
    btnToShowUserLocation.frame = CGRectMake(self.view.frame.size.width - 36 - 24, self.view.frame.size.height - 36 - (IS_iPHONE_X ? 70 : 36), 36, 36);
    [self.view addSubview:btnToShowUserLocation];
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    CLLocationDegrees latitude = [userDefaults doubleForKey:@"latitude"];
    CLLocationDegrees longtitude = [userDefaults doubleForKey:@"longtitude"];
    if (latitude || longtitude)
    {
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(latitude, longtitude) animated:NO];
    }
}

- (void)confirmLocation
{
    CLLocationDegrees latitude = self.mapView.centerCoordinate.latitude;
    CLLocationDegrees longtitude = self.mapView.centerCoordinate.longitude;
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:latitude forKey:@"latitude"];
    [userDefaults setDouble:longtitude forKey:@"longtitude"];
    [userDefaults synchronize];
    
    NSLog(@"centerCoordinate: %lf, %lf", latitude, longtitude);
    
    [self.navigationController popViewControllerAnimated:YES];
    
    WCTimelinePOIPickerViewController* vc = self.navigationController.viewControllers[0];
    NSLog(@"startUpdateLocation: %@", vc);
    [vc getAddressByLocation:self.mapView.centerCoordinate];
    [vc reset];
    [vc viewWillBePresented:YES];
}


#pragma mark 点击事件

-(void)presentRegionUserCenteredIn:(UIButton*)sender
{
    [self.mapView setCenterCoordinate:self.userLocation.coordinate animated:YES];    
}

#pragma mark MGLMapViewDelegate

- (void)mapView:(MGLMapView *)mapView didUpdateUserLocation:(MGLUserLocation *)userLocation
{
    self.userLocation = userLocation;
}

@end
