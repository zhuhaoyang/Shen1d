//
//  ViewController.m
//  shen1d
//
//  Created by Peter Zhu on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    tabBar.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLoginView)name: @"removeLoginView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login)name: @"login" object:nil];

    
    NSString *sSQL = nil;
    dbManager = [DatabaseManager sharedDatabaseManager];
    
    // 1. table personal info list
    sSQL = [[NSString alloc] initWithFormat:SQL_CREATE_TABLE,
            TableNamePersonalInfo,
            kTableFormatPersonalInfo];
    [dbManager createTable:sSQL];

    // 2. table my shops list
    sSQL = [[NSString alloc] initWithFormat:SQL_CREATE_TABLE,
            TableNameMyShops,
            kTableFormatMyShops];
    [dbManager createTable:sSQL];

    // 3. table shop details list
    sSQL = [[NSString alloc] initWithFormat:SQL_CREATE_TABLE,
            TableNameShopDetails,
            kTableFormatShopDetails];
    [dbManager createTable:sSQL];
    
    
    
    NSArray *arrPersonalInfo = [dbManager queryPersonalInfoFromTable];
    if ([arrPersonalInfo count] == 1) {
        Global *global = [Global sharedGlobal];
//        global.userId = [NSString stringWithString:[[arrPersonalInfo objectAtIndex:0] objectForKey:@"userId"]];
        global.userId = [[arrPersonalInfo objectAtIndex:0] objectForKey:@"userId"];
        global.email = [[arrPersonalInfo objectAtIndex:0] objectForKey:@"email"];
        global.password = [[arrPersonalInfo objectAtIndex:0] objectForKey:@"password"];
        global.uname = [[arrPersonalInfo objectAtIndex:0] objectForKey:@"uname"];
//        global.qrcode = [[arrPersonalInfo objectAtIndex:0] objectForKey:@"qrcode"];
        global.isLogined = YES;
        global.qrcode = [QRCodeGenerator qrImageForString:global.userId imageSize:100];

    }else if([arrPersonalInfo count] > 1){
        [dbManager deleteTable:TableNamePersonalInfo];
    }


    
    if (0) {
        startLoge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"startLog.jpg"]];
        startLoge.frame = CGRectMake(0, -20, 320, 480);
        
        [self.view addSubview:startLoge];
        
        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                 target: self 
                                               selector: @selector(fadeScreen) 
                                               userInfo: nil repeats: NO];
    }else {
        [self showMain];  
    }

    
}


- (void) fadeScreen
{
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: 0.5f];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDidStopSelector: @selector(finishedFading)];
	self.view.alpha = 0.0;
	[UIView commitAnimations];
}

- (void) finishedFading
{
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: 0.5f];
	self.view.alpha = 1.0;
	[UIView commitAnimations];
	[startLoge removeFromSuperview];
    
    [self showMain]; 
}


