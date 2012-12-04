//
//  TrendsViewController.h
//  shen1d
//
//  Created by Myth on 12-9-27.
//
//

#import <UIKit/UIKit.h>
#import "CardViewController.h"
#import "PersonalCenterView.h"
#import "DatabaseManager.h"
#import "PublicDefine.h"
#import "Global.h"
#import "serviceGetDiscounts.h"
#import "serviceGetShop.h"
#import "SettingViewController.h"
@interface TrendsViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    UITableView *m_tableView;
    UISegmentedControl *segment;
    CardViewController *m_CardViewController;
    PersonalCenterView *m_PersonalCenterView;
    DatabaseManager *dbManager;
    serviceGetDiscounts *m_serviceGetDiscounts;
    NSMutableArray *arrDiscounts;
    serviceGetShop *m_serviceGetShop;
}

- (void)getDiscounts;

@end
