//
//  PagePhotosView.h
//  PagePhotosDemo
//
//  Created by junmin liu on 10-8-23.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagePhotosDataSource.h"
#import "PublicDefine.h"

@protocol HomeDelegate;


@interface PagePhotosView : UIView
<UIScrollViewDelegate> {
	UIScrollView *scrollView;
	UIPageControl *pageControl;
	
//	id<PagePhotosDataSource> dataSource;
	NSMutableArray *imageViews;
	
	// To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
//    UIButton *bt;
//    id <ActivityDelegate>__weak delegate;

}

@property (nonatomic, weak) id<PagePhotosDataSource> dataSource;
@property (nonatomic, strong) NSMutableArray *imageViews;
//@property (nonatomic, strong) UIButton *bt;
@property (nonatomic, weak) id <HomeDelegate> delegate;

- (IBAction)changePage:(id)sender;

- (id)initWithFrame:(CGRect)frame withDataSource:(id<PagePhotosDataSource>)m_dataSource delegate:(id<HomeDelegate>)m_delegate;

@end

@protocol HomeDelegate<NSObject>
-(void) clickedImage:(UIButton*)bt;
@end