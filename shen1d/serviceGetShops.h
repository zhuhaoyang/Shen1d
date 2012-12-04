//
//  serviceGetShops.h
//  shen1d
//
//  Created by Myth on 12-11-4.
//
//

#import "serviceInterface.h"

@protocol serviceGetShopsCallBackDelegate;
@interface serviceGetShops:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGetShopsCallBackDelegate<NSObject>;

- (void)serviceGetShopsCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
@end

