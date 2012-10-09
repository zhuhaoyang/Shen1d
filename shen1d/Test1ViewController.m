//
//  Test1ViewController.m
//  shen1d
//
//  Created by Peter Zhu on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Test1ViewController.h"
#import <QuartzCore/QuartzCore.h>
//@interface UIView (PrivateMethods)
//+ (void)setAnimationPosition:(CGPoint)point;
//@end
@interface Test1ViewController ()
    @property (assign, nonatomic) bool isShow;
//    UIImageView *flowerView;

@property (nonatomic,strong) UIButton *flowerView;
//    UIButton *targetButton;

//    - (IBAction)doClick:(id)sender;
@end

@implementation Test1ViewController
//@synthesize genieView = _genieView;
@synthesize flowerView = _flowerView;
//@synthesize targetButton;
@synthesize isShow = _isShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        genieView = [[AZGenieView alloc]initWithFrame:CGRectMake(0, 0, 320, 460 - 49 - 44)];
        self.isShow = YES;
        
        
//        LOGS(@"%@",self.genieView);
        // Custom initialization
//        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
//        [bt setImage:[UIImage imageNamed:@"02.jpg"] forState:UIControlStateNormal];
//        [bt setFrame:CGRectMake(0,100 , 320, 300)];
//        [[bt.imageView layer] setShadowOffset:CGSizeMake(5, 5)];
//        [[bt.imageView layer] setShadowRadius:6];
//        [[bt.imageView layer] setShadowOpacity:1];
//        [[bt.imageView layer] setShadowColor:[UIColor blueColor].CGColor];
//        [self.view addSubview:bt];
        
        
        
        
//        UIImageView *imgvPhoto  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"02.jpg"]];
        self.flowerView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.flowerView setImage:[UIImage imageNamed:@"02.jpg"] forState:UIControlStateNormal];
        self.flowerView.frame = CGRectMake(40, 50, 200, 200);
        [self.flowerView addTarget:self action:@selector(testJsonParser) forControlEvents:UIControlEventTouchUpInside];
//        //添加边框
//        CALayer *layer = [imgvPhoto layer];
//        layer.borderColor = [[UIColor whiteColor] CGColor];
//        layer.borderWidth = 0.0f;
//
        //添加四个边阴影
        self.flowerView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.flowerView.layer.shadowOffset = CGSizeMake(0, 0);
        self.flowerView.layer.shadowOpacity = 1;
        self.flowerView.layer.shadowRadius = 20.0;

//        //添加两个边阴影
//        imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
//        imgvPhoto.layer.shadowOffset = CGSizeMake(4, 4);
//        imgvPhoto.layer.shadowOpacity = 0.5;
//        imgvPhoto.layer.shadowRadius = 2.0;
        
        
        
//        //设置layer
//        
////        CALayer *layer=[backView layer];
//        
//        //是否设置边框以及是否可见
//        
//        [layer setMasksToBounds:YES];
//        
//        //设置边框圆角的弧度
//        
//        [layer setCornerRadius:10.0];  
//        
//        //设置边框线的宽  
//        
//        [layer setBorderWidth:1];  
//        
//        //设置边框线的颜色  
//        
//        [layer setBorderColor:[[UIColor blackColor] CGColor]];
        
        [genieView addSubview:self.flowerView];
        
        UIImage *screenshot = [self screenshotForViewController];
        //    [self.genieView setDelegate:self];
        genieView.delegate = self;
        genieView.renderImage = screenshot;
        CGRect a = CGRectMake(240, 300, 70, 40);
        [genieView setRenderFrame:self.flowerView.frame andTargetFrame:/*self.targetButton.frame*/a];
        [self.view addSubview:genieView];
        
        bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        bt.frame = CGRectMake(240, 300, 70, 40);
        [bt setTitle:@"吸收" forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
        [genieView addSubview:bt];
        
        
        
    }
    return self;
}

