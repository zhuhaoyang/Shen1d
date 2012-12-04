//
//  serviceGoogleMap.h
//  shen1d
//
//  Created by Myth on 12-11-7.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "ASIFormDataRequest.h"
#import "PublicDefine.h"
//#import "GDataXMLNode.h"
#import <QuartzCore/QuartzCore.h>
#import "Error.h"
#import "SBJson.h"
#import "serviceInterface.h"

//@class Error;
//typedef enum  requestMode
//{
//	TRequestMode_Synchronous = 1,
//	TRequestMode_Asynchronous = 2,
//}TRequestMode;

@protocol serviceCallBackDelegate;


@class ASIFormDataRequest;
@interface serviceGoogleMap : NSObject
<ASIHTTPRequestDelegate>
{
	ASIFormDataRequest *m_request;
	TRequestMode m_requestMode;
	
	// delegate
	id m_delegate;
	
	// callBack data
	NSMutableDictionary *m_dicReceiveData;
	
	// Error
	Error *m_error;
}

//@property (nonatomic, strong) ASIHTTPRequest *m_request;
//@property (nonatomic) TRequestMode m_requestMode;
//@property (nonatomic, strong) Error *m_error;
//@property (nonatomic,weak) id<serviceCallBackDelegate> delegate;
//@property (nonatomic,strong)NSMutableDictionary *m_dicReceiveData;
//-(id)initWithDelegate:(id<serviceCallBackDelegate>)aDelegate
//		  requestMode:(TRequestMode)mode;
- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;
-(void)sendRequestWithData:(NSString *)str addr:(NSString *)addr;
@end

@protocol serviceGoogleMapCallBackDelegate<NSObject>
-(void)serviceGoogleMapCallBack:(NSDictionary*)dicCallBack withErrorMessage:(Error*)error;
@end
