//
//  CardBackView.h
//  shen1d
//
//  Created by Myth on 12-9-20.
//
//

#import <UIKit/UIKit.h>

@interface CardBackView : UIView<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>{
    UITableView *m_tableView;
    NSArray *arrPrivilege;
}

@end
