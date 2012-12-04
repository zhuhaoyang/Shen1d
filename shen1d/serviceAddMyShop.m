//
//  serviceAddMyShop.m
//  shen1d
//
//  Created by Myth on 12-11-5.
//
//

#import "serviceAddMyShop.h"

@implementation serviceAddMyShop

-(id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode
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
    
    m_dicReceiveData = [[NSMutableDictionary alloc] initWithDictionary:[json objectFromJSONString]];
    
}

- (void)passDataOutWithError:(Error*)error
{
	if (nil != m_delegate
		&& [m_delegate respondsToSelector:@selector(serviceAddMyShopCallBack:withErrorMessage:)])
	{
		[m_delegate serviceAddMyShopCallBack:m_dicReceiveData withErrorMessage:error];
	}
}


@end
