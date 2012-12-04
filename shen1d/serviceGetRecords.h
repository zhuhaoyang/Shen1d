//
//  serviceGetRecords.h
//  shen1d
//
//  Created by Myth on 12-11-14.
//
//

#import "serviceInterface.h"

@protocol serviceGetRecordsCallBackDelegate;
@interface serviceGetRecords:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGetRecordsCallBackDelegate<NSObject>;

- (void)serviceGetRecordsCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
@end