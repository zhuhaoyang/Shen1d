//
//  PagePhotosView.m
//  PagePhotosDemo
//
//  Created by junmin liu on 10-8-23.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "PagePhotosView.h"
#import "HomeViewController.h"

@interface PagePhotosView (PrivateMethods)

- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end

@implementation PagePhotosView
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
//@synthesize bt = _bt;
@synthesize imageViews;

- (void)switchFocusImageItems
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    CGFloat targetX = scrollView.contentOffset.x + scrollView.frame.size.width;
    [self moveToTargetPosition:targetX];
      
    
//    LOGS(@"%d",pageControl.currentPage);

    
//    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:5];
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
//    LOGS(@"moveToTargetPosition : %f" , targetX);
    if (targetX >= scrollView.contentSize.width) {
        targetX = 0.0;
    }
    
    [scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES] ;
    pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
}

- (id)initWithFrame:(CGRect)frame withDataSource:(id<PagePhotosDataSource>)m_dataSource delegate:(id<HomeDelegate>)m_delegate
{
    if ((self = [super initWithFrame:frame])) {
        self.delegate = m_delegate;
		self.dataSource = m_dataSource;
        // Initialization UIScrollView
		int pageControlHeight = 20;
		scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-6)];
		pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-pageControlHeight-6, frame.size.width, pageControlHeight)];
//		pageControl.alpha = 0;
//        pageControl.backgroundColor = [UIColor redColor];
		[self addSubview:scrollView];
		[self addSubview:pageControl];
		
		int kNumberOfPages = [m_dataSource numberOfPages];
		
		// in the meantime, load the array with placeholders which will be replaced on demand
		NSMutableArray *views = [[NSMutableArray alloc] init];
		for (unsigned i = 0; i < kNumberOfPages; i++) {
			[views addObject:[NSNull null]];
		}
		self.imageViews = views;
		
		// a page is the width of the scroll view
		scrollView.pagingEnabled = YES;
		scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
		scrollView.showsHorizontalScrollIndicator = NO;
		scrollView.showsVerticalScrollIndicator = NO;
		scrollView.scrollsToTop = NO;
		scrollView.delegate = self;
		
		pageControl.numberOfPages = kNumberOfPages;
		pageControl.currentPage = 0;
//		pageControl.backgroundColor = [UIColor blackColor];
//        pageControl.alpha = 1;
//        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
		
		// pages are created on demand
		// load the visible page
		// load the page on either side to avoid flashes when the user starts scrolling
		[self loadScrollViewWithPage:0];
		[self loadScrollViewWithPage:1];
//        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:5];

		
    }
    return self;
}


- (void)loadScrollViewWithPage:(int)page {
	int kNumberOfPages = [self.dataSource numberOfPages];
	
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
	
    // replace the placeholder if necessary
//    UIImageView *view = [imageViews objectAtIndex:page];
    UIButton *view = [imageViews objectAtIndex:page];

    if ((NSNull *)view == [NSNull null]) {
		UIImage *image = [self.dataSource imageAtIndex:page];
//        view = [[UIImageView alloc] initWithImage:image];
        view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setBackgroundImage:image forState:UIControlStateNormal];
        [view addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        view.tag = page;
        view.adjustsImageWhenHighlighted = NO;
        [imageViews replaceObjectAtIndex:page withObject:view];
    }
	
    // add the controller's view to the scroll view
    if (nil == view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        view.frame = frame;
        [scrollView addSubview:view];
    }
}

- (void)clicked:(id)sender
{
    UIButton *bt = sender;
    [self.delegate clickedImage:bt];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;

    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}





@end
