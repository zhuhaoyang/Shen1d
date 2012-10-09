//
//  HomeViewController.h
//  shen1d
//
//  Created by Myth on 12-8-13.
//
//

#import <UIKit/UIKit.h>
#import "PagePhotosDataSource.h"
#import "PagePhotosView.h"
#import "PublicDefine.h"

@interface HomeViewController : UIViewController
<PagePhotosDataSource,HomeDelegate>
{
    NSMutableArray *arrImage;
    PagePhotosView *m_PagePhotosView;
}

@end
