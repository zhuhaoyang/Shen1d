//
//  MapViewController.m
//  shen1d
//
//  Created by Myth on 12-9-20.
//
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil shopName:(NSString *)shopName bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = shopName;
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.88 green:0.42 blue:0 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 35, 30);
        [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *liftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:liftButton];

        m_CLLocationManager = [[CLLocationManager alloc]init];
        m_CLLocationManager.delegate = self;
        [m_CLLocationManager startUpdatingLocation];
        
        m_mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44)];
        m_mapView.delegate = self;
        m_mapView.mapType = MKMapTypeStandard;
        m_mapView.showsUserLocation = YES;
        
//        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(m_coordinate, 2000, 2000);
//        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
//        myAnnotation = [[Annotation alloc]initWithCoordinate:m_coordinate];
//        [myAnnotation setDelegate:self];
//        myAnnotation.title = m_shopName;
//        [mapView setRegion:adjustedRegion animated:YES];
//        [mapView addAnnotation:myAnnotation];
        
        [self.view addSubview:m_mapView];
        
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil coordinate:(CLLocationCoordinate2D)coordinate shopName:(NSString *)shopName bundle:(NSBundle *)nibBundleOrNil;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.title = shopName;
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = shopName;
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:1 green:0.5882 blue:0 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;
        m_shopName = shopName;
        m_coordinate = coordinate;
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 35, 30);
        [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *liftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:liftButton];

        
        m_CLLocationManager = [[CLLocationManager alloc]init];
        m_CLLocationManager.delegate = self;
//        [m_CLLocationManager startUpdatingLocation];

        m_mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44)];
        m_mapView.delegate = self;
        m_mapView.mapType = MKMapTypeStandard;
        m_mapView.showsUserLocation = NO;
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(m_coordinate, 2000, 2000);
        MKCoordinateRegion adjustedRegion = [m_mapView regionThatFits:viewRegion];
        myAnnotation = [[Annotation alloc]initWithCoordinate:m_coordinate];
        [myAnnotation setDelegate:self];
        myAnnotation.title = m_shopName;
        [m_mapView setRegion:adjustedRegion animated:YES];
        [m_mapView addAnnotation:myAnnotation];

        [self.view addSubview:m_mapView];

    }
    return self;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
    if (m_mapView.userLocationVisible == 1) {
        [m_CLLocationManager stopUpdatingLocation];
                
        
//        NSLog(@"userLocationVisible = %i",mapView.userLocationVisible);
        //        NSLog(@"%@",coords);
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(m_CLLocationManager.location.coordinate, 2000, 2000);
        MKCoordinateRegion adjustedRegion = [m_mapView regionThatFits:viewRegion];
        
        //        Annotation *annotation = [[Annotation alloc]initWithCoordinate:self.mapView.userLocation.location.coordinate];
        //        [self.mapView addAnnotation:annotation];
        //        CLLocationCoordinate2D test;
        //        test.latitude = 30.273699;
        //        test.longitude = 120.136753;
        //        Annotation *annotation = [[Annotation alloc]initWithCoordinate:test];
        //        [annotation setDelegate:self];
        //        [self.mapView addAnnotation:annotation];/Users/jy01902848/Desktop/starbucks_001.png
        
        
//        myAnnotation = [[Annotation alloc]initWithCoordinate:m_CLLocationManager.location.coordinate];
//        [myAnnotation setDelegate:self];
//        myAnnotation.title = @"当前位置";
        [m_mapView setRegion:adjustedRegion animated:YES];
//        [m_mapView addAnnotation:myAnnotation];
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

	}else
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
//        Annotation * m_annotation = annotation;
		[view   setImage:[UIImage  imageNamed:@"pin"] ];
        view.frame = CGRectMake(0, 0, 20, 40);
        //        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        
        //        UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"starbucks_03"]];
        //        leftImage.frame = CGRectMake(0, 0, 30, 30);
        
//        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [rightButton addTarget:self action:@selector(clickedBt:) forControlEvents:UIControlEventTouchUpInside];
//        rightButton.tag = [m_annotation.shopId integerValue];
//        view.centerOffset = CGPointMake(0, -17.5);
//        
//        //        view.leftCalloutAccessoryView = leftImage;
//        view.rightCalloutAccessoryView = rightButton;
		view.canShowCallout = YES;
//        view.isSelected = YES;
		return   view;
        
	}


}

@end
