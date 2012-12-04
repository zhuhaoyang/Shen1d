//
//  TrendsViewController.m
//  shen1d
//
//  Created by Myth on 12-9-27.
//
//




#import "TrendsViewController.h"

@interface TrendsViewController ()

@end

@implementation TrendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)changeSegmented
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.7];
    if (segment.selectedSegmentIndex == 1) {
        [segment setImage:[UIImage imageNamed:@"btn_left"] forSegmentAtIndex:0];
        [segment setImage:[UIImage imageNamed:@"btn_right_selected"] forSegmentAtIndex:1];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [m_tableView removeFromSuperview];
        [self.view addSubview:m_PersonalCenterView];
        
    }else if(segment.selectedSegmentIndex == 0){
        [segment setImage:[UIImage imageNamed:@"btn_left_selected"] forSegmentAtIndex:0];
        [segment setImage:[UIImage imageNamed:@"btn_right"] forSegmentAtIndex:1];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [m_PersonalCenterView removeFromSuperview];
        [self.view addSubview:m_tableView];
    }
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用某个方法
    //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];

    
}

- (void)loginSueceeded
{
    [self getDiscounts];
}

- (void)logoutSueceeded
{
    [arrDiscounts removeAllObjects];
    [m_tableView reloadData];
}

- (void)setting
{
    SettingViewController *m_SettingViewController = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:m_SettingViewController animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrDiscounts = [[NSMutableArray alloc]initWithCapacity:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSueceeded)name: @"loginSueceeded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSueceeded)name: @"logoutSueceeded" object:nil];
    
    UIButton *btSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    btSetting.frame = CGRectMake(0, 0, 30, 30);
    [btSetting setBackgroundImage:[UIImage imageNamed:@"btn_gear"] forState:UIControlStateNormal];
    [btSetting addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:btSetting];
    [self.navigationItem setRightBarButtonItem:rightButton];

    

    NSArray *arrItems = [[NSArray alloc]initWithObjects:@"",@"", nil];
    segment = [[UISegmentedControl alloc]initWithItems:arrItems];
    
    [segment setImage:[UIImage imageNamed:@"btn_left_selected"] forSegmentAtIndex:0];
    [segment setImage:[UIImage imageNamed:@"btn_right"] forSegmentAtIndex:1];
    // Image between segment selected on the left and unselected on the right.
    //        [segment setDividerImage:[UIImage imageNamed:@"btn_long"] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //        [segment setDividerImage:[UIImage imageNamed:@"btn_long"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    //        [segment setBackgroundImage:[UIImage imageNamed:@"btn_long"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //        segment.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [segment setWidth:61 forSegmentAtIndex:0];
    [segment setWidth:61 forSegmentAtIndex:1];
    //        [segment setImage:[UIImage imageNamed:@"btn_long"] forSegmentAtIndex:0];
    [segment addTarget:self action:@selector(changeSegmented) forControlEvents:UIControlEventValueChanged];
    segment.segmentedControlStyle = UISegmentedControlStyleBar;
    //        segment.selectedSegmentIndex = 0;
    //        [segment setImage:[UIImage imageNamed:@"btn_long"] forSegmentAtIndex:0];
    //        [segment setBackgroundColor:[UIColor redColor]];
    //        [segment setBackgroundImage:[UIImage imageNamed:@"btn_long"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = segment;
    
    
    m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49) style:UITableViewStylePlain];
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    m_PersonalCenterView = [[PersonalCenterView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
    
    [self getDiscounts];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginSueceeded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logoutSueceeded" object:nil];
}

- (void)getDiscounts
{
    Global *global = [Global sharedGlobal];
    if (global.isLogined) {
        m_serviceGetDiscounts = [[serviceGetDiscounts alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
        [m_serviceGetDiscounts sendRequestWithData:[NSString stringWithFormat:@"userId=%@",global.userId] addr:@"get_discounts?"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" shopId:[[arrDiscounts objectAtIndex:[indexPath row]] objectForKey:@"shopId"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:m_CardViewController animated:YES];//    if (m_CardViewController == nil) {
//        m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" data:nil bundle:[NSBundle mainBundle]];
//    }    [self.navigationController pushViewController:m_CardViewController animated:YES];

//    NSString *str = @"你好";
//    printf("%c", pinyinFirstLetter([str characterAtIndex:0]));
}
#pragma mark -
#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = [[arrDiscounts objectAtIndex:[indexPath row]]objectForKey:@"content"];
    UILabel *lbShopName = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 290, 40)];
    lbShopName.textAlignment = NSTextAlignmentLeft;
    lbShopName.text = [[arrDiscounts objectAtIndex:[indexPath row]]objectForKey:@"shopName"];
    lbShopName.font = [UIFont boldSystemFontOfSize:22];
    [cell addSubview:lbShopName];
    
    UILabel *lbContent = [[UILabel alloc]initWithFrame:CGRectMake(30, 40, 290, 30)];
    lbContent.textAlignment = NSTextAlignmentLeft;
    lbContent.text = [[arrDiscounts objectAtIndex:[indexPath row]]objectForKey:@"content"];
    lbContent.font = [UIFont systemFontOfSize:15];
    [cell addSubview:lbContent];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([arrDiscounts isKindOfClass:[NSMutableArray class]]) {
            return [arrDiscounts count];
    }else{
        return 0;
    }

}

#pragma mark -
#pragma mark serviceCallBack
- (void)serviceGetDiscountsCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
{
    UIAlertView *alert;
    if ([dicCallBack objectForKey:@"state"] != nil) {
        if ([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:1]) {
            alert = [[UIAlertView alloc]initWithTitle:[dicCallBack objectForKey:@"error"]
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确认"
                                    otherButtonTitles:nil];
            [alert show];
        }else if([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:0]){
            arrDiscounts = [dicCallBack objectForKey:@"discounts"];
            [m_tableView reloadData];
        }
    }else{
        LOGS(@"失败");
    }
    
}

//- (void)serviceGetShopCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
//{
//    UIAlertView *alert;
//    if ([dicCallBack objectForKey:@"state"] != nil) {
//        if ([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:1]) {
//            alert = [[UIAlertView alloc]initWithTitle:[dicCallBack objectForKey:@"error"]
//                                              message:nil
//                                             delegate:self
//                                    cancelButtonTitle:@"确认"
//                                    otherButtonTitles:nil];
//            [alert show];
//        }else if([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:0]){
//            m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" data:[dicCallBack objectForKey:@"shop"] bundle:[NSBundle mainBundle]];
//            [self.navigationController pushViewController:m_CardViewController animated:YES];
//        }
//    }else{
//        LOGS(@"失败");
//    }
//    
//}


@end
