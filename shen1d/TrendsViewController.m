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
        NSArray *arrItems = [[NSArray alloc]initWithObjects:@"动态",@"个人中心", nil];
        segment = [[UISegmentedControl alloc]initWithItems:arrItems];
        [segment addTarget:self action:@selector(changeSegmented) forControlEvents:UIControlEventValueChanged];
        segment.segmentedControlStyle = UISegmentedControlStyleBar;
        segment.selectedSegmentIndex = 0;
        self.navigationItem.titleView = segment;
        
        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49) style:UITableViewStylePlain];
        m_tableView.dataSource = self;
        m_tableView.delegate = self;
        [self.view addSubview:m_tableView];
        
        m_PersonalCenterView = [[PersonalCenterView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
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
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [m_tableView removeFromSuperview];
        [self.view addSubview:m_PersonalCenterView];
        
    }else if(segment.selectedSegmentIndex == 0){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [m_PersonalCenterView removeFromSuperview];
        [self.view addSubview:m_tableView];
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
    if (m_CardViewController == nil) {
        m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" data:nil bundle:[NSBundle mainBundle]];
    }    [self.navigationController pushViewController:m_CardViewController animated:YES];
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
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


@end
