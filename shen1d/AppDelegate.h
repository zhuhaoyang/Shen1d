//
//  AppDelegate.h
//  shen1d
//
//  Created by Peter Zhu on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"
#import "WXApi.h"

#define kAppKey             @"3448415748"
#define kAppSecret          @"03aa2cb686379d48f3ea0117607590e3"
#define kAppRedirectURI     @"http://www.sina.com"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

@class SinaWeibo;
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>{
//    SinaWeibo *sinaweibo;
}
@property (strong, nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
