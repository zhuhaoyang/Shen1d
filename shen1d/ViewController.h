//
//  ViewController.h
//  shen1d
//
//  Created by Peter Zhu on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "BusinessesViewController.h"
#import "FindViewController.h"
#import "CarkPacksViewController.h"
#import "TrendsViewController.h"
//#import "MyViewController.h"

#import "PublicDefine.h"
#import "Global.h"
#import "CouponViewController.h"
#import "AroundViewController.h"
#import "Test1ViewController.h"
#import "LoginViewController.h"

#import "DatabaseManager.h"
#import "QRCodeGenerator.h"
@interface ViewController : UIViewController<UITabBarControllerDelegate>{
    NSTimer *timer;
    UIImageView *startLoge;
    UITabBarController *tabBar;
    LoginViewController *m_LoginViewController;
    DatabaseManager *dbManager;
    UIImageView *backGround;
}

//@property(nonatomic,strong) NSTimer *timer;
//@property(nonatomic,strong) UIImageView *startLoge;
//@property(nonatomic,strong) UITabBarController *tabBar;

- (void)fadeScreen;
- (void)finishedFading;
- (void)showMain;

@end


