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




- (id)initWithNibName:(NSString *)nibNameOrNil  data:(NSDictionary *)dic bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [bt1 setTitle:@"位置" forState:UIControlStateNormal];
        bt1.frame = CGRectMake(0, 5, 50, 30);
        [bt1 addTarget:self action:@selector(map) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [bt2 setTitle:@"网站" forState:UIControlStateNormal];
        bt2.frame = CGRectMake(50, 5, 50, 30);

        UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [bt3 setTitle:@"分享" forState:UIControlStateNormal];
        bt3.frame = CGRectMake(100, 5, 50, 30);
        bt3.tag = 3;
        [bt3 addTarget:self action:@selector(showActionSheet:forEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *bt4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [bt4 setTitle:@"电话" forState:UIControlStateNormal];
        bt4.frame = CGRectMake(150, 5, 50, 30);
        bt4.tag = 4;
        [bt4 addTarget:self action:@selector(showActionSheet:forEvent:) forControlEvents:UIControlEventTouchUpInside];

        UIView *title = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        [title addSubview:bt1];
        [title addSubview:bt2];
        [title addSubview:bt3];
        [title addSubview:bt4];
//        title.backgroundColor = [UIColor blackColor];
        self.navigationItem.titleView = title;
        
        
        genieView = [[AZGenieView alloc]initWithFrame:CGRectMake(0, 0, 320, 460 - 49 - 44)];
        self.isShow = YES;
//        [genieView addSubview:self.flowerView];
        
                

        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"翻面"
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:self
                                                                                action:@selector(turnOver:)];
        rightButton.tag = 107;
        [self.navigationItem setRightBarButtonItem:rightButton];
        
        frontView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
//        frontView.backgroundColor = [UIColor redColor];
        
        QRCode = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2wm.png"]];
        QRCode.frame = CGRectMake(5, 100, 310, 200);
        [genieView addSubview:QRCode];

//        QRCode.layer.shadowColor = [UIColor blackColor].CGColor;
//        QRCode.layer.shadowOffset = CGSizeMake(0, 0);
//        QRCode.layer.shadowOpacity = 1;
//        QRCode.layer.shadowRadius = 20.0;
        
//        [frontView addSubview:QRCode];
        
        UIButton *btStoreUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btStoreUp.frame = CGRectMake(110, 310, 100, 40);
        [btStoreUp setTitle:@"收藏到卡包" forState:UIControlStateNormal];
        [btStoreUp addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];

        
        UIImage *screenshot = [self screenshotForViewController];
        [genieView setDelegate:self];
        genieView.renderImage = screenshot;
        [genieView setRenderFrame:QRCode.frame andTargetFrame:btStoreUp.frame];

        
        [genieView addSubview:btStoreUp];
        [frontView addSubview:genieView];

        cardBackView = [[CardBackView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
//        backView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:frontView];

        engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
        [engine setRootViewController:self];
        [engine setDelegate:self];
        [engine setRedirectURI:@"http://"];
        [engine setIsUserExclusive:NO];

        
    }
    return self;
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
        [frontView removeFromSuperview];
//        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        [self.view addSubview:cardBackView];

        bt.tag = 108;
    }else if(bt.tag == 108){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
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

- (void)doClick:(id)sender {
    self.isShow = !self.isShow;
    if (!self.isShow)
        QRCode.hidden = YES;
    [genieView genieAnimationShow:self.isShow withDuration:0.4f];
    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.4f];
}

- (void)map
{
    m_MapViewController = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:m_MapViewController animated:YES];
}

- (void) showActionSheet:(id)sender forEvent:(UIEvent*)event
{
    UIButton *bt = sender;
    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:nil];

    if (bt.tag == 3) {

            //    [actionSheet destructiveButtonWithTitle:Tel block:nil];
        
            [actionSheet addButtonWithTitle:@"分享到微博" block:^{
                if ([engine isLoggedIn]) {
                    WBSendView *sendView = [[WBSendView alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret text:@"test" image:[UIImage imageNamed:@"bg.png"]];
                    [sendView setDelegate:self];
                    
                    [sendView show:YES];
                    
                }else{
                    [engine logIn];
                }
                

            }];
            [actionSheet addButtonWithTitle:@"分享到微信" block:^{
//                [engine logOut];
                SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                req.bText = YES;
                req.text = @"test!!test!!";
                //    req.scene = _scene;
                
                [WXApi sendReq:req];
            }];
            [actionSheet cancelButtonWithTitle:@"取消" block:nil];
            actionSheet.cornerRadius = 5;
            //    NSLog(@"%@",actionSheet.)
            [actionSheet showWithTouch:event];
    }else if(bt.tag == 4){
            //    [actionSheet destructiveButtonWithTitle:Tel block:nil];
            Tel = [[NSString alloc]initWithFormat:@"18657103787"];
            [actionSheet addButtonWithTitle:Tel block:^{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否拨打电话?"
                                                               message:Tel
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"确认",@"取消" ,nil];
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
    if (buttonIndex == 0) {
        LOGS(@"%@",Tel);
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",Tel]]];
        
    }else if(buttonIndex == 1){
        LOGS(@"取消打电话");
    }
}


#pragma mark - WBEngineDelegate Methods

#pragma mark Authorize

- (void)engineAlreadyLoggedIn:(WBEngine *)engine
{
    //    [indicatorView stopAnimating];
    if ([engine isUserExclusive])
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"请先登出！"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)engineDidLogIn:(WBEngine *)engine
{
    //    [indicatorView stopAnimating];
//    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
//													   message:@"登录成功！"
//													  delegate:self
//											 cancelButtonTitle:@"确定"
//											 otherButtonTitles:nil];
//    [alertView setTag:kWBAlertViewLogInTag];
//	[alertView show];
    WBSendView *sendView = [[WBSendView alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret text:@"test" image:[UIImage imageNamed:@"bg.png"]];
    [sendView setDelegate:self];
    
    [sendView show:YES];
    
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
    //    [indicatorView stopAnimating];
    NSLog(@"didFailToLogInWithError: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登录失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
}

- (void)engineDidLogOut:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登出成功！"
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
    [alertView setTag:kWBAlertViewLogOutTag];
	[alertView show];
}

- (void)engineNotAuthorized:(WBEngine *)engine
{
    
}

- (void)engineAuthorizeExpired:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"请重新登录！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
}

#pragma mark - WBSendViewDelegate Methods

- (void)sendViewDidFinishSending:(WBSendView *)view
{
    [view hide:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"微博发送成功！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
}

- (void)sendView:(WBSendView *)view didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    [view hide:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"微博发送失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
}

- (void)sendViewNotAuthorized:(WBSendView *)view
{
    [view hide:YES];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)sendViewAuthorizeExpired:(WBSendView *)view
{
    [view hide:YES];
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - WBRequestDelegate Methods

- (void)request:(WBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)request:(WBRequest *)request didReceiveRawData:(NSData *)data
{
    
}

- (void)request:(WBRequest *)request didFailWithError:(NSError *)error
{
    
}

- (void)request:(WBRequest *)request didFinishLoadingWithResult:(id)result
{
    
}


@end
