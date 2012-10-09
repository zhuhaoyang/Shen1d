//
//  SearchView.h
//  shen1d
//
//  Created by Myth on 12-9-14.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PublicDefine.h"
@protocol SearchViewDelegate;

@interface SearchView : UIView{
    UITextField *searchTextField;
}

@property (nonatomic, assign) id <SearchViewDelegate> delegate;
@property (nonatomic, strong) UITextField *searchTextField;

@end

@protocol SearchViewDelegate <NSObject>
- (void)routeButtonClicked:(UITextField *)searchTextField;
- (void)niftySearchViewResigend;
@end