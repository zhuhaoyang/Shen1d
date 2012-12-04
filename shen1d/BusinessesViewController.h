//
//  BusinessesViewController.h
//  shen1d
//
//  Created by Myth on 12-9-11.
//
//

#import <UIKit/UIKit.h>
#import "SearchView.h"
//#import "MKEntryPanel.h"
#import "TSPopoverController.h"
#import "TSActionSheet.h"
#import "serviceGetShops.h"
#import <MapKit/MapKit.h>
#import "CardViewController.h"
#import "serviceGetShop.h"
@interface BusinessesViewController : UIViewController
<SearchViewDelegate,UITableViewDataSource,
UITableViewDelegate,CLLocationManagerDelegate>{
    UITableView *m_tableView;
    SearchView *m_searchView;
    UIView *blackView;
    serviceGetShops *m_serviceGetShops;
    CLLocationManager *m_CLLocationManager;
    NSMutableArray *arrShops;
    CardViewController *m_CardViewController;
    serviceGetShop *m_serviceGetShop;
    UIButton *btSearch;
}

- (void)send:(NSString *)mode;

@end
