//
//  serviceGetShops.m
//  shen1d
//
//  Created by Myth on 12-11-4.
//
//

#import "serviceGetShops.h"

@implementation serviceGetShops


-(id)initWithDelegate:(id)aDelegate
		  requestMode:(TRequestMode)mode
{
	self = [self init];
	if (self)
	{
		m_delegate = aDelegate;
		m_requestMode = mode;
	}
	return self;
}

- (void)parseResponseData:(NSString *)json
{
    if (json == nil || [json isEqualToString:@""])
	{
		NSString *sMsg = [[NSString alloc] initWithFormat:@"Empty response json file!"];
		m_error.m_Message = sMsg;
        //		SAFE_RELEASE(sMsg);
		return;
    }
    NSLog(@"%@",json);
//    SBJsonParser * parser = [[SBJsonParser alloc] init];
//    NSError * error = nil;
//    m_dicReceiveData = [[NSMutableDictionary alloc] initWithDictionary:[parser objectWithString:json error:&error]];
    m_dicReceiveData = [[NSMutableDictionary alloc] initWithDictionary:[json objectFromJSONString]];
    
}

- (void)passDataOutWithError:(Error*)error
{
	if (nil != m_delegate
		&& [m_delegate respondsToSelector:@selector(serviceGetShopsCallBack:withErrorMessage:)])
	{
		[m_delegate serviceGetShopsCallBack:m_dicReceiveData withErrorMessage:error];
	}
}

@end
