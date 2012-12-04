//
//  BusinessesViewController.m
//  shen1d
//
//  Created by Myth on 12-9-11.
//
//

#import "BusinessesViewController.h"

@interface BusinessesViewController ()

@end

@implementation BusinessesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = @"优惠";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.88 green:0.42 blue:0 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;
        UIButton *btBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [btBack setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
        btBack.frame = CGRectMake(0, 0, 40, 30);
        UIBarButtonItem *backButtom = [[UIBarButtonItem alloc]initWithCustomView:btBack];
        //        [self.navigationItem setBackBarButtonItem:backButtom];
        self.navigationItem.backBarButtonItem = backButtom;

        arrShops = [[NSMutableArray alloc]init];
        m_CLLocationManager = [[CLLocationManager alloc]init];
        m_CLLocationManager.delegate = self;
        [m_CLLocationManager startUpdatingLocation];

        

        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
        [self.view addSubview:m_tableView];
        
        m_searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, -38, 320, 38)];
        m_searchView.delegate = self;
        [self.view addSubview:m_searchView];
        
        blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        blackView.backgroundColor = [UIColor blackColor];

        
        btSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        btSearch.frame = CGRectMake(0, 0, 53, 30);
        [btSearch setBackgroundImage:[UIImage imageNamed:@"btn9"] forState:UIControlStateNormal];
        [btSearch addTarget:self action:@selector(showSearchView:) forControlEvents:UIControlEventTouchUpInside];
        btSearch.tag = 0;
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:btSearch];
        [self.navigationItem setRightBarButtonItem:rightButton];

        
//        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"搜索"
//                                                                       style:UIBarButtonItemStyleBordered
//                                                                      target:self
//                                                                      action:@selector(showSearchView:)];
//                                                         BarButtonSystemItem:UIBarButtonSystemItemSearch
//                                                                                    target:self
//                                                                                    action:@selector(showSearchView:)];
        
        UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        bt1.frame = CGRectMake(0, 0, 53, 30);
        [bt1 setBackgroundImage:[UIImage imageNamed:@"btn7"] forState:UIControlStateNormal];
        [bt1 addTarget:self action:@selector(showActionSheet:forEvent:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:bt1];
        [self.navigationItem setLeftBarButtonItem:leftButton];

        
//        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"筛选"
//                                                                      style:UIBarButtonItemStyleBordered
//                                                                     target:self
//                                                                     action:@selector(showActionSheet:forEvent:)];
//        [self.navigationItem setLeftBarButtonItem:leftButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    m_serviceGetShops = [[serviceGetShops alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
    [m_serviceGetShops sendRequestWithData:[NSString stringWithFormat:@"page=0&perpage=10&longitude=%f&latitude=%f&mode=default",m_CLLocationManager.location.coordinate.longitude,m_CLLocationManager.location.coordinate.latitude] addr:@"get_shops?"];
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

- (void)send:(NSString *)mode
{
//    if (m_serviceGetShops == nil) {
        m_serviceGetShops = [[serviceGetShops alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
//    }
    [m_serviceGetShops sendRequestWithData:[NSString stringWithFormat:@"page=0&perpage=10&longitude=%f&latitude=%f&mode=%@",m_CLLocationManager.location.coordinate.longitude,m_CLLocationManager.location.coordinate.latitude,mode] addr:@"get_shops?"];
}

-(void) showActionSheet:(id)sender forEvent:(UIEvent*)event
{
    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:nil];
//    [actionSheet destructiveButtonWithTitle:@"hoge" block:nil];
    [actionSheet addButtonWithTitle:@"默认" block:^{
        [self send:@"default"];
    }];
    [actionSheet addButtonWithTitle:@"距离" block:^{
        [self send:@"distance"];
        }];
    [actionSheet addButtonWithTitle:@"热度" block:^{
        [self send:@"hot"];
    }];

    [actionSheet cancelButtonWithTitle:@"取消" block:nil];
    actionSheet.cornerRadius = 5;
    //    NSLog(@"%@",actionSheet.)
    [actionSheet showWithTouch:event];
}


- (void)showSearchView:(id)sender
{
    
    if ([m_searchView.searchTextField.text isEqualToString:NSLocalizedString(@"Current Location", nil)]) {
        m_searchView.searchTextField.textColor = [UIColor blueColor];
    } else {
        m_searchView.searchTextField.textColor = [UIColor blackColor];
    }
    m_searchView.searchTextField.text = nil;
    if (btSearch.tag == 0) {
        [btSearch setBackgroundImage:[UIImage imageNamed:@"btn8"] forState:UIControlStateNormal];
        CGRect searchBarFrame = m_searchView.frame;
        searchBarFrame.origin.y = 0;
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             m_searchView.frame = searchBarFrame;
                         }
                         completion:^(BOOL completion) {
                             [m_searchView.searchTextField becomeFirstResponder];
                         }];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.35;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        blackView.frame = CGRectMake(0, 0, 320, 480);
        [blackView.layer addAnimation:transition forKey:nil];
        blackView.alpha = 0.8;
        [self.view addSubview:blackView];
        [self.view bringSubviewToFront:m_searchView];
        btSearch.tag = 1;
        
    }else if(btSearch.tag == 1){
        [self hideSearchBar:self];
        [btSearch setBackgroundImage:[UIImage imageNamed:@"btn9"] forState:UIControlStateNormal];
        btSearch.tag = 0;
    }
    
    
}