- (void)showMain
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    HomeViewController *m_HomeViewController = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:m_HomeViewController];
    [nav1.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibar"] forBarMetrics:UIBarMetricsDefault];
    nav1.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    nav1.navigationBar.layer.shadowOffset = CGSizeMake(0, 4);
    nav1.navigationBar.layer.shadowOpacity = 0.5;
    nav1.navigationBar.layer.shadowRadius = 4.0;
    [arr addObject:nav1];

    BusinessesViewController *m_BusinessesViewController = [[BusinessesViewController alloc]initWithNibName:@"BusinessesViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:m_BusinessesViewController];
//    [nav2.navigationBar setBackgroundColor:[UIColor blackColor ]];
//    [nav2.navigationBar setBackgroundImage:[UIImage imageNamed:@"12321312312.png"] forBarMetrics:UIBarMetricsDefault];
    [nav2.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibar"] forBarMetrics:UIBarMetricsDefault];
    nav2.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    nav2.navigationBar.layer.shadowOffset = CGSizeMake(0, 4);
    nav2.navigationBar.layer.shadowOpacity = 0.5;
    nav2.navigationBar.layer.shadowRadius = 4.0;
    [arr addObject:nav2];

//    AroundViewController *m_AroundViewController = [[AroundViewController alloc]initWithNibName:@"AroundViewController" bundle:[NSBundle mainBundle]];
//    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:m_AroundViewController];
//    [arr addObject:nav3];
    
    FindViewController *m_FindViewController = [[FindViewController alloc]initWithNibName:@"FindViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:m_FindViewController];
    [nav3.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibar"] forBarMetrics:UIBarMetricsDefault];
    nav3.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    nav3.navigationBar.layer.shadowOffset = CGSizeMake(0, 4);
    nav3.navigationBar.layer.shadowOpacity = 0.5;
    nav3.navigationBar.layer.shadowRadius = 4.0;
//    [nav3.navigationItem.backBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    [arr addObject:nav3];

    CarkPacksViewController *m_CarkPacksViewController = [[CarkPacksViewController alloc]initWithNibName:@"CarkPacksViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:m_CarkPacksViewController];
    [nav4.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibar"] forBarMetrics:UIBarMetricsDefault];
    nav4.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    nav4.navigationBar.layer.shadowOffset = CGSizeMake(0, 4);
    nav4.navigationBar.layer.shadowOpacity = 0.5;
    nav4.navigationBar.layer.shadowRadius = 4.0;
    [arr addObject:nav4];
    
    TrendsViewController *m_TrendsViewController = [[TrendsViewController alloc]initWithNibName:@"TrendsViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:m_TrendsViewController];
    [nav5.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibar"] forBarMetrics:UIBarMetricsDefault];
    nav5.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    nav5.navigationBar.layer.shadowOffset = CGSizeMake(0, 4);
    nav5.navigationBar.layer.shadowOpacity = 0.5;
    nav5.navigationBar.layer.shadowRadius = 4.0;
    [arr addObject:nav5];

//    Test1ViewController *m_Test1ViewController = [[Test1ViewController alloc]initWithNibName:@"Test1ViewController" bundle:[NSBundle mainBundle]];
//    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:m_Test1ViewController];
//    [arr addObject:nav5];
    
    tabBar = [[UITabBarController alloc]init];
    tabBar.delegate = self;
    [tabBar setViewControllers:arr];
    [tabBar.view setFrame:CGRectMake(0, 0, 320, 460)];
//    tabBar.tabBarItem.title = @"首页";//image = [UIImage imageNamed:@"01.jpg"];
    
    tabBar.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    tabBar.tabBar.layer.shadowOffset = CGSizeMake(0, -4);
    tabBar.tabBar.layer.shadowOpacity = 0.5;
    tabBar.tabBar.layer.shadowRadius = 4.0;
    [[[tabBar.viewControllers objectAtIndex:0] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"tab_btn_selected1"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_btn_unselected1"]];
    [[[tabBar.viewControllers objectAtIndex:1] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"tab_btn_selected2"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_btn_unselected2"]];
    [[[tabBar.viewControllers objectAtIndex:2] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"tab_btn_selected3"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_btn_unselected3"]];
    [[[tabBar.viewControllers objectAtIndex:3] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"tab_btn_selected4"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_btn_unselected4"]];
    [[[tabBar.viewControllers objectAtIndex:4] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"tab_btn_selected5"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_btn_unselected5"]];

//    [[[tabBar.viewControllers objectAtIndex:0] tabBarItem] setImage:[UIImage imageNamed:@"search.png"]];
//    [[[tabBar.viewControllers objectAtIndex:0] tabBarItem] setTitle:@"首页"];

    [self.view addSubview:tabBar.view];
    
    backGround = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backGround.backgroundColor = [UIColor blackColor];
    backGround.alpha = 0.9;

}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    LOGS(@"%i",tabBarController.selectedIndex);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"removeLoginView" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"login" object:nil];
}

- (void)removeLoginView
{
    [backGround removeFromSuperview];
    [m_LoginViewController.view removeFromSuperview];
}
#pragma mark -
#pragma mark LoginCallBack
- (void)login
{
    m_LoginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
//    CATransition *animation = [CATransition animation];
//    animation.delegate = self;
//    animation.duration = 0.5f ;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    animation.subtype = kCATransitionFromBottom;
//    animation.type = @"cube";
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:m_LoginViewController.view cache:YES];
//    [self.view.layer addAnimation:animation forKey:@"animationID"];
    [self.view addSubview:backGround];
    m_LoginViewController.view.frame = CGRectMake(0, -460, 320, 460);
    [self.view addSubview:m_LoginViewController.view];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];

    m_LoginViewController.view.frame = CGRectMake(0, 0, 320, 460);

    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];

}
@end
