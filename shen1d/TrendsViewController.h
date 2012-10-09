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
@interface TrendsViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    UITableView *m_tableView;
    UISegmentedControl *segment;
    CardViewController *m_CardViewController;
    PersonalCenterView *m_PersonalCenterView;
}

@end