- (void)suck
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelay:0];
    self.flowerView.frame = CGRectMake(300, 380, 0, 0);
    [UIView commitAnimations];
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.4
                                                  target: self
                                                selector: @selector(remove)
                                                userInfo: nil repeats: NO];
    //    [UIView beginAnimations:@"suckEffect" context:nil];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationTransition:103 forView:imgvPhoto cache:NO];
//    [UIView setAnimationPosition:CGPointMake(300, 370)];
//    [imgvPhoto removeFromSuperview]
//    [UIView commitAnimations];
    
//    CATransition* animation  = [CATransition animation];
//    animation.type           = @"suckEffect";
//    animation.duration       = 1.0f;
//    animation.timingFunction =  UIViewAnimationCurveEaseInOut;
//    imgvPhoto.opaque            = 1.0f;
//    [imgvPhoto.layer addAnimation:animation forKey:@"transitionViewAnimation"];
//    [imgvPhoto removeFromSuperview];
//    [animation setAnimationPosition:CGPointMake(300, 300)];
    
//    [UIView beginAnimations:@"suck" context:NULL];
//    [UIView setAnimationTransition:103 forView:imgvPhoto cache:YES];
//    [UIView setAnimationPosition:CGPointMake(12, 345)];
//    [imgvPhoto removeFromSuperview];
//    [UIView commitAnimations];

}

- (void)remove
{
    [self.self.flowerView removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
}

- (UIImage *)screenshotForViewController
{
    UIGraphicsBeginImageContextWithOptions(self.flowerView.bounds.size, YES, [[UIScreen mainScreen] scale]);
    [self.flowerView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

- (void)geineAnimationDone
{
    if (self.isShow)
        self.flowerView.hidden = NO;
}

- (void)doClick:(id)sender {
    self.isShow = !self.isShow;
    if (!self.isShow)
        self.flowerView.hidden = YES;
    [genieView genieAnimationShow:self.isShow withDuration:0.4f];
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


//测试json的解析
-(void)testJsonParser//: (NSString *) jsonString
{
//    NSString *jsonString = [[NSString alloc] initWithFormat:@"{\"userInfo\":{\"userName\":\"徐泽宇\",\"sex\":\"男\"}}"];
//    NSLog(@"正在解析json字符串是：%@",jsonString);
//    
//    SBJsonParser * parser = [[SBJsonParser alloc] init];
//    NSError * error = nil;
//    NSMutableDictionary *jsonDic = [parser objectWithString:jsonString error:&error];
//    NSMutableDictionary * dicUserInfo = [jsonDic objectForKey:@"userInfo"];
//    
//    NSLog(@"%@",[jsonDic objectForKey:@"userInfo" ]);
//    NSLog(@"%@",[dicUserInfo objectForKey:@"userName"]);
//    NSLog(@"%@",[dicUserInfo objectForKey:@"sex"]);

    NSLog(@"test 开始运行");
    NSString * customerGridJsonString = [[NSString alloc]initWithFormat:@"{\"customer\":[{\"name\":\"roamer\",\"ycount\":\"232.4\",\"sumcount\":\"322.3\"},{\"name\":\"王三\",\"ycount\":\"221.2\",\"sumcount\":\"1123.2\"},{\"name\":\"李四\",\"ycount\":\"1221.2\",\"sumcount\":\"12123.2\"}]}"];
    
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSLog(@"%@",customerGridJsonString);
    NSError * error = nil;
    
    NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithDictionary:[parser objectWithString:customerGridJsonString error:&error]];
    NSLog(@"root = %@",root);
    //注意转换代码
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    
    NSString *jsonString = [jsonWriter stringWithObject:root];
    
//    [jsonWriter release];    NSLog(@"%@",jsonString);
    //注意转换代码
    NSMutableArray * customers = [root objectForKey:@"customer"];
    NSLog(@"%@",customers);
    for(NSMutableDictionary * member  in customers)
    {
        NSLog(@"%@",[member objectForKey:@"name"]);
    }
}

@end
