//
//  Test1ViewController.h
//  shen1d
//
//  Created by Peter Zhu on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AZGenieView.h"
#import "PublicDefine.h"
#import "SBJson.h"

@interface Test1ViewController : UIViewController <AZGenieAnimationDelegate>{
    UIButton *bt;
//    UIButton *flowerView;
    NSTimer *timer;
    AZGenieView *genieView;
}
//@property (strong, nonatomic) IBOutlet AZGenieView *genieView;

@end
