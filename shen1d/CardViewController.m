//
//  CardViewController.m
//  shen1d
//
//  Created by Myth on 12-9-17.
//
//

#import "CardViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kWBSDKDemoAppKey @"3448415748"
#define kWBSDKDemoAppSecret @"03aa2cb686379d48f3ea0117607590e3"

#ifndef kWBSDKDemoAppKey
#error
#endif

#ifndef kWBSDKDemoAppSecret
#error
#endif

#define kWBAlertViewLogOutTag 100
#define kWBAlertViewLogInTag  101


@interface CardViewController ()

@property (assign, nonatomic) bool isShow;

@end

@implementation CardViewController
@synthesize isShow = _isShow;




- (id)initWithNibName:(NSString *)nibNameOrNil  shopId:(NSString *)shopId bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        SinaWeibo *sinaweibo = [self sinaweibo];
        sinaweibo.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSueceeded)name: @"loginSueceeded" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSueceeded)name: @"logoutSueceeded" object:nil];
        self.hidesBottomBarWhenPushed = YES;
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 35, 30);
        [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *liftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:liftButton];

        
        
        
        UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        [bt1 setBackgroundImage:[UIImage imageNamed:@"btn_navi"] forState:UIControlStateNormal];
        bt1.frame = CGRectMake(0, 0, 50, 44);
        [bt1 addTarget:self action:@selector(map) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *img1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_navi"]];
        img1.frame = CGRectMake(12.5, 5, 25, 30);
        [bt1 addSubview:img1];
        
        UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
//        [bt2 setBackgroundImage:[UIImage imageNamed:@"btn_web"] forState:UIControlStateNormal];
        bt2.frame = CGRectMake(50, 0, 50, 44);
        UIImageView *img2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_web"]];
        img2.frame = CGRectMake(12.5, 5, 25, 30);
        [bt2 addSubview:img2];
        
        UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
//        [bt3 setBackgroundImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
        bt3.frame = CGRectMake(100, 0, 50, 44);
        bt3.tag = 3;
        [bt3 addTarget:self action:@selector(showActionSheet:forEvent:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *img3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_share"]];
        img3.frame = CGRectMake(12.5, 5, 25, 30);
        [bt3 addSubview:img3];
        
        UIButton *bt4 = [UIButton buttonWithType:UIButtonTypeCustom];
//        [bt4 setBackgroundImage:[UIImage imageNamed:@"btn_phone"] forState:UIControlStateNormal];
        bt4.frame = CGRectMake(150, 0, 50, 44);
        bt4.tag = 4;
        [bt4 addTarget:self action:@selector(showActionSheet:forEvent:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *img4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_phone"]];
        img4.frame = CGRectMake(12.5, 5, 25, 30);
        [bt4 addSubview:img4];
        
        UIView *title = [[UIView alloc]initWithFrame:CGRectMake(0, 2, 200, 44)];
        [title addSubview:bt1];
        [title addSubview:bt2];
        [title addSubview:bt3];
        [title addSubview:bt4];
        self.navigationItem.titleView = title;
        
        btn_tag = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_tag.frame = CGRectMake(0, 0, 35, 30);
        [btn_tag setBackgroundImage:[UIImage imageNamed:@"btn_tag"] forState:UIControlStateNormal];
        [btn_tag addTarget:self action:@selector(turnOver:) forControlEvents:UIControlEventTouchUpInside];
        btn_tag.tag = 107;
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:btn_tag];
        [self.navigationItem setRightBarButtonItem:rightButton];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
//        genieView = [[AZGenieView alloc]initWithFrame:CGRectMake(0, 0, 320, 460 - 49 - 44)];
//        self.isShow = YES;         
        frontView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44)];
        //        QRCode.layer.shadowColor = [UIColor blackColor].CGColor;
        //        QRCode.layer.shadowOffset = CGSizeMake(0, 0);
        //        QRCode.layer.shadowOpacity = 1;
        //        QRCode.layer.shadowRadius = 20.0;

        
//        btStoreUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btStoreUp = [[GradientButton alloc]initWithFrame:CGRectMake(110, 330, 100, 30)];
//        btStoreUp.frame = CGRectMake(133, 310, 55, 30);
//        [btStoreUp setBackgroundColor:[UIColor colorWithRed:0.88 green:0.42 blue:0 alpha:1]];
        [btStoreUp useSimpleOrangeStyle];
        [btStoreUp setTitle:@"添加到卡包" forState:UIControlStateNormal];
        btStoreUp.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//        btStoreUp = [UIButton buttonWithType:UIButtonTypeCustom];
//        btStoreUp.frame = CGRectMake(133, 310, 55, 30);
//        [btStoreUp setBackgroundImage:[UIImage imageNamed:@"btn5"] forState:UIControlStateNormal];
        [btStoreUp addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btLogin = [[GradientButton alloc]initWithFrame:CGRectMake(80, 330, 180, 30)];
        [btLogin useSimpleOrangeStyle];
        [btLogin setTitle:@"添加到卡包需要登陆" forState:UIControlStateNormal];
        btLogin.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [btLogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        
//        UIImage *screenshot = [self screenshotForViewController];
//        [genieView setDelegate:self];
//        genieView.renderImage = screenshot;
//        [genieView setRenderFrame:CGRectMake(0, 0, 100, 100) andTargetFrame:CGRectMake(133, 310, 55, 30)];
        
        UIImageView *imgBackGround = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        imgBackGround.frame = CGRectMake(0, 0, 320, 460-44);
        [frontView addSubview:imgBackGround];
        
        UIImageView *imgCard = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"singlecard"]];
        imgCard.frame = CGRectMake(10, 20, 299, 190);
        [frontView addSubview:imgCard];
        Global *global = [Global sharedGlobal];

        if (global.isLogined) {
            [frontView addSubview:btStoreUp];
        }else{
            [frontView addSubview:btLogin];
        }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        [frontView addSubview:genieView];
        
        if (global.isLogined) {
            QRCode = [[UIImageView alloc]initWithImage:global.qrcode];
        }else{
            QRCode = [[UIImageView alloc]initWithImage:[QRCodeGenerator qrImageForString:@"error" imageSize:100]];
        }
        QRCode.frame = CGRectMake(193, 95, 100, 100);
        [frontView addSubview:QRCode];

        //        backView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:frontView];

        
        
        m_shopId = shopId;
        m_serviceGetShop = [[serviceGetShop alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
        [m_serviceGetShop sendRequestWithData:[NSString stringWithFormat:@"shopId=%@",m_shopId] addr:@"get_shop?"];
        
        activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.frame = CGRectMake(150, 200, 20, 20);
        [self.view addSubview:activity];
        [activity startAnimating];
//        dicShopInfo = [[NSDictionary alloc]initWithDictionary:dic];
            }
    return self;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginSueceeded
{
    [btLogin removeFromSuperview];
    [frontView addSubview:btStoreUp];
    Global *global = [Global sharedGlobal];
    [QRCode removeFromSuperview];
    QRCode = [[UIImageView alloc]initWithImage:global.qrcode];
    QRCode.frame = CGRectMake(193, 95, 100, 100);
    [frontView addSubview:QRCode];
}
- (void)logoutSueceeded
{
    [btStoreUp removeFromSuperview];
    [frontView addSubview:btLogin];
    [QRCode removeFromSuperview];
    QRCode = [[UIImageView alloc]initWithImage:[QRCodeGenerator qrImageForString:@"error" imageSize:100]];
    QRCode.frame = CGRectMake(193, 95, 100, 100);
    [frontView addSubview:QRCode];
}



- (void)turnOver:(id)sender
{
    UIBarButtonItem *bt = sender;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.7];
    if (bt.tag == 107) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [btn_tag setBackgroundImage:[UIImage imageNamed:@"btn_card"] forState:UIControlStateNormal];
        [frontView removeFromSuperview];
//        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        [self.view addSubview:cardBackView];

        bt.tag = 108;
    }else if(bt.tag == 108){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [btn_tag setBackgroundImage:[UIImage imageNamed:@"btn_tag"] forState:UIControlStateNormal];
        [cardBackView removeFromSuperview];
//        frontView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        [self.view addSubview:frontView];

        bt.tag = 107;
    }

    [UIView setAnimationDelegate:self];
    // 动画完毕后调用某个方法
    //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginSueceeded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logoutSueceeded" object:nil];
}

- (void)viewWillLayoutSubviews
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view from its nib.
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

- (void)remove
{
    [QRCode removeFromSuperview];
}

- (UIImage *)screenshotForViewController
{
    UIGraphicsBeginImageContextWithOptions(QRCode.bounds.size, YES, [[UIScreen mainScreen] scale]);
    [QRCode.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

- (void)geineAnimationDone
{
    if (self.isShow)
        QRCode.hidden = NO;
}

- (void)login
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
}

- (void)doClick:(id)sender {
    Global *global = [Global sharedGlobal];
    m_serviceAddMyShop = [[serviceAddMyShop alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
    NSString * userId = global.userId;
    [m_serviceAddMyShop sendRequestWithData:[NSString stringWithFormat:@"userId=%@&shopId=%@",userId,[dicShopInfo objectForKey:@"shopId"]] addr:@"add_my_shop?"];
    
    
}

- (void)map
{
    CLLocationCoordinate2D test;
    if ([[dicShopInfo objectForKey:@"latitude"] isKindOfClass:[NSString class]]&&[[dicShopInfo objectForKey:@"longitude"] isKindOfClass:[NSString class]]) {
        test.latitude = [[dicShopInfo objectForKey:@"latitude"] floatValue];
        test.longitude = [[dicShopInfo objectForKey:@"longitude"] floatValue];
        m_MapViewController = [[MapViewController alloc]initWithNibName:@"MapViewController" coordinate:test shopName:[dicShopInfo objectForKey:@"shopName"] bundle:[NSBundle mainBundle]];


    }else{
        m_MapViewController = [[MapViewController alloc]initWithNibName:@"MapViewController" shopName:[dicShopInfo objectForKey:@"shopName"] bundle:[NSBundle mainBundle]];

    }


    //    test.latitude = [[dicShopInfo objectForKey:@"latitude"] floatValue];
       [self.navigationController pushViewController:m_MapViewController animated:YES];
}

- (void) showActionSheet:(id)sender forEvent:(UIEvent*)event
{
    UIButton *bt = sender;
    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:nil];

    if (bt.tag == 3) {

            //    [actionSheet destructiveButtonWithTitle:Tel block:nil];
        
            [actionSheet addButtonWithTitle:@"分享到微博" block:^{
                SinaWeibo *sinaweibo = [self sinaweibo];
                if ([sinaweibo isAuthValid]) {

                                        
                    
//                    [sinaweibo requestWithURL:@"statuses/upload.json"
//                                       params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                               @"test", @"status", nil]
//                                   httpMethod:@"POST"
//                                     delegate:self];
                    
//                    [sinaweibo requestWithURL:@"statuses/upload.json"
//                                       params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                               [NSString stringWithFormat:@"%@,这家店挺不错的哦!",[dicShopInfo objectForKey:@"shopName"]], @"status",
//                                               [UIImage imageNamed:@"search"], @"pic", nil]
//                                   httpMethod:@"POST"
//                                     delegate:self];
                    [sinaweibo requestWithURL:@"statuses/upload.json"
                                       params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               [NSString stringWithFormat:@"%@,这家店挺不错的哦!",[dicShopInfo objectForKey:@"shopName"]], @"status",
                                               [UIImage imageNamed:@"search"], @"pic", nil]
                                   httpMethod:@"POST"
                                     delegate:self];
                }else{
                    [sinaweibo logIn];
                }

                

            }];
            [actionSheet addButtonWithTitle:@"分享到微信" block:^{
//                [engine logOut];
                SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                req.bText = YES;
                req.text = [NSString stringWithFormat:@"%@,这家店挺不错的哦!",[dicShopInfo objectForKey:@"shopName"]];
                //    req.scene = _scene;
                
                [WXApi sendReq:req];
                
            }];
            [actionSheet cancelButtonWithTitle:@"取消" block:nil];
            actionSheet.cornerRadius = 5;
            //    NSLog(@"%@",actionSheet.)
            [actionSheet showWithTouch:event];
    }else if(bt.tag == 4){
            //    [actionSheet destructiveButtonWithTitle:Tel block:nil];
            Tel = [NSString stringWithFormat:@"%@",[dicShopInfo objectForKey:@"contact_phone"]];
            [actionSheet addButtonWithTitle:Tel block:^{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否拨打电话?"
                                                               message:Tel
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"确认",@"取消" ,nil];
                alert.tag = 9;
                [alert show];
                
                

            }];
            [actionSheet cancelButtonWithTitle:@"取消" block:nil];
            actionSheet.cornerRadius = 5;
            //    NSLog(@"%@",actionSheet.)
            [actionSheet showWithTouch:event];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9) {
        if (buttonIndex == 0) {
            LOGS(@"%@",Tel);
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",Tel]]];
            
        }else if(buttonIndex == 1){
            LOGS(@"取消打电话");
        }
    }
}






#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    if ([sinaweibo isAuthValid]) {
        
        [sinaweibo requestWithURL:@"statuses/upload.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%@,这家店挺不错的哦!",[dicShopInfo objectForKey:@"shopName"]], @"status",
                                   [UIImage imageNamed:@"search"], @"pic", nil]
                       httpMethod:@"POST"
                         delegate:self];
    }
