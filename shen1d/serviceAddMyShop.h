//
//  serviceAddMyShop.h
//  shen1d
//
//  Created by Myth on 12-11-5.
//
//

#import "serviceInterface.h"

@protocol serviceAddMyShopCallBackDelegate;
@interface serviceAddMyShop:serviceInterface
{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceAddMyShopCallBackDelegate<NSObject>;

- (void)serviceAddMyShopCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
@end


