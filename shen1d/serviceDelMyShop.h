//
//  serviceDelMyShop.h
//  shen1d
//
//  Created by Myth on 12-11-5.
//
//

#import "serviceInterface.h"

@protocol serviceDelMyShopCallBackDelegate;
@interface serviceDelMyShop:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceDelMyShopCallBackDelegate<NSObject>;

- (void)serviceDelMyShopCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
@end