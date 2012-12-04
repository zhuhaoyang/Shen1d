//
//  serviceGoogleMap.m
//  shen1d
//
//  Created by Myth on 12-11-7.
//
//

#import "serviceGoogleMap.h"

@interface serviceGoogleMap(private)
//- (GDataXMLElement *)creatRequestBody:(NSDictionary*)aDic key:(NSString *)key;
- (void)parseResponseData:(NSString *)json;
- (void)passDataOutWithError:(Error*)error;

@end


@implementation serviceGoogleMap
//@synthesize m_request = _m_request;
//@synthesize m_requestMode;
//@synthesize m_error = _m_error;
//@synthesize m_dicReceiveData = _m_dicReceiveData;
#pragma mark -
#pragma mark Initialization & Deallocation

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode
{
    self = [self init];
	if (self)
	{
		m_delegate = aDelegate;
		m_requestMode = mode;
	}
	return self;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		m_request = nil;
		m_dicReceiveData = nil;
		m_error = [[Error alloc] init];
		m_requestMode = TRequestMode_Asynchronous;// set default
	}
	return self;
}

//-(id)initWithDelegate:(id<serviceCallBackDelegate>)aDelegate
//		  requestMode:(TRequestMode)mode
//{
//	self = [self init];
//	if (self)
//	{
//		m_delegate = aDelegate;
//		m_requestMode = mode;
//	}
//	return self;
//}

//-(void)dealloc
//{
//	[super dealloc];
//	if (nil != m_request) [m_request cancel];
//	[m_request release];
//	[m_dicReceiveData release];
//	[m_error release];
//}

#pragma mark -
#pragma mark RequestCreation and Request sending

-(void)sendRequestWithData:(NSString*)str addr:(NSString *)addr
{
	if (nil == m_request)
	{
        //        UITextView *tx;
		//服务器地址
        //        register?username=TIM&password=hello123&email=tim0405@gmail.com&phonenumber=1357
		NSString *theServerAddr	= @"http://maps.googleapis.com/maps/api/geocode/";
		//[[SystemSetting shareInstance] getServerUrl];
		//拼凑请求地址
		NSString *httpStr = [[NSString alloc] initWithFormat:@"%@%@",theServerAddr,addr];
		NSURL *url = [[NSURL alloc] initWithString:httpStr];
		
		// Initialization the http engine (required)
		m_request = [[ASIFormDataRequest alloc] initWithURL:url];
		[m_request setRequestMethod:@"GET"]; // set post method
		[m_request setTimeOutSeconds:kTimeOutDuration]; // set time out duration
		[m_request setDelegate:self];
	}
	
	// Create body (required)
    //	GDataXMLElement *element = [GDataXMLNode elementWithName:@"OrderId" stringValue:@"2"];
    
    
    
    //    GDataXMLElement *element = [self creatRequestBody:aDic key:@"body"];
    
    //	GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:element];
    //	[document setVersion:@"1.0"];
    //	[document setCharacterEncoding:@"UTF-8"];
    //    NSData *bodyData = [document XMLData];
    //	NSString * str = [[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding];
    
    //    NSString * str = [[NSString alloc]initWithString:@"OrderId=2"];
    
    
	LOGS(@"required = %@",str);
    //	[str release];
	// Add header (optional)
	NSString *sDataLength = [[NSString alloc] initWithFormat:@"%d", [str length]];
	[m_request addRequestHeader:@"Content-length" value:sDataLength];
    
    [m_request addRequestHeader:@"Content-Type"value:@"application/x-www-form-urlencoded"];
    //    [theRequest addRequestHeader:@"SOAPAction"value:@"http://tempuri.org/AddOrderData"];
    //
    [m_request appendPostData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    //
    //    [theRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    
    
    //	SAFE_RELEASE(sDataLength);
    
	// Add body data (required)
    //	[m_request appendPostData:bodyData];
	
	// Send request (required)
	switch (m_requestMode)
	{
		case TRequestMode_Synchronous:
		{
			[m_request startSynchronous];
            
			NSError *error = [m_request error];
			if (!error)
			{
				NSString *sReponse = [m_request responseString];
				[self parseResponseData:sReponse];
				[self passDataOutWithError:m_error];
			}
			else
			{
				if (nil != m_dicReceiveData)
				{
                    //					SAFE_RELEASE(m_dicReceiveData);
				}
				m_error.m_NSError = error;
				[self passDataOutWithError:m_error];
			}
			break;
		}
		case TRequestMode_Asynchronous:
		default:
		{
			[m_request startAsynchronous];
			break;
		}
	}
}

// Create the body
//- (GDataXMLElement *)creatRequestBody:(NSDictionary*)aDic key:(NSString *)key
//{
//	GDataXMLElement * rootElement = [GDataXMLNode elementWithName:key];
//	GDataXMLElement * oneElement;
//	NSArray * allKeys = [aDic allKeys];
//	NSUInteger i, count = [allKeys count];
//	for(i = 0; i < count; i++){
//
//		if ([[aDic objectForKey:[allKeys objectAtIndex:i]] isKindOfClass:[NSDictionary class]]) {
//			oneElement = [self creatRequestBody:[aDic objectForKey:[allKeys objectAtIndex:i]] key:[allKeys objectAtIndex:i]];
//		}else {
//			oneElement = [GDataXMLNode elementWithName:[allKeys objectAtIndex:i]
//										   stringValue:[aDic objectForKey:[allKeys objectAtIndex:i]]];
//		}
//		[rootElement addChild:oneElement];
//	}
//	return rootElement;
//}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *sReponse = [request responseString];
	[self parseResponseData:sReponse];
	[self passDataOutWithError:m_error];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	if (nil != m_dicReceiveData)
	{
        //		SAFE_RELEASE(m_dicReceiveData);
	}
	m_error.m_NSError = error;
	[self passDataOutWithError:m_error];
}

#pragma mark -
#pragma mark ReponseParsing
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


#pragma mark -
#pragma mark serviceCallBackDelegateCallBack
- (void)passDataOutWithError:(Error*)error
{
    if (nil != m_delegate
		&& [m_delegate respondsToSelector:@selector(serviceGoogleMapCallBack:withErrorMessage:)])
	{
		[m_delegate serviceGoogleMapCallBack:m_dicReceiveData withErrorMessage:error];
	}}

@end

