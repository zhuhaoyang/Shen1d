//
//  serviceGetShop.h
//  shen1d
//
//  Created by Myth on 12-11-13.
//
//

#import "serviceInterface.h"

@protocol serviceGetShopCallBackDelegate;
@interface serviceGetShop:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGetShopCallBackDelegate<NSObject>;

- (void)serviceGetShopCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
@end