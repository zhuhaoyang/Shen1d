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
        self.navigationItem.title = @"商家";
        
        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        m_tableView.delegate = self;
        [self.view addSubview:m_tableView];
        
        m_searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, -38, 320, 38)];
        m_searchView.delegate = self;
        [self.view addSubview:m_searchView];
        
        blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        blackView.backgroundColor = [UIColor blackColor];

        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"搜索"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(showSearchView:)];
//                                                         BarButtonSystemItem:UIBarButtonSystemItemSearch
//                                                                                    target:self
//                                                                                    action:@selector(showSearchView:)];
        rightButton.tag = 0;
        [self.navigationItem setRightBarButtonItem:rightButton];
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"筛选"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(showActionSheet:forEvent:)];
        [self.navigationItem setLeftBarButtonItem:leftButton];
    }
    return self;
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


-(void) showActionSheet:(id)sender forEvent:(UIEvent*)event
{
    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:@"action sheet"];
    [actionSheet destructiveButtonWithTitle:@"hoge" block:nil];
    [actionSheet addButtonWithTitle:@"hoge1" block:^{
        NSLog(@"pushed hoge1 button");
    }];
    [actionSheet addButtonWithTitle:@"moge2" block:^{
        NSLog(@"pushed hoge2 button");
    }];
    [actionSheet cancelButtonWithTitle:@"Cancel" block:nil];
    actionSheet.cornerRadius = 5;
    //    NSLog(@"%@",actionSheet.)
    [actionSheet showWithTouch:event];
}


- (void)showSearchView:(id)sender
{
//    UIBarButtonItem *bt = sender;
//    if (bt.tag == 0) {
//        [MKEntryPanel showPanelWithTitle:NSLocalizedString(@"Enter a text name", @"")
//                                  inView:self.view
//                           onTextEntered:^(NSString* enteredString)
//         {
//             NSLog(@"Entered: %@", enteredString);
//         }];
////        bt.tag = 1;
//    }else if (bt.tag == 1){
////        [[MKEntryPanel panel]hide];
//        bt.tag = 0;
//    }
    
    
    if ([m_searchView.searchTextField.text isEqualToString:NSLocalizedString(@"Current Location", nil)]) {
        m_searchView.searchTextField.textColor = [UIColor blueColor];
    } else {
        m_searchView.searchTextField.textColor = [UIColor blackColor];
    }
    UIBarButtonItem *bt = sender;
    if (bt.tag == 0) {
        bt.title = @"取消";
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
        self.navigationItem.rightBarButtonItem.tag = 1;
        
    }else if(bt.tag == 1){
        [self hideSearchBar:self];
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

#pragma mark -
#pragma mark NiftySearchView Delegate Methods


- (void)niftySearchViewResigend
{
    NSLog(@"resignSearchView");
    [self hideSearchBar:self];
}

- (void)routeButtonClicked:(UITextField *)searchTextField
{
    NSLog(@"routeButtonClicked = %@",searchTextField.text);
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

@end
