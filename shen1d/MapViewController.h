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
    MKMapView * mapView;
    CLLocationManager *m_CLLocationManager;
    Annotation *myAnnotation;
}
@end
