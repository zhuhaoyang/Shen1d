//
//  FindViewController.h
//  shen1d
//
//  Created by Myth on 12-9-11.
//
//

#import <UIKit/UIKit.h>
#import "SearchView.h"
#import "CardViewController.h"
#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "serviceGoogleMap.h"
#import "SVGeocoder.h"
#import "serviceGetShops.h"
#import "serviceGetShop.h"
@interface FindViewController : UIViewController
<SearchViewDelegate,UITableViewDataSource,UITableViewDelegate,
MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation>
{
    MKMapView * m_mapView;
    CLLocationManager *m_CLLocationManager;
    Annotation *myAnnotation;

    UITableView *m_tableView;
    SearchView *m_searchView;
    UIView *blackView;
    
    NSMutableArray *arrBusinesses;
    
    CardViewController *m_CardViewController;
    SVPlacemark *placemark;
    UIButton *btMap;
    
    serviceGetShops *m_serviceGetShops;
    serviceGetShop *m_serviceGetShop;
    
    UILabel *label;
}
@end
