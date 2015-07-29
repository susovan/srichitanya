//
//  ServiceEngine.h
//  WebService
//
//  Created by KARTHIK BEDRE L on 30/06/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WebServiceDelegte <NSObject>

-(void)WebServiceRequestCompleted:(NSDictionary *)result context:(NSString *)context;

@optional

-(void)WebServiceRequestFailed:(NSString *)context service:(NSString *)api;

@end

@interface ServiceEngine : NSObject

@property(nonatomic,strong) id<WebServiceDelegte> webServiceDelegate;

+(ServiceEngine*)CallService;

-(void)PostService:(NSString *)service body:(NSString *)body context:(NSString *)context authorization:(NSString *)auth;

@end
