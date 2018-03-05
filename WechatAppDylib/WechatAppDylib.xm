// See http://iphonedevwiki.net/index.php/Logos

#import <Foundation/Foundation.h>
#import <CaptainHook.h>
#import "WechatAppInterface.h"
#import <CoreLocation/CoreLocation.h>
#import "CustomLocationVC.h"
#import "UIColor+Hex.h"


CHDeclareClass(WCTimelinePOIPickerViewController)

CHDeclareMethod1(void, WCTimelinePOIPickerViewController, viewWillAppear, _Bool, animated)
{
    CHSuper1(WCTimelinePOIPickerViewController, viewWillAppear, animated);
    UIBarButtonItem* anotherItem = [[UIBarButtonItem alloc] initWithTitle:@"自选" style:UIBarButtonItemStyleDone target:self action:@selector(customLocation)];
    [anotherItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:16], NSFontAttributeName, nil] forState:UIControlStateNormal];
    anotherItem.tintColor = [UIColor colorWithHexString:@"fcfcfd"];
    
    if (self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"fcfcfd"];
        self.navigationItem.rightBarButtonItems = @[self.navigationItem.rightBarButtonItem, anotherItem];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = anotherItem;
    }
}

CHDeclareMethod1(void, WCTimelinePOIPickerViewController, viewWillDisappear, _Bool, animated)
{
    CHSuper1(WCTimelinePOIPickerViewController, viewWillDisappear, animated);
    if (self.navigationItem.rightBarButtonItems.count >= 2)
    {
        UIBarButtonItem* anotherItem = self.navigationItem.rightBarButtonItems[1];
        anotherItem = nil;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

CHDeclareMethod0(void, WCTimelinePOIPickerViewController, customLocation)
{
    CustomLocationVC* vcOfCustomLocation = [[CustomLocationVC alloc] init];
    [self.navigationController pushViewController:vcOfCustomLocation animated:YES];
}

CHOptimizedMethod1(self, void, WCTimelinePOIPickerViewController, onRetrieveLocationOK, CLLocation*, arg1)
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    CLLocationDegrees latitude = [userDefaults doubleForKey:@"latitude"];
    CLLocationDegrees longtitude = [userDefaults doubleForKey:@"longtitude"];
    CLLocationCoordinate2D newCoordinate = CLLocationCoordinate2DMake(latitude, longtitude);
    
    CLLocation* newLocation = [[CLLocation alloc] initWithCoordinate:newCoordinate altitude:arg1.altitude horizontalAccuracy:arg1.horizontalAccuracy verticalAccuracy:arg1.verticalAccuracy course:arg1.course speed:arg1.speed timestamp:arg1.timestamp];
    
    CHSuper1(WCTimelinePOIPickerViewController, onRetrieveLocationOK, newLocation);
}

CHConstructor
{
    CHLoadLateClass(WCTimelinePOIPickerViewController);
    CHHook1(WCTimelinePOIPickerViewController, onRetrieveLocationOK);
}

CHDeclareClass(CLLocation);

CHOptimizedMethod0(self, CLLocationCoordinate2D, CLLocation, coordinate)
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    CLLocationDegrees latitude = [userDefaults doubleForKey:@"latitude"];
    CLLocationDegrees longtitude = [userDefaults doubleForKey:@"longtitude"];
    
    if (latitude || longtitude)
    {
        return CLLocationCoordinate2DMake(latitude, longtitude);
    }
    return CLLocationCoordinate2DMake(51.499227777777776, 0.13796666666666668);
}

CHConstructor
{
    CHLoadLateClass(CLLocation);
    //如果想要全局改变地理位置，比如在聊天界面中的位置实时共享，只需要把这一句代码给反注释即可
//    CHClassHook(0, CLLocation, coordinate);
}

%hook ClassName

+ (id)sharedInstance
{
	%log;

	return %orig;
}

- (void)messageWithNoReturnAndOneArgument:(id)originalArgument
{
	%log;

	%orig(originalArgument);
	
	// or, for exmaple, you could use a custom value instead of the original argument: %orig(customValue);
}

- (id)messageWithReturnAndNoArguments
{
	%log;

	id originalReturnOfMessage = %orig;
	
	// for example, you could modify the original return value before returning it: [SomeOtherClass doSomethingToThisObject:originalReturnOfMessage];

	return originalReturnOfMessage;
}

%end
