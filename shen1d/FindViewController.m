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
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = @"发现";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.88 green:0.42 blue:0 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;
        m_CLLocationManager = [[CLLocationManager alloc]init];
        m_CLLocationManager.delegate = self;

//        UIButton *btBack = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btBack setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
//        btBack.frame = CGRectMake(0, 0, 40, 30);
//        UIBarButtonItem *backButtom = [[UIBarButtonItem alloc]initWithCustomView:btBack];
//        //        [self.navigationItem setBackBarButtonItem:backButtom];
//        self.navigationItem.backBarButtonItem = backButtom;
        
//        [self.navigationItem.backBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        arrBusinesses = [[NSMutableArray alloc]initWithCapacity:0];
//        NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"jtjl.png",@"image",@"锦亭酒楼",@"name",@"3",@"numberOfPrivilege",@"50",@"distance", nil];
//        [arrBusinesses addObject:dic1];
//        
//        NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"xbk.png",@"image",@"星巴克",@"name",@"2",@"numberOfPrivilege",@"75",@"distance", nil];
//        [arrBusinesses addObject:dic2];
//        
//        NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"ymamdl.png",@"image",@"雅米澳门豆捞",@"name",@"1",@"numberOfPrivilege",@"100",@"distance", nil];
//        [arrBusinesses addObject:dic3];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 220, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        
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
        
        
        btMap = [UIButton buttonWithType:UIButtonTypeCustom];
        btMap.frame = CGRectMake(0, 0, 30, 30);
        [btMap setBackgroundImage:[UIImage imageNamed:@"btn2"] forState:UIControlStateNormal];
        [btMap addTarget:self action:@selector(turnToMap:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:btMap];
        [self.navigationItem setRightBarButtonItem:rightButton];
        btMap.tag = 107;
        
        
                
        

    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [m_CLLocationManager startUpdatingLocation];
    [SVGeocoder reverseGeocode:m_CLLocationManager.location.coordinate
                    completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
                        if ([placemarks isKindOfClass:[NSArray class]] &&[placemarks count] > 0) {
                            NSLog(@"placemarks = %@", [[placemarks objectAtIndex:0]name]);
                            placemark = [placemarks objectAtIndex:0];
                            label.text = [NSString stringWithFormat:@"您在%@附近",placemark.name];
                        }
                    }];
    m_serviceGetShops = [[serviceGetShops alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
    [m_serviceGetShops sendRequestWithData:[NSString stringWithFormat:@"page=0&perpage=10&longitude=%f&latitude=%f&mode=distance",m_CLLocationManager.location.coordinate.longitude,m_CLLocationManager.location.coordinate.latitude] addr:@"get_shops?"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    m_mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
    m_mapView.delegate = self;
    m_mapView.mapType = MKMapTypeStandard;
    m_mapView.showsUserLocation = YES;
//    mapView.userLocationVisible = YES;
    [m_CLLocationManager startUpdatingLocation];
//    if (mapView.userLocationVisible == YES) {
        
        
        
        
        CLLocationCoordinate2D location = m_mapView.userLocation.location.coordinate;
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 2000, 2000);
        MKCoordinateRegion adjustedRegion = [m_mapView regionThatFits:viewRegion];
        [m_mapView setRegion:adjustedRegion animated:YES];
//    }

    // Do any additional setup after loading the view from its nib.
   
}


- (void)location
{
    [m_CLLocationManager startUpdatingLocation];
//    if (mapView.userLocationVisible == YES) {
        [SVGeocoder reverseGeocode:m_CLLocationManager.location.coordinate
                        completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
                            NSLog(@"placemarks = %@", [[placemarks objectAtIndex:0]name]);
                            placemark = [placemarks objectAtIndex:0];
                            label.text = [NSString stringWithFormat:@"您在%@附近",placemark.name];
                        }];
//        [m_CLLocationManager stopUpdatingLocation];
    
        
        
        CLLocationCoordinate2D location = m_mapView.userLocation.location.coordinate;
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 2000, 2000);
        MKCoordinateRegion adjustedRegion = [m_mapView regionThatFits:viewRegion];
        [m_mapView setRegion:adjustedRegion animated:YES];
