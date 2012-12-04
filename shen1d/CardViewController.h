//
//  CardViewController.h
//  shen1d
//
//  Created by Myth on 12-9-17.
//
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"
//#import "AZGenieView.h"
#import "CardBackView.h"
#import "TSPopoverController.h"
#import "TSActionSheet.h"
#import "MapViewController.h"
//#import "WBEngine.h"
//#import "WBSendView.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "serviceAddMyShop.h"
#import "Global.h"
#import "DatabaseManager.h"
#import "QRCodeGenerator.h"
#import "serviceGetShop.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "AppDelegate.h"
#import "GradientButton.h"

@interface CardViewController : UIViewController
<SinaWeiboDelegate,SinaWeiboRequestDelegate>{
    NSTimer *timer;
//    AZGenieView *genieView;
    UIImageView *QRCode;
    UIView *frontView;
    CardBackView *cardBackView;
    MapViewController *m_MapViewController;
    NSString *Tel;
//    WBEngine *engine;
    serviceAddMyShop *m_serviceAddMyShop;
    NSDictionary *dicShopInfo;
//    UIButton *btStoreUp;
    UIButton *btn_tag;
    NSString *m_shopId;
    serviceGetShop *m_serviceGetShop;
    UIActivityIndicatorView *activity;
    GradientButton *btStoreUp;
    GradientButton *btLogin;
}

- (id)initWithNibName:(NSString *)nibNameOrNil  shopId:(NSString *)shopId bundle:(NSBundle *)nibBundleOrNil;

@end
