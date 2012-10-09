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
        self.navigationItem.title = @"首页";
        arrImage = [[NSMutableArray alloc]initWithObjects:@"1933_1.jpg",@"1933_2.jpg",@"1933_3.jpg",@"1933_4.jpg",@"1933_5.jpg", nil];
        m_PagePhotosView = [[PagePhotosView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49) withDataSource:self delegate:self];
        [self.view addSubview:m_PagePhotosView];
    }
    return self;
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
    LOGS(@"clicked!");
}

#pragma mark -
#pragma mark PagePhotosDataSource

- (UIImage *)imageAtIndex:(int)index {
	return [UIImage imageNamed:[arrImage objectAtIndex:(NSUInteger)index]];
}

- (int)numberOfPages {
	return 5;
}

@end
