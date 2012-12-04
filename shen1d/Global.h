//
//  Global.h
//  greenBerryReader
//
//  Created by haoyang zhu on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject{
    NSMutableArray *arrOrder;
}
@property (nonatomic,assign) BOOL isLogined;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *uname;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *created;
@property (nonatomic,strong) NSString *avatar;

@property (nonatomic,strong) UIImage *qrcode;
+ (Global *) sharedGlobal;

@end
