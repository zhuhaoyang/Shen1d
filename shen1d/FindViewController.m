//
//  FindViewController.m
//  shen1d
//
//  Created by Myth on 12-9-11.
//
//

#import "FindViewController.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"发现";
        
        arrBusinesses = [[NSMutableArray alloc]initWithCapacity:0];
        NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"jtjl.png",@"image",@"锦亭酒楼",@"name",@"3",@"numberOfPrivilege",@"50",@"distance", nil];
        [arrBusinesses addObject:dic1];
        
        NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"xbk.png",@"image",@"星巴克",@"name",@"2",@"numberOfPrivilege",@"75",@"distance", nil];
        [arrBusinesses addObject:dic2];
        
        NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"ymamdl.png",@"image",@"雅米澳门豆捞",@"name",@"1",@"numberOfPrivilege",@"100",@"distance", nil];
        [arrBusinesses addObject:dic3];
        
        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
        [self.view addSubview:m_tableView];
        [m_tableView reloadData];
        
        m_searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, -38, 320, 38)];
        m_searchView.delegate = self;
        [self.view addSubview:m_searchView];
        
        blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        blackView.backgroundColor = [UIColor blackColor];
        
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"列表模式"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(turnToMap:)];
        //                                                         BarButtonSystemItem:UIBarButtonSystemItemSearch
        //                                                                                    target:self
        //                                                                                    action:@selector(showSearchView:)];
        rightButton.tag = 107;
        [self.navigationItem setRightBarButtonItem:rightButton];
        
        
        m_CLLocationManager = [[CLLocationManager alloc]init];
        m_CLLocationManager.delegate = self;
        [m_CLLocationManager startUpdatingLocation];
        
        mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        mapView.delegate = self;
        mapView.mapType = MKMapTypeStandard;
        mapView.showsUserLocation = YES;

    }
    return self;
}

- (void)turnToMap:(id)sender
{
    UIBarButtonItem *bt = sender;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.7];
    if (bt.tag == 107) {
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [m_tableView removeFromSuperview];
        //        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        [self.view addSubview:mapView];
        [bt setTitle:@"地图模式"];
        bt.tag = 108;
        
        CLLocationCoordinate2D test;
        test.latitude = 30.273699;
        test.longitude = 120.136753;
        if (myAnnotation == nil) {
            myAnnotation = [[Annotation alloc]initWithCoordinate:test];
            
        }else {
            myAnnotation.coordinate = test;
        }


        
        myAnnotation.title = @"星巴克(教工路店)";
        myAnnotation.subtitle = @"0571-80000000";
        
        //    NSLog(@"%i",self.mapView.userLocation.location.coordinate);
        [myAnnotation setDelegate:self];
        [mapView addAnnotation:myAnnotation];


        
        
        
        
    }else if(bt.tag == 108){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [mapView removeFromSuperview];
        //        frontView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        [self.view addSubview:m_tableView];
        [bt setTitle:@"列表模式"];
        bt.tag = 107;
    }
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用某个方法
    //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];
}


//- (void)showSearchView:(id)sender
//{
//    //    UIBarButtonItem *bt = sender;
//    //    if (bt.tag == 0) {
//    //        [MKEntryPanel showPanelWithTitle:NSLocalizedString(@"Enter a text name", @"")
//    //                                  inView:self.view
//    //                           onTextEntered:^(NSString* enteredString)
//    //         {
//    //             NSLog(@"Entered: %@", enteredString);
//    //         }];
//    ////        bt.tag = 1;
//    //    }else if (bt.tag == 1){
//    ////        [[MKEntryPanel panel]hide];
//    //        bt.tag = 0;
//    //    }
//    
//    
//    if ([m_searchView.searchTextField.text isEqualToString:NSLocalizedString(@"Current Location", nil)]) {
//        m_searchView.searchTextField.textColor = [UIColor blueColor];
//    } else {
//        m_searchView.searchTextField.textColor = [UIColor blackColor];
//    }
//    UIBarButtonItem *bt = sender;
//    if (bt.tag == 0) {
//        bt.title = @"取消";
//        CGRect searchBarFrame = m_searchView.frame;
//        searchBarFrame.origin.y = 0;
//        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
//                         animations:^{
//                             m_searchView.frame = searchBarFrame;
//                         }
//                         completion:^(BOOL completion) {
//                             [m_searchView.searchTextField becomeFirstResponder];
//                         }];
//        CATransition *transition = [CATransition animation];
//        transition.duration = 0.35;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCATransitionFade;
//        blackView.frame = CGRectMake(0, 0, 320, 480);
//        [blackView.layer addAnimation:transition forKey:nil];
//        blackView.alpha = 0.8;
//        [self.view addSubview:blackView];
//        [self.view bringSubviewToFront:m_searchView];
//        self.navigationItem.rightBarButtonItem.tag = 1;
//        
//    }else if(bt.tag == 1){
//        [self hideSearchBar:self];
//    }
//    
//    
//}


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


