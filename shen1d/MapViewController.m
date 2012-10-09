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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_CLLocationManager = [[CLLocationManager alloc]init];
        m_CLLocationManager.delegate = self;
        [m_CLLocationManager startUpdatingLocation];

        mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
        mapView.delegate = self;
        mapView.mapType = MKMapTypeStandard;
        mapView.showsUserLocation = YES;
        [self.view addSubview:mapView];

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
        CLLocationCoordinate2D test;
        test.latitude = 30.273699;
        test.longitude = 120.136753;

//        NSLog(@"userLocationVisible = %i",mapView.userLocationVisible);
        //        NSLog(@"%@",coords);
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(test, 2000, 2000);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
        
        //        Annotation *annotation = [[Annotation alloc]initWithCoordinate:self.mapView.userLocation.location.coordinate];
        //        [self.mapView addAnnotation:annotation];
        //        CLLocationCoordinate2D test;
        //        test.latitude = 30.273699;
        //        test.longitude = 120.136753;
        //        Annotation *annotation = [[Annotation alloc]initWithCoordinate:test];
        //        [annotation setDelegate:self];
        //        [self.mapView addAnnotation:annotation];/Users/jy01902848/Desktop/starbucks_001.png
        
        
        myAnnotation = [[Annotation alloc]initWithCoordinate:test];
        [myAnnotation setDelegate:self];
        myAnnotation.title = @"锦亭酒楼";
        [mapView setRegion:adjustedRegion animated:YES];
        [mapView addAnnotation:myAnnotation];
    }
}


@end
