//
//  SettingViewController.h
//  shen1d
//
//  Created by Myth on 12-11-19.
//
//

#import <UIKit/UIKit.h>
#import "DatabaseManager.h"
#import "Global.h"
#import "PublicDefine.h"
#import "GradientButton.h"
@interface SettingViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    UITableView *m_tableView;
    GradientButton *m_GradientButton;
}

@end