#pragma mark -
#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (m_CardViewController == nil) {
        m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" data:[arrBusinesses objectAtIndex:[indexPath row]] bundle:[NSBundle mainBundle]];
    }
    m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" data:[arrBusinesses objectAtIndex:[indexPath row]] bundle:[NSBundle mainBundle]];
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
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[[arrBusinesses objectAtIndex:[indexPath row]] objectForKey:@"image"]]];
    image.frame = CGRectMake(5, 5, 50, 50);
    [cell addSubview:image];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 200, 40)];
    label1.text = [[arrBusinesses objectAtIndex:[indexPath row]] objectForKey:@"name"];
    [label1 setFont:[UIFont systemFontOfSize:23]];
    [cell addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, 200, 20)];
    label2.text = [NSString stringWithFormat:@"%@ 优惠",[[arrBusinesses objectAtIndex:[indexPath row]] objectForKey:@"numberOfPrivilege"]];
    [label2 setFont:[UIFont systemFontOfSize:13]];
    [cell addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(250, 20, 60, 30)];
    label3.text = [NSString stringWithFormat:@"%@ m",[[arrBusinesses objectAtIndex:[indexPath row]] objectForKey:@"distance"]];
    label3.textAlignment = UITextAlignmentRight;
    [label3 setFont:[UIFont systemFontOfSize:18]];
    [cell addSubview:label3];

    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrBusinesses count];
}


#pragma mark -
#pragma mark MapKit Delegate Methods


- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"警告"
                                                  message:@"地图加载失败!"
                                                 delegate:self
                                        cancelButtonTitle:@"确认"
                                        otherButtonTitles:nil];
    [aler show];
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    
}




#pragma mark -
#pragma mark CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (mapView.userLocationVisible == 1) {
        [m_CLLocationManager stopUpdatingLocation];
        CLLocationCoordinate2D location = mapView.userLocation.location.coordinate;
//        NSLog(@"userLocationVisible = %i",mapView.userLocationVisible);
//        CLLocationCoordinate2D test;
//        test.latitude = 40.273699;
//        test.longitude = 130.136753;
        
        //        NSLog(@"userLocationVisible = %i",mapView.userLocationVisible);
        //        NSLog(@"%@",coords);
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 2000, 2000);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
        
        //        Annotation *annotation = [[Annotation alloc]initWithCoordinate:self.mapView.userLocation.location.coordinate];
        //        [self.mapView addAnnotation:annotation];
        //        CLLocationCoordinate2D test;
        //        test.latitude = 30.273699;
        //        test.longitude = 120.136753;
        //        Annotation *annotation = [[Annotation alloc]initWithCoordinate:test];
        //        [annotation setDelegate:self];
        //        [self.mapView addAnnotation:annotation];/Users/jy01902848/Desktop/starbucks_001.png
        
        
//        myAnnotation = [[Annotation alloc]initWithCoordinate:location];
//        [myAnnotation setDelegate:self];
//        myAnnotation.title = @"锦亭酒楼";
        [mapView setRegion:adjustedRegion animated:YES];
//        [mapView addAnnotation:myAnnotation];
    }
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation
{
	//判断是否是自己

    if (![annotation isKindOfClass:[Annotation class]])
	{
        Annotation * m_annotation = annotation;
        m_annotation.title=@"当前位置";
        return  nil;
        
	}
	else
	{
        MKAnnotationView *view;
        view = (MKAnnotationView *)[mapView  dequeueReusableAnnotationViewWithIdentifier:annotation.title];
		
		
		if (view==nil)
		{
			view = [[MKAnnotationView  alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title];
		}
		else
		{
			view.annotation=annotation;
		}
		
		
//		//设置图标
//        //		Annotation * m_annotation = annotation;
//		[view   setImage:[UIImage  imageNamed:@"starbucks_001"] ];
//        view.frame = CGRectMake(0, 0, 30, 45);
//        //        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//        
//        UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"starbucks_03"]];
//        leftImage.frame = CGRectMake(0, 0, 30, 30);
//        
//        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [rightButton addTarget:self action:@selector(clickedBt:) forControlEvents:UIControlEventTouchUpInside];
//        
//        view.centerOffset = CGPointMake(0, -17.5);
//        
//        view.leftCalloutAccessoryView = leftImage;
//        view.rightCalloutAccessoryView = rightButton;
//		view.canShowCallout = YES;
		return   nil;
        
	}
}

@end
