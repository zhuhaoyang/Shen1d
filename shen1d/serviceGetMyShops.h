//
//  serviceGetMyShops.h
//  shen1d
//
//  Created by Myth on 12-11-5.
//
//

#import "serviceInterface.h"

@protocol serviceGetMyShopsCallBackDelegate;
@interface serviceGetMyShops:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGetMyShopsCallBackDelegate<NSObject>;

- (void)serviceGetMyShopsCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
@end
