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
#import "LoginViewController.h"
#import "serviceGetActivities.h"
#import "EGOImageView.h"
#import "DatabaseManager.h"
#import "serviceGetShop.h"
#import "CardViewController.h"
@interface HomeViewController : UIViewController
<PagePhotosDataSource,HomeDelegate>
{
    NSMutableArray *arrImage;
    PagePhotosView *m_PagePhotosView;
    LoginViewController *m_LoginViewController;
    serviceGetActivities *m_serviceGetActivities;
    DatabaseManager *dbManager;
    UIBarButtonItem *rightButton;
    serviceGetShop *m_serviceGetShop;
    CardViewController *m_CardViewController;
}

@end