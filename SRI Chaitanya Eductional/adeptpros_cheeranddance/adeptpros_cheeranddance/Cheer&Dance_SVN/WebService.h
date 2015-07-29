	//
	//  WebService.h
	//  Dtnew
	//
	//  Created by Kumar Deepak on 09/06/10.
	//  Copyright 2010 Adylan. All rights reserved.
	//

#import <Foundation/Foundation.h>


@protocol WebServiceCompleteDelegate

- (void) webServiceRequestCompleted;


@optional
- (void)webServiceRequestCompletedSync;
@end

@interface WebService : NSObject
{
    NSString					*m_pURLAddr;
    NSMutableData				*m_pHTTPRsp;
    NSString					*m_pHTTPRspStr;
	NSURLConnection				*m_pConn;	
	NSData					*m_pHttpResponceData;
    id <WebServiceCompleteDelegate>		mDelegate;
	BOOL					m_pSuccessData;
}

- (id) initWebService: (NSString*)l_pURLAddr;
- (void) sendHTTPRequest;
-(void) sendHTTPPost:(NSString *)request_body;

-(void) sendHTTPPostSync:(NSString *)request_body;
- (void)handleError:(NSError *)error;
- (void)cancelDownload;

- (void) sendHTTPRequest:(NSMutableURLRequest *)l_pURLReq;

@property (nonatomic)BOOL					m_pSuccessData;
@property (nonatomic, retain) id <WebServiceCompleteDelegate>	mDelegate;
@property (nonatomic, assign) NSMutableData			*m_pHTTPRsp;
@property (nonatomic, assign) NSData				*m_pHttpResponceData;


@end
