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


@interface FindViewController : UIViewController
<SearchViewDelegate,UITableViewDataSource,UITableViewDelegate,
MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation>
{
    MKMapView * mapView;
    CLLocationManager *m_CLLocationManager;
    Annotation *myAnnotation;

    UITableView *m_tableView;
    SearchView *m_searchView;
    UIView *blackView;
    
    NSMutableArray *arrBusinesses;
    
    CardViewController *m_CardViewController;
}
@end
