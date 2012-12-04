//
//  CarkPacksViewController.h
//  shen1d
//
//  Created by Myth on 12-9-11.
//
//

#import <UIKit/UIKit.h>
#import "serviceGetMyShops.h"
#import "serviceDelMyShop.h"
#import "Global.h"
#import "DatabaseManager.h"
#import "serviceGetShop.h"
#import "CardViewController.h"
@interface CarkPacksViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    UITableView *m_tableView;
    NSMutableArray *arrMyShops;
    serviceGetMyShops *m_serviceGetMyShops;
    serviceDelMyShop *m_serviceDelMyShop;
    UIButton *btEdit;
    serviceGetShop *m_serviceGetShop;
    CardViewController *m_CardViewController;
}



@end
