//
//  CouponViewController.h
//  shen1d
//
//  Created by Myth on 12-8-13.
//
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"

@interface CouponViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    UITableView *m_tableView;
}

@end