//    }
    m_serviceGetShops = [[serviceGetShops alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
    [m_serviceGetShops sendRequestWithData:[NSString stringWithFormat:@"page=0&perpage=10&longitude=%f&latitude=%f&mode=distance",m_CLLocationManager.location.coordinate.longitude,m_CLLocationManager.location.coordinate.latitude] addr:@"get_shops?"];
}
- (void)turnToMap:(id)sender
{
    UIBarButtonItem *bt = sender;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.7];
    if (bt.tag == 107) {
//        [m_CLLocationManager startUpdatingLocation];
//        //    if (m_mapView.userLocationVisible == YES) {
//        [m_CLLocationManager stopUpdatingLocation];
        
        
        
        CLLocationCoordinate2D location = m_mapView.userLocation.location.coordinate;
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 2000, 2000);
        MKCoordinateRegion adjustedRegion = [m_mapView regionThatFits:viewRegion];
        [m_mapView setRegion:adjustedRegion animated:YES];

        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [m_tableView removeFromSuperview];
        //        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        [self.view addSubview:m_mapView];
//        [bt setTitle:@"地图模式"];
        bt.tag = 108;
        [btMap setBackgroundImage:[UIImage imageNamed:@"btn2_turn"] forState:UIControlStateNormal];
        
        CLLocationCoordinate2D coordinate;
                
        for (NSDictionary *shop in arrBusinesses) {
            coordinate.latitude = [[shop objectForKey:@"latitude"] floatValue];
            coordinate.longitude = [[shop objectForKey:@"longitude"] floatValue];

//            if (myAnnotation == nil) {
                myAnnotation = [[Annotation alloc]initWithCoordinate:coordinate];
                
//            }else {
//                myAnnotation.coordinate = coordinate;
//            }
            myAnnotation.title = [shop objectForKey:@"shopName"];
//            myAnnotation.subtitle = @"0571-80000000";
            myAnnotation.shopId = [shop objectForKey:@"shopId"];
            //    NSLog(@"%i",self.m_mapView.userLocation.location.coordinate);
            [myAnnotation setDelegate:self];
            [m_mapView addAnnotation:myAnnotation];

        }
        


        
        

        
        
        
        
    }else if(bt.tag == 108){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [m_mapView removeFromSuperview];
        //        frontView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        [self.view addSubview:m_tableView];
//        [bt setTitle:@"列表模式"];
        [btMap setBackgroundImage:[UIImage imageNamed:@"btn2"] forState:UIControlStateNormal];
        bt.tag = 107;
    }
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用某个方法
    //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    UIButton *headerView = [UIButton buttonWithType:UIButtonTypeCustom];
    headerView.frame = CGRectMake(0, 0, 320, 30);
