//
//  ServiceEngine.m
//  WebService
//
//  Created by KARTHIK BEDRE L on 30/06/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "ServiceEngine.h"

static NSString *key_error=@"error";
static NSString *key_context=@"context";
static NSString *key_api=@"api";
static NSString *key_body=@"request_body";
static NSString *key_auth=@"request_auth";
static NSString *key_data=@"data";

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

-(void)PostService:(NSString *)service body:(NSString *)body context:(NSString *)context authorization:(NSString *)auth httpMethod:(HttpMethodType)Request_type
{
    __block NSString *api=service;
    __block NSString *Context=context;
    __block NSString *set_body=body;
    __block NSString *set_auth=auth;
    NSURL *reqUrl =[NSURL URLWithString:api]; //[NSURL URLWithString:[NSString stringWithFormat:@"%@",api]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:service]];
    
    if(set_body)
        [request setHTTPBody:[set_body dataUsingEncoding:NSUTF8StringEncoding]];
    
    if(set_auth)
        [request setValue:set_auth forHTTPHeaderField:@"Authorization"];
    
//    [request setHTTPMethod:[self HttpMethodType:Request_type]];
//    [request setTimeoutInterval:15];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSMutableDictionary *Response_Dict=[[NSMutableDictionary alloc]init];
         if(Context)
             [Response_Dict setObject:Context forKey:key_context];
         
             [Response_Dict setObject:api forKey:key_api];
         
         if(set_body)
             [Response_Dict setObject:set_body forKey:key_body];
         if(set_auth)
             [Response_Dict setObject:set_auth forKey:key_auth];
         
         if(error)
         {
             [Response_Dict setObject:@"error" forKey:key_error];
             [self performSelectorOnMainThread:@selector(SendResponse:) withObject:Response_Dict waitUntilDone:YES];
             return;
         }
         else
         {
             [Response_Dict setObject:data forKey:key_data];
             [self performSelectorOnMainThread:@selector(SendResponse:) withObject:Response_Dict waitUntilDone:YES];
         }
     }];
}

-(NSString *)HttpMethodType:(HttpMethodType)type
{
    switch (type) {
        case HTTPMethod_GET:
            return @"GET";
            break;
            
        case HTTPMethod_POST:
            return @"POST";
            break;
            
        default:
            break;
    }
}

#pragma mark Delegates

-(void)SendResponse:(NSDictionary *)response
{
    if(response[key_data])
    {
        NSData *data=response[key_data];
        NSError *error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@",json);
        if(json)
        {
            if(response[key_context])
                [webServiceDelegate WebServiceRequestCompleted:json context:response[key_context]];
            else
                [webServiceDelegate WebServiceRequestCompleted:json context:nil];
        }
        else
        {
            [self SendRequestFailed:response];
        }
    }
    else
    {
        [self SendRequestFailed:response];
    }
}

-(void)SendRequestFailed:(NSDictionary *)response
{
    [webServiceDelegate WebServiceRequestFailed:response];
}

@end
