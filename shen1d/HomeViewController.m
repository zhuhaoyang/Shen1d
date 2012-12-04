//
//  HomeViewController.m
//  shen1d
//
//  Created by Myth on 12-8-13.
//
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = @"首页";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.88 green:0.42 blue:0 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSueceeded)name: @"loginSueceeded" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSueceeded)name: @"logoutSueceeded" object:nil];
        m_serviceGetActivities = [[serviceGetActivities alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
        [m_serviceGetActivities sendRequestWithData:nil addr:@"get_activities"];
        
//        arrImage = [[NSMutableArray alloc]initWithObjects:@"1933_1.jpg",@"1933_2.jpg",@"1933_3.jpg",@"1933_4.jpg",@"1933_5.jpg", nil];
        
        Global *global = [Global sharedGlobal];

        if (!global.isLogined) {
            
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(0, 0, 53, 30);
            [bt setBackgroundImage:[UIImage imageNamed:@"btn6"] forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
            bt.tag = 0;
            rightButton = [[UIBarButtonItem alloc]initWithCustomView:bt];
            [self.navigationItem setRightBarButtonItem:rightButton];
            
//            rightButton = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStyleBordered target:self action:@selector(login)];
//            self.navigationItem.rightBarButtonItem = rightButton;

        }
    }
    return self;
}

- (void)loginSueceeded
{
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)logoutSueceeded
{
    if (rightButton == nil) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(0, 0, 53, 30);
        [bt setBackgroundImage:[UIImage imageNamed:@"btn6"] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        bt.tag = 0;
        rightButton = [[UIBarButtonItem alloc]initWithCustomView:bt];
    }
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)login
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginSueceeded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logoutSueceeded" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.tabBarItem.title = @"首页";
//    [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"01.jpg"] withFinishedUnselectedImage:[UIImage imageNamed:@"02.jpg"]];
    [self.tabBarItem setImage:[UIImage imageNamed:@"search.png"]];
    self.tabBarItem.title = @"首页";
//    [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"fav"] withFinishedUnselectedImage:[UIImage imageNamed:@"search"]];
//    self.tabBarItem.image = [UIImage imageNamed:@"fav.png"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark HomeDelegate
- (void)clickedImage:(UIButton *)bt
{
    UIButton *btn = bt;
    LOGS(@"clicked %@",[arrImage objectAtIndex:btn.tag]);
    m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" shopId:[[arrImage objectAtIndex:bt.tag] objectForKey:@"shopId"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:m_CardViewController animated:YES];

}

#pragma mark -
#pragma mark PagePhotosDataSource

- (UIImage *)imageAtIndex:(int)index {
	return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[arrImage objectAtIndex:(NSUInteger)index] objectForKey:@"activityImages"]]]];
    
}

- (int)numberOfPages {
	return [arrImage count];
}

#pragma mark -
#pragma mark serviceCallBack
- (void)serviceGetActivitiesCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
{
    UIAlertView *alert;
    if ([dicCallBack objectForKey:@"state"] != nil) {
        if ([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:1]) {
            alert = [[UIAlertView alloc]initWithTitle:[dicCallBack objectForKey:@"error"]
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确认"
                                    otherButtonTitles:nil];
        }else if([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:0]){
         
            arrImage = [[NSMutableArray alloc]initWithArray:[dicCallBack objectForKey:@"activities"]];
            NSLog(@"%@",arrImage);
            m_PagePhotosView = [[PagePhotosView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49) withDataSource:self delegate:self];
            [self.view addSubview:m_PagePhotosView];
        }
    }else{
        LOGS(@"失败!");

    }
    [alert show];

}
//- (void)serviceGetShopCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
//{
//    if ([dicCallBack objectForKey:@"state"] != nil) {
//        if ([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:1]) {
//           UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[dicCallBack objectForKey:@"error"]
//                                              message:nil
//                                             delegate:self
//                                    cancelButtonTitle:@"确认"
//                                    otherButtonTitles:nil];
//            [alert show];
//        }else if([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:0]){
//            m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" data:[dicCallBack objectForKey:@"shop"] bundle:[NSBundle mainBundle]];
////            self.tabBarController.tabBar.hidden = YES;
//            m_CardViewController.tabBarController.hidesBottomBarWhenPushed = YES;
//
//            [self.navigationController pushViewController:m_CardViewController animated:YES];
//        }
//    }else{
//        LOGS(@"失败!");
//    }
//
//}

@end
