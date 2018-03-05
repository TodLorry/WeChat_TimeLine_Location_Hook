//
//  WechatAppInterface.h
//  WechatApp
//
//  Created by albus on 2018/2/26.
//  Copyright © 2018年 albus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface BaseMsgContentViewController : UIViewController

- (id)GetContact;

@end

@interface MMUIViewController : UIViewController
@end

@interface MMSearchBarDisplayController : MMUIViewController
@end

//朋友圈发布位置
@interface WCTimelinePOIPickerViewController : MMSearchBarDisplayController

//- (void)startUpdateLocation;
- (void)getAddressByLocation:(struct CLLocationCoordinate2D)arg1;
- (void)viewWillBePresented:(_Bool)arg1;
- (void)reset;
- (void)customLocation;

//delegate
- (void)onRetrieveLocationOK:(CLLocation *)arg1;

@end

#ifndef WechatAppInterface_h
#define WechatAppInterface_h



#endif /* WechatAppInterface_h */
