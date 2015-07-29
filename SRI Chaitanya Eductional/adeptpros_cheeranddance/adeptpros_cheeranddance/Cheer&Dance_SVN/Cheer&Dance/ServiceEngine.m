//
//  ServiceEngine.m
//  WebService
//
//  Created by KARTHIK BEDRE L on 30/06/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "ServiceEngine.h"

@implementation ServiceEngine
@synthesize webServiceDelegate;

static ServiceEngine* _sharedInformation= nil;

#pragma mark Initialize

+(ServiceEngine*)CallService
{
	@synchronized([ServiceEngine class])
	{
		if (!_sharedInformation)
        {
			NSAssert(_sharedInformation == nil, @"Attempted to allocate a second instance of a singleton.");
            _sharedInformation = [super alloc];
        }
		return _sharedInformation;
	}
	return nil;
}

#pragma mark Post Request

-(void)PostService:(NSString *)service body:(NSString *)body context:(NSString *)context authorization:(NSString *)auth
{
    __block NSString *api=service;
    __block NSString *Context=context;
    __block NSString *request_body=body;
    NSURL *reqUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",api]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:reqUrl];
    [request setHTTPBody:[request_body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:auth forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:15];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(error)
         {
             NSArray *resp=[NSArray arrayWithObjects:@"error",Context,api, nil];
             [self performSelectorOnMainThread:@selector(SendResponse:) withObject:resp waitUntilDone:YES];
             return;
         }
         else
         {
             NSArray *resp=[NSArray arrayWithObjects:data,Context,api,request_body, nil];
             [self performSelectorOnMainThread:@selector(SendResponse:) withObject:resp waitUntilDone:YES];
         }
     }];
}

#pragma mark Delegates

-(void)SendResponse:(NSArray *)response
{
    if([[response objectAtIndex:0] isKindOfClass:[NSData class]])
    {
        NSData *data=[response objectAtIndex:0];
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(json)
        {
            [webServiceDelegate WebServiceRequestCompleted:json context:[response objectAtIndex:1]];
        }
        else
        {
            [self SendRequestFailed:[response objectAtIndex:1] service:[response objectAtIndex:2]];
        }
    }
    else
    {
        [self SendRequestFailed:[response objectAtIndex:1] service:[response objectAtIndex:2]];
    }
}

-(void)SendRequestFailed:(NSString *)context service:(NSString *)api
{
    [webServiceDelegate WebServiceRequestFailed:context service:api];
}

@end
