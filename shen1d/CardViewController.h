//
//  CardViewController.h
//  shen1d
//
//  Created by Myth on 12-9-17.
//
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"
#import "AZGenieView.h"
#import "CardBackView.h"
#import "TSPopoverController.h"
#import "TSActionSheet.h"
#import "MapViewController.h"
#import "WBEngine.h"
#import "WBSendView.h"
#import "WXApiObject.h"
#import "WXApi.h"

@interface CardViewController : UIViewController
<AZGenieAnimationDelegate,WBEngineDelegate,WBSendViewDelegate,WBRequestDelegate>{
    NSTimer *timer;
    AZGenieView *genieView;
    UIImageView *QRCode;
    UIView *frontView;
    CardBackView *cardBackView;
    MapViewController *m_MapViewController;
    NSString *Tel;
    WBEngine *engine;
}

- (id)initWithNibName:(NSString *)nibNameOrNil  data:(NSDictionary *)dic bundle:(NSBundle *)nibBundleOrNil;

@end
