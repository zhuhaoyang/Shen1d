//
//  CardBackView.h
//  shen1d
//
//  Created by Myth on 12-9-20.
//
//

#import <UIKit/UIKit.h>
#import "serviceGetDiscounts.h"

@interface CardBackView : UIView<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>{
    UITableView *m_tableView;
    NSArray *arrDiscounts;
    serviceGetDiscounts *m_serviceGetDiscounts;
}

- (id)initWithFrame:(CGRect)frame discounts:(NSArray *)discounts;

@end
