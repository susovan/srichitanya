
//
//  WebService.m
//  Dtnew
//
//  Created by Madhu on 09/06/10.
//  Copyright 2010 Adylan. All rights reserved.
//
#import "WebService.h"
#import <CFNetwork/CFNetwork.h>


@implementation WebService
@synthesize	mDelegate;
@synthesize	m_pHTTPRsp,m_pHttpResponceData,m_pSuccessData;


- (id) initWebService: (NSString*)l_pURLAddr
{
    //self=[super init]
    
    m_pURLAddr	= [[NSString alloc] initWithString:l_pURLAddr];
    return self;
    
    /*self = [super init];
    if(self){
        m_pURLAddr	= [[NSString alloc] initWithString:l_pURLAddr];
    }
    return self;*/
    
}

-(void) sendHTTPPostSync:(NSString *)request_body
{
	NSURL		*l_pURL		= [NSURL URLWithString:m_pURLAddr];
	NSMutableURLRequest *l_pRequest = [[NSMutableURLRequest alloc] initWithURL:l_pURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:45.0];
	
	if(request_body != nil)
		[l_pRequest setHTTPBody:[request_body dataUsingEncoding:NSUTF8StringEncoding]];
	
	[l_pRequest setHTTPMethod:@"POST"];

	m_pHttpResponceData	=	[NSURLConnection	sendSynchronousRequest:l_pRequest returningResponse:nil error:nil];
	[l_pRequest		release];
	
	m_pSuccessData	=	YES;
	[mDelegate	webServiceRequestCompletedSync];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	//if ([m_pURLAddr retainCount]) {
//	[m_pURLAddr		release];	
//	}
	
}

- (void) sendHTTPRequest
{
	
	if (![NSThread isMainThread])
	{
		[self performSelectorOnMainThread:@selector(sendHTTPRequest) withObject:nil waitUntilDone:NO];
		return;
	}
	
	NSURL		*l_pURL		= [NSURL URLWithString:m_pURLAddr];
	NSMutableURLRequest	*l_pURLReq	= [[NSMutableURLRequest alloc] initWithURL:l_pURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:45.0];
	NSURLConnection	*l_pConn	= [[NSURLConnection alloc] initWithRequest:l_pURLReq delegate:self  startImmediately:NO];
	[l_pConn scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	[l_pConn		  start];
	[m_pURLAddr		release];
	[l_pConn		release];
	[l_pURLReq		release];
   
}


- (void) sendHTTPRequest:(NSMutableURLRequest *)l_pURLReq
{
	
	m_pConn	= [[NSURLConnection alloc] initWithRequest:l_pURLReq delegate:self  startImmediately:NO];
   
	[m_pConn scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	[m_pConn			start];
	[m_pURLAddr		release];
	[m_pConn		release];
	
	
}

-(void) sendHTTPPost:(NSString *)request_body{
	
	if (![NSThread isMainThread])
	{
		[self performSelectorOnMainThread:@selector(sendHTTPPost:) withObject:request_body waitUntilDone:NO];
		return;
	}

	NSURL		*l_pURL		= [NSURL URLWithString:m_pURLAddr];
	NSMutableURLRequest *l_pRequest = [[NSMutableURLRequest alloc] initWithURL:l_pURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:45.0];
	//NSLog(@"%@",l_pRequest);
	if(request_body != nil)
		[l_pRequest setHTTPBody:[request_body dataUsingEncoding:NSUTF8StringEncoding]];
	
	[l_pRequest setHTTPMethod:@"POST"];
	NSURLConnection	*l_pConn	= [[NSURLConnection alloc] initWithRequest:l_pRequest delegate:self  startImmediately:NO];
	[l_pConn scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	[l_pConn			start];
	[m_pURLAddr		release];
	[l_pConn			release];
	[l_pRequest		release];
	
}
#pragma mark NSURLConnection Callbacks

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[m_pHTTPRsp release];
	m_pHTTPRsp = [[NSMutableData alloc] init];
	
//	NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
//	//NSLog(@"%i",[httpResponse statusCode]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[m_pHTTPRsp appendData:data];
}
-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error
{

    NSLog(@"%@",[error description]);
    
    [mDelegate webServiceRequestFail:error];
    
    
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	if ([error code] == kCFURLErrorNotConnectedToInternet)
	{	// if we can identify the error, we can present a more precise message to the user.
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[error localizedDescription]  forKey:NSLocalizedDescriptionKey];
		NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:userInfo];
		[self handleError:noConnectionError];
	}
	else
	{   // otherwise handle the error generically
		[self handleError:error];
	}

	[m_pHTTPRsp		release];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection
{
    
	m_pSuccessData	=	YES;
	// create the queue to run our ParseOperation
	[mDelegate webServiceRequestCompleted];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}

- (void)handleError:(NSError *)error
{
    m_pSuccessData	= NO;
    [mDelegate webServiceRequestCompleted];
    NSString *errorMessage = [error localizedDescription];
    NSLog(@"%@",errorMessage);
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(!status == NotReachable)
     {
	   UIAlertView * alert	= [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"",@"") message:errorMessage delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok",@"") otherButtonTitles:nil];
	   [alert show];
	   [alert release];
    }
}

- (void)cancelDownload
{
	self.m_pHTTPRsp = nil;
}

-(void) dealloc
{         
	[super dealloc];
}

@end