#pragma mark -
#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (m_CardViewController == nil) {
//        m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" data:[arrShops objectAtIndex:[indexPath row]] bundle:[NSBundle mainBundle]];
//    }
    m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" shopId:[[arrShops objectAtIndex:[indexPath row]] objectForKey:@"shopId"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:m_CardViewController animated:YES];
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
    cell.textLabel.text = [[arrShops objectAtIndex:[indexPath row]] objectForKey:@"shopName"];
    if ([[[arrShops objectAtIndex:[indexPath row]] objectForKey:@"discount_cnt"] intValue] > 0) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"discount_ico"]];
        img.frame = CGRectMake(270, 20, 40, 40);
        [cell addSubview:img];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrShops count];
}

#pragma mark -
#pragma mark NiftySearchView Delegate Methods


- (void)niftySearchViewResigend
{
    NSLog(@"resignSearchView");
    [self hideSearchBar:self];
}

- (void)routeButtonClicked:(UITextField *)searchTextField
{
    [self send:searchTextField.text];
    [btSearch setBackgroundImage:[UIImage imageNamed:@"btn9"] forState:UIControlStateNormal];
    btSearch.tag = 0;
}

- (IBAction)hideSearchBar:(id)sender
{
    [m_searchView.searchTextField resignFirstResponder];
    CGRect searchBarFrame = m_searchView.searchTextField.frame;
    searchBarFrame.origin.y = -38;
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         m_searchView.frame = searchBarFrame;
                     }
                     completion:^(BOOL completion){
                         
                     }];
    self.navigationItem.rightBarButtonItem.title = @"搜索";
    self.navigationItem.rightBarButtonItem.tag = 0;

    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [blackView.layer addAnimation:transition forKey:nil];
    blackView.frame = CGRectMake(0, - blackView.frame.size.height, 320, blackView.frame.size.height);
    
    transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    blackView.alpha = 1;
    [blackView.layer addAnimation:transition forKey:nil];
    [blackView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.45];
    
}
#pragma mark -
#pragma mark CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [m_CLLocationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark serviceCallBack
- (void)serviceGetShopsCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
{
//    UIAlertView *alert;
    if ([dicCallBack objectForKey:@"state"] != nil) {
        if ([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:1]) {
//            alert = [[UIAlertView alloc]initWithTitle:[dicCallBack objectForKey:@"error"]
//                                              message:nil
//                                             delegate:self
//                                    cancelButtonTitle:@"确认"
//                                    otherButtonTitles:nil];
//            [alert show];
            LOGS(@"%@",error);
        }else if([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:0]){
            arrShops = [dicCallBack objectForKey:@"shops"];
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
