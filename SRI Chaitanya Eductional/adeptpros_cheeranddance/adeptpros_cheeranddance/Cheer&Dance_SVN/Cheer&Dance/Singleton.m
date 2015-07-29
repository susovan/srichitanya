//
//  Singleton.m
//  Cheer&Dance
//
//  Created by Amit on 1/14/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
@synthesize loginUserID,team_Name,event_Name,city_Name,date_Name,gym_Name,level_Name,team_id,ar_Team_ids,ar_Team_Names,screenID,checkleftpanelID,singView,event_ID,gym_id,level_id;

@synthesize team_Name1,event_Name1,city_Name1,date_Name1,gym_Name1,level_Name1,team_id1,event_ID1,gym_id1,level_id1,lbl_Division,lbl_Label,lb_Gym_id_forTeamList,selected_index,leftpan_selecteTeam,Dict_schNextTeam,RatingTile_idArray_build,RatingTile_idArray_tum,RatingTile_idArray_cho,selected_section,AccessScreenArray,division_id,level_id_new,AccessScreenArray1;


//for timer
@synthesize dict_ScheduleScreen;

+(Singleton *)getObject
{
    static Singleton *s=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!s)
        {
        s=[[Singleton alloc]init];
        }
    });
    return s;

}

+(BOOL)getnetConnection
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"" message:@"Please check your Wi-Fi or 3G connection and try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [al show];
        return YES;
    }
    
    else
    {
        return NO;
    }
    
}

+(NSMutableURLRequest *)getRequestObject:(NSString *)url urlAndstring :(NSString *)queryString;
{
    NSString *   stringUrl = [url stringByAppendingString:queryString];
    stringUrl = [stringUrl stringByAppendingString:@"]"];
    stringUrl =[stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url1];
    //  NSLog(@"%@",request);
    NSData *requestData = [NSData dataWithBytes:[queryString UTF8String] length:[queryString length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    return request;
}

@end
