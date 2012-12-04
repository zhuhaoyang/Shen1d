//
//  serviceGetDiscounts.h
//  shen1d
//
//  Created by Myth on 12-11-13.
//
//

#import "serviceInterface.h"

@protocol serviceGetDiscountsCallBackDelegate;
@interface serviceGetDiscounts:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGetDiscountsCallBackDelegate<NSObject>;

- (void)serviceGetDiscountsCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
@end
