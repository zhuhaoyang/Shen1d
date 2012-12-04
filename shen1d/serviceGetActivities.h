//
//  serviceGetActivities.h
//  shen1d
//
//  Created by Myth on 12-11-2.
//
//

#import "serviceInterface.h"

@protocol serviceGetActivitiesCallBackDelegate;
@interface serviceGetActivities : serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGetActivitiesCallBackDelegate<NSObject>;

- (void)serviceGetActivitiesCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
@end
