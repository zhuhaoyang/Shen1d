//
//  serviceLogin.h
//  shen1d
//
//  Created by Myth on 12-10-30.
//
//

#import "serviceInterface.h"

@protocol serviceLoginCallBackDelegate;
@interface serviceLogin : serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceLoginCallBackDelegate<NSObject>;

- (void)serviceLoginCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
@end