//    [headerView setTitle:[NSString stringWithFormat:@"您在%@附近",placemark.name] forState:UIControlStateNormal];
    [headerView addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
    [headerView setBackgroundImage:[UIImage imageNamed:@"refreshbar"] forState:UIControlStateNormal];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (m_CardViewController == nil) {
//        m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" data:[arrBusinesses objectAtIndex:[indexPath row]] bundle:[NSBundle mainBundle]];
//    }
    m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" shopId:[[arrBusinesses objectAtIndex:[indexPath row]] objectForKey:@"shopId"] bundle:[NSBundle mainBundle]];
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
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[[arrBusinesses objectAtIndex:[indexPath row]] objectForKey:@"image"]]];
    image.frame = CGRectMake(5, 5, 50, 50);
    [cell addSubview:image];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 200, 40)];
    label1.text = [[arrBusinesses objectAtIndex:[indexPath row]] objectForKey:@"shopName"];
    [label1 setFont:[UIFont systemFontOfSize:23]];
    [cell addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, 200, 20)];
    label2.text = [NSString stringWithFormat:@"%@ 优惠",[[arrBusinesses objectAtIndex:[indexPath row]] objectForKey:@"discount_cnt"]];
    [label2 setFont:[UIFont systemFontOfSize:13]];
    [cell addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(200, 40, 120, 20)];
    NSInteger i = [[[arrBusinesses objectAtIndex:[indexPath row]] objectForKey:@"distance"] integerValue];
    if (i/100 <1) {
        i = i/10*10;
    }else{
        i = i/100*100;
    }
    label3.text = [NSString stringWithFormat:@"%d m",i];
    label3.textAlignment = NSTextAlignmentRight;
    [label3 setFont:[UIFont systemFontOfSize:13]];
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
//    m_serviceGoogleMap = [[serviceGoogleMap alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
////    [m_serviceGoogleMap sendRequestWithData:[NSString stringWithFormat:@"latlng=%f,%f&sensor=true&language=en",m_CLLocationManager.location.coordinate.latitude,m_CLLocationManager.location.coordinate.longitude] addr:@"json?"];
//    [m_serviceGoogleMap sendRequestWithData:@"sensor=true&latlng=37.785835%2C-122.406418&language=zh-CN" addr:@"json"];
}




#pragma mark -
#pragma mark CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //        [mapView addAnnotation:myAnnotation];
//    [SVGeocoder reverseGeocode:m_CLLocationManager.location.coordinate
//                    completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
//                        NSLog(@"placemarks = %@", [[placemarks objectAtIndex:0]name]);
//                        placemark = [placemarks objectAtIndex:0];
//                        label.text = [NSString stringWithFormat:@"您在%@附近",placemark.name];
//                    }];
    [m_CLLocationManager stopUpdatingLocation];

    
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
        view = (MKAnnotationView *)[m_mapView  dequeueReusableAnnotationViewWithIdentifier:annotation.title];
		
		
		if (view==nil)
		{
			view = [[MKAnnotationView  alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title];
		}
		else
		{
			view.annotation=annotation;
		}
		
		
		//设置图标
        Annotation * m_annotation = annotation;
		[view   setImage:[UIImage  imageNamed:@"pin"] ];
        view.frame = CGRectMake(0, 0, 20, 40);
        //        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        
//        UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"starbucks_03"]];
//        leftImage.frame = CGRectMake(0, 0, 30, 30);
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(clickedBt:) forControlEvents:UIControlEventTouchUpInside];
        rightButton.tag = [m_annotation.shopId integerValue];
        view.centerOffset = CGPointMake(0, -17.5);
        
//        view.leftCalloutAccessoryView = leftImage;
        view.rightCalloutAccessoryView = rightButton;
		view.canShowCallout = YES;
		return   view;
        
	}
}
- (void)clickedBt:(id)sender
{
    UIButton *bt = sender;
    NSLog(@"click!!!");
    m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" shopId:[NSString stringWithFormat:@"%d",bt.tag] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:m_CardViewController animated:YES];
    
}
#pragma mark -
#pragma mark serviceCallBack
- (void)serviceGetShopsCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
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
            arrBusinesses = [dicCallBack objectForKey:@"shops"];
            [m_tableView reloadData];
//            CLLocation *loc1 = [[CLLocation alloc]initWithLatitude:[[[arrBusinesses objectAtIndex:0] objectForKey:@"latitude"] floatValue] longitude:[[[arrBusinesses objectAtIndex:0] objectForKey:@"longitude"] floatValue]];
//            CLLocation *loc2 = [[CLLocation alloc]initWithLatitude:m_CLLocationManager.location.coordinate.latitude longitude:m_CLLocationManager.location.coordinate.longitude];
//            CLLocationDistance distance = [loc1 distanceFromLocation:loc2];
//            NSLog(@"%@,%f",[[arrBusinesses objectAtIndex:0] objectForKey:@"shopName"],distance);
        }
    }else{
       LOGS(@"失败");
    }
    
}



@end
