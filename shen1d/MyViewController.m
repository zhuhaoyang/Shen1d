//
//  MyViewController.m
//  shen1d
//
//  Created by Myth on 12-8-13.
//
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.frame = CGRectMake(0, 0, 320, 460-44-49);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrImg = [[NSMutableArray alloc]initWithCapacity:0];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
    
    img1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [img1 setBackgroundImage:[UIImage imageNamed:@"01.jpg"] forState:UIControlStateNormal];
    [img1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    img1.frame = CGRectMake(0, 0, 320, 430);
    
    img1.layer.shadowColor = [UIColor blackColor].CGColor;
    img1.layer.shadowOffset = CGSizeMake(0, 0);
    img1.layer.shadowOpacity = 1;
    img1.layer.shadowRadius = 20.0;

    
    UIButton *map = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [map addTarget:self action:@selector(map) forControlEvents:UIControlEventTouchUpInside];
    map.frame = CGRectMake(30, 30, 70, 40);
    [map setTitle:@"map" forState:UIControlStateNormal];
    [img1 addSubview:map];
    
    [scrollView addSubview:img1];
    [scrollView bringSubviewToFront:img1];
    [arrImg addObject:img1];
    
    img2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [img2 setBackgroundImage:[UIImage imageNamed:@"02.jpg"] forState:UIControlStateNormal];
    [img2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    img2.frame = CGRectMake(0, 100, 320, 430);
    
    img2.layer.shadowColor = [UIColor blackColor].CGColor;
    img2.layer.shadowOffset = CGSizeMake(0, 0);
    img2.layer.shadowOpacity = 1;
    img2.layer.shadowRadius = 20.0;
    
    [scrollView addSubview:img2];
    [scrollView bringSubviewToFront:img2];
    [arrImg addObject:img2];
    
    img3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [img3 setBackgroundImage:[UIImage imageNamed:@"03.jpg"] forState:UIControlStateNormal];
    [img3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    img3.frame = CGRectMake(0, 200, 320, 430);
    
    img3.layer.shadowColor = [UIColor blackColor].CGColor;
    img3.layer.shadowOffset = CGSizeMake(0, 0);
    img3.layer.shadowOpacity = 1;
    img3.layer.shadowRadius = 20.0;
    
    [scrollView addSubview:img3];
    [scrollView bringSubviewToFront:img3];
    [arrImg addObject:img3];
    
    img4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [img4 setBackgroundImage:[UIImage imageNamed:@"04.jpg"] forState:UIControlStateNormal];
    [img4 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    img4.frame = CGRectMake(0, 300, 320, 430);
    
    img4.layer.shadowColor = [UIColor blackColor].CGColor;
    img4.layer.shadowOffset = CGSizeMake(0, 0);
    img4.layer.shadowOpacity = 1;
    img4.layer.shadowRadius = 20.0;
    
    [scrollView addSubview:img4];
    [scrollView bringSubviewToFront:img4];
    [arrImg addObject:img4];
    
    img5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [img5 setBackgroundImage:[UIImage imageNamed:@"05.jpg"] forState:UIControlStateNormal];
    [img5 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    img5.frame = CGRectMake(0, 400, 320, 430);
    
    img5.layer.shadowColor = [UIColor blackColor].CGColor;
    img5.layer.shadowOffset = CGSizeMake(0, 0);
    img5.layer.shadowOpacity = 1;
    img5.layer.shadowRadius = 20.0;
    
    [scrollView addSubview:img5];
    [scrollView bringSubviewToFront:img5];
    [arrImg addObject:img5];
    
    img6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [img6 setBackgroundImage:[UIImage imageNamed:@"02.jpg"] forState:UIControlStateNormal];
    [img6 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    img6.frame = CGRectMake(0, 500, 320, 430);
    
    img6.layer.shadowColor = [UIColor blackColor].CGColor;
    img6.layer.shadowOffset = CGSizeMake(0, 0);
    img6.layer.shadowOpacity = 1;
    img6.layer.shadowRadius = 20.0;
    
    [scrollView addSubview:img6];
    [scrollView bringSubviewToFront:img6];
    [arrImg addObject:img6];
    
    img7 = [UIButton buttonWithType:UIButtonTypeCustom];
    [img7 setBackgroundImage:[UIImage imageNamed:@"03.jpg"] forState:UIControlStateNormal];
    [img7 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    img7.frame = CGRectMake(0, 600, 320, 430);
    
    img7.layer.shadowColor = [UIColor blackColor].CGColor;
    img7.layer.shadowOffset = CGSizeMake(0, 0);
    img7.layer.shadowOpacity = 1;
    img7.layer.shadowRadius = 20.0;
    
    [scrollView addSubview:img7];
    [scrollView bringSubviewToFront:img7];
    [arrImg addObject:img7];
    
    img8 = [UIButton buttonWithType:UIButtonTypeCustom];
    [img8 setBackgroundImage:[UIImage imageNamed:@"04.jpg"] forState:UIControlStateNormal];
    [img8 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    img8.frame = CGRectMake(0, 700, 320, 430);
    
    img8.layer.shadowColor = [UIColor blackColor].CGColor;
    img8.layer.shadowOffset = CGSizeMake(0, 0);
    img8.layer.shadowOpacity = 1;
    img8.layer.shadowRadius = 20.0;
    
    [scrollView addSubview:img8];
    [scrollView bringSubviewToFront:img8];
    [arrImg addObject:img8];
    
    img9 = [UIButton buttonWithType:UIButtonTypeCustom];
    [img9 setBackgroundImage:[UIImage imageNamed:@"05.jpg"] forState:UIControlStateNormal];
    [img9 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    img9.frame = CGRectMake(0, 800, 320, 430);
    
    img9.layer.shadowColor = [UIColor blackColor].CGColor;
    img9.layer.shadowOffset = CGSizeMake(0, 0);
    img9.layer.shadowOpacity = 1;
    img9.layer.shadowRadius = 20.0;
    
    [scrollView addSubview:img9];
    [scrollView bringSubviewToFront:img9];
    [arrImg addObject:img9];
    
    scrollView.scrollEnabled = YES;
    //    [scrollView scrollRectToVisible:CGRectMake(0, 0, 320, 300) animated:YES];
    scrollView.contentSize = CGSizeMake(320, ([arrImg count] - 1)*100 +460);
    [self.view addSubview:scrollView];

}

- (void)map
{
    LOGS(@"map!");
}

- (void)click:(id)sender
{
    LOGS(@"%@",sender);
    UIButton *bt = sender;
    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:arrImg];
    [arr removeObject:bt];
    CGFloat x = [arrImg indexOfObject:bt]*100;
    if (x+100 == (CGFloat)[arrImg count]*100) {
        [scrollView setContentOffset:CGPointMake(0, x) animated:YES];
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelay:0];
    
    if (bt.tag == 0) {
        bt.tag = 1;
        CGFloat i = x + 440;
        bt.frame = CGRectMake(0, x, 320, 430);
        LOGS(@"%@",bt);
        [scrollView setContentOffset:CGPointMake(0, x) animated:YES];
        scrollView.frame = CGRectMake(0, scrollView.frame.origin.y-44, 320, 460);
        self.view.frame = CGRectMake(0, 0, 320, 460);
        LOGS(@"scroll = %@",scrollView);
        for (UIButton *btImage in arr) {
            btImage.frame = CGRectMake(0, i, 320, 430);
            btImage.userInteractionEnabled = NO;
            i = i + 5;
        }
        scrollView.scrollEnabled = NO;
//        self.view.frame = CGRectMake(0, 0, 320, 460);
        for(UIView *view in self.tabBarController.view.subviews)
        {
            if([view isKindOfClass:[UITabBar class]])
            {
                [view setFrame:CGRectMake(0, 460, 320, 49)];
//                [self.view sendSubviewToBack:view];

            }
            else
            {
                view.frame = CGRectMake(0, 0, 320, 460);
//                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-44, view.frame.size.width, view.frame.size.height)];
            }
        }
        
        for(UIView *view in self.navigationController.view.subviews)
        {
            if([view isKindOfClass:[UINavigationBar class]])
            {
                [view setFrame:CGRectMake(0, 0-44, 320, 44)];
            }
            else
            {
//                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 460)];
            }
        }

    }else{
        bt.tag = 0;
        CGFloat i = 0;
        scrollView.frame = CGRectMake(0, scrollView.frame.origin.y+44, 320, 460-44-49);

        for (UIButton *btImage in arrImg) {
            btImage.frame = CGRectMake(0, i, 320, 430);
            btImage.userInteractionEnabled = YES;
            [scrollView bringSubviewToFront:btImage];
            i = i + 100;
        }
        scrollView.scrollEnabled = YES;
//        [self.navigationController setNavigationBarHidden:NO];
        for(UIView *view in self.tabBarController.view.subviews)
        {
            if([view isKindOfClass:[UITabBar class]])
            {
                [view setFrame:CGRectMake(0, 460-49, 320, 49)];
            }
            else
            {
//                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+44, view.frame.size.width, 430)];
            }
        }
        
        for(UIView *view in self.navigationController.view.subviews)
        {
            if([view isKindOfClass:[UINavigationBar class]])
            {
                [view setFrame:CGRectMake(0, 0, 320, 44)];
            }
            else
            {
//                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 460-49)];
            }
        }

        [scrollView setContentOffset:CGPointMake(0, x) animated:YES];
    }
    
    [UIView commitAnimations];
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

@end
