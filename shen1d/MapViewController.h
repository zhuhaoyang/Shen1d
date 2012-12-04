//
//  MapViewController.h
//  shen1d
//
//  Created by Myth on 12-9-20.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface MapViewController : UIViewController
<MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation>
{
    MKMapView * m_mapView;
    CLLocationManager *m_CLLocationManager;
    Annotation *myAnnotation;
    CLLocationCoordinate2D m_coordinate;
    NSString *m_shopName;
}
- (id)initWithNibName:(NSString *)nibNameOrNil coordinate:(CLLocationCoordinate2D)coordinate shopName:(NSString *)shopName bundle:(NSBundle *)nibBundleOrNil;

- (id)initWithNibName:(NSString *)nibNameOrNil shopName:(NSString *)shopName bundle:(NSBundle *)nibBundleOrNil;

@end