//    [self storeAuthData];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
//    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
//    [self removeAuthData];
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享失败!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alert show];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享到微博成功!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alert show];
}


- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}


#pragma mark -
#pragma mark serviceCallBack
- (void)serviceAddMyShopCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
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
            DatabaseManager *dbManager = [DatabaseManager sharedDatabaseManager];
            [dbManager insertMyShops:[[NSArray alloc]initWithObjects:dicShopInfo, nil]];
            self.isShow = !self.isShow;
            if (!self.isShow)
                QRCode.hidden = YES;
//            [genieView genieAnimationShow:self.isShow withDuration:0.4f];
            [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.4f];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"storeupSueceeded" object:nil];
            alert = [[UIAlertView alloc]initWithTitle:@"收藏成功!"
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确认"
                                    otherButtonTitles:nil];
            [alert show];
            
        }
    }else{
        LOGS(@"失败");
    }
    
}

- (void)serviceGetShopCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
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
            
            
            
                       
//            engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
//            [engine setRootViewController:self];
//            [engine setDelegate:self];
//            [engine setRedirectURI:@"http://"];
//            [engine setIsUserExclusive:NO];
            
            
            

            dicShopInfo = [dicCallBack objectForKey:@"shop"];
            UILabel *labelShopName = [[UILabel alloc]initWithFrame:CGRectMake(40, 233, 240, 28)];
            labelShopName.text = [dicShopInfo objectForKey:@"shopName"];
            [labelShopName setFont:[UIFont boldSystemFontOfSize:22]];
            labelShopName.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            
            UILabel *labelAddress = [[UILabel alloc]initWithFrame:CGRectMake(40, 261, 240, 21)];
            labelAddress.text = [NSString stringWithFormat:@"地址:%@",[dicShopInfo objectForKey:@"address"]];
            [labelAddress setFont:[UIFont systemFontOfSize:17]];
            labelAddress.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            
            UILabel *labelPhone = [[UILabel alloc]initWithFrame:CGRectMake(40, 284, 240, 21)];
            labelPhone.text = [NSString stringWithFormat:@"电话:%@",[dicShopInfo objectForKey:@"contact_phone"]];
            [labelPhone setFont:[UIFont systemFontOfSize:17]];
            labelPhone.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            
            [frontView addSubview:labelShopName];
            [frontView addSubview:labelAddress];
            [frontView addSubview:labelPhone];
            
            cardBackView = [[CardBackView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49) discounts:[dicShopInfo objectForKey:@"discounts"]];
            
//            [genieView setRenderFrame:CGRectMake(0, 0, 100, 100) andTargetFrame:CGRectMake(133, 310, 55, 30)];

            
            [activity stopAnimating];
            [activity removeFromSuperview];
            activity = nil;
        }
    }else{
        LOGS(@"失败");
    }
    
}



@end
