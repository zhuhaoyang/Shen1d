//
//  serviceRegister.h
//  shen1d
//
//  Created by Myth on 12-10-30.
//
//

#import "serviceInterface.h"
@protocol serviceRegisterCallBackDelegate;
@interface serviceRegister : serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceRegisterCallBackDelegate<NSObject>;

- (void)serviceRegisterCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
@end
