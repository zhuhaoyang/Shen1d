//
//  PersonalCenterView.h
//  shen1d
//
//  Created by Myth on 12-9-27.
//
//

#import <UIKit/UIKit.h>
#import "serviceGetRecords.h"
#import "Global.h"
#import "PublicDefine.h"

@interface PersonalCenterView : UIView
<UITableViewDataSource,UITableViewDelegate>{
    UITableView *m_tableView;
    NSMutableArray *arrMyRecords;
    serviceGetRecords *m_serviceGetRecords;
}

@end
