//
//  CarkPacksViewController.h
//  shen1d
//
//  Created by Myth on 12-9-11.
//
//

#import <UIKit/UIKit.h>
@interface CarkPacksViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    UITableView *m_tableView;
    NSMutableArray *arrCard;
}



@end
