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

@interface BusinessesViewController : UIViewController
<SearchViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView *m_tableView;
    SearchView *m_searchView;
    UIView *blackView;
}



@end
