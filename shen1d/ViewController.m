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
@synthesize timer = _timer;
@synthesize startLoge = _startLoge;
@synthesize tabBar = _tabBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    tabBar.delegate = self;
    if (0) {
        self.startLoge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"startLog.jpg"]];
        self.startLoge.frame = CGRectMake(0, -20, 320, 480);
        
        [self.view addSubview:self.startLoge];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 
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
	[self.startLoge removeFromSuperview];
    
    [self showMain]; 
}


- (void)showMain
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    HomeViewController *m_HomeViewController = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:m_HomeViewController];
    [arr addObject:nav1];
    
    BusinessesViewController *m_BusinessesViewController = [[BusinessesViewController alloc]initWithNibName:@"BusinessesViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:m_BusinessesViewController];
//    [nav2.navigationBar setBackgroundColor:[UIColor blackColor ]];
    [nav2.navigationBar setBackgroundImage:[UIImage imageNamed:@"12321312312.png"] forBarMetrics:UIBarMetricsDefault];
    [arr addObject:nav2];
    
//    AroundViewController *m_AroundViewController = [[AroundViewController alloc]initWithNibName:@"AroundViewController" bundle:[NSBundle mainBundle]];
//    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:m_AroundViewController];
//    [arr addObject:nav3];
    
    FindViewController *m_FindViewController = [[FindViewController alloc]initWithNibName:@"FindViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:m_FindViewController];
    [arr addObject:nav3];
    
    CarkPacksViewController *m_CarkPacksViewController = [[CarkPacksViewController alloc]initWithNibName:@"CarkPacksViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:m_CarkPacksViewController];
    [arr addObject:nav4];
    
    TrendsViewController *m_TrendsViewController = [[TrendsViewController alloc]initWithNibName:@"TrendsViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:m_TrendsViewController];
    [arr addObject:nav5];

//    Test1ViewController *m_Test1ViewController = [[Test1ViewController alloc]initWithNibName:@"Test1ViewController" bundle:[NSBundle mainBundle]];
//    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:m_Test1ViewController];
//    [arr addObject:nav5];
    
    self.tabBar = [[UITabBarController alloc]init];
    self.tabBar.delegate = self;
    [self.tabBar setViewControllers:arr];
    [self.tabBar.view setFrame:CGRectMake(0, 0, 320, 460)];
//    self.tabBar.tabBarItem.title = @"首页";//image = [UIImage imageNamed:@"01.jpg"];
//    [[[self.tabBar.viewControllers objectAtIndex:0] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"01.jpg"] withFinishedUnselectedImage:[UIImage imageNamed:@"02.jpg"]];
//    [[[self.tabBar.viewControllers objectAtIndex:0] tabBarItem] setImage:[UIImage imageNamed:@"search.png"]];
//    [[[self.tabBar.viewControllers objectAtIndex:0] tabBarItem] setTitle:@"首页"];

    [self.view addSubview:self.tabBar.view];
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

@end
