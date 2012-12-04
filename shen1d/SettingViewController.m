//
//  SettingViewController.m
//  shen1d
//
//  Created by Myth on 12-11-19.
//
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = @"设置";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:1 green:0.5882 blue:0 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;
        self.hidesBottomBarWhenPushed = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSueceeded)name: @"loginSueceeded" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSueceeded)name: @"logoutSueceeded" object:nil];

        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStyleGrouped];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
        [self.view addSubview:m_tableView];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 35, 30);
        [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *liftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:liftButton];
        
        
        Global *global = [Global sharedGlobal];
        m_GradientButton = [[GradientButton alloc]initWithFrame:CGRectMake(40, 100, 240, 44)];
        [m_GradientButton useRedDeleteStyle];
        [m_GradientButton addTarget:self action:@selector(clickBt:) forControlEvents:UIControlEventTouchUpInside];
        if (global.isLogined) {
            [m_GradientButton setTitle:@"退出登陆" forState:UIControlStateNormal];
            m_GradientButton.tag = 0;
        }else{
            [m_GradientButton setTitle:@"登陆" forState:UIControlStateNormal];
            m_GradientButton.tag = 1;
        }
        [m_tableView addSubview:m_GradientButton];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginSueceeded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logoutSueceeded" object:nil];
}
- (void)loginSueceeded
{
    [m_tableView reloadData];
    [m_GradientButton setTitle:@"退出登陆" forState:UIControlStateNormal];
    m_GradientButton.tag = 0;
}

- (void)logoutSueceeded
{
    [m_GradientButton setTitle:@"登陆" forState:UIControlStateNormal];
    m_GradientButton.tag = 1;

}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchChanged:(id)sender
{
    UISwitch *sw = sender;
    if (sw.on) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];
    }else{
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
}

- (void)clickBt:(id)sender
{
    GradientButton *bt = sender;
    if (bt.tag == 0) {
        UIAlertView *alert;
        DatabaseManager *dbManager = [DatabaseManager sharedDatabaseManager];
        if ([dbManager deleteTable:TableNamePersonalInfo]) {
            Global *global = [Global sharedGlobal];
            global.isLogined = NO;
            global.userId = nil;
            global.uname = nil;
            global.email = nil;
            global.password = nil;
            global.qrcode = nil;
            global.phone = nil;
            global.created = nil;
            [dbManager deleteTable:TableNameMyShops];
            alert = [[UIAlertView alloc]initWithTitle:@"登出成功!"
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确定"
                                    otherButtonTitles: nil];
            [alert show];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutSueceeded" object:nil];
        }else{
            alert = [[UIAlertView alloc]initWithTitle:@"登出失败!"
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确定"
                                    otherButtonTitles: nil];
            [alert show];
        }
    }else if(bt.tag == 1){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
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
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark -
#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    Global *global = [Global sharedGlobal];
//    if (global.isLogined) {
//        return 2;
//    }else{
//        return 1;
//    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([indexPath section] == 0) {
        UISwitch *m_switch = [[UISwitch alloc]initWithFrame:CGRectMake(220, 10, 80, 30)];
        [m_switch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        m_switch.on = YES;
        [cell addSubview:m_switch];
        cell.textLabel.text = @"是否接受推送通知";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end
