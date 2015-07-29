//
//  Utility.m
//  SRI Chaitanya Eductional
//
//  Created by susovan on 7/6/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "Utility.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Reachability.h"

#define mbIndicatorTag                110

#define mbToastTag                    111
@implementation Utility

+ (BOOL)isInternetAvailable{
    NetworkStatus currentStatus = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus];
    if(currentStatus == ReachableViaWiFi || currentStatus == ReachableViaWWAN)
        return YES;
    return NO;
}

+ (void) startActivityIndicatorOnView: (UIView *) inView withText: (NSString *) inStr{
    
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    if(!inView || inView == nil){
        inView = [[[UIApplication sharedApplication]windows]lastObject];
    }
    MBProgressHUD *mbLoadingScreen = (MBProgressHUD *)[inView viewWithTag:mbIndicatorTag];
    if(mbLoadingScreen == nil){
        mbLoadingScreen = [[MBProgressHUD alloc]initWithView:inView];
        mbLoadingScreen.labelText = inStr;
        mbLoadingScreen.tag = mbIndicatorTag;
        mbLoadingScreen.alpha = 0;
        [inView addSubview:mbLoadingScreen];
    }else{
        mbLoadingScreen.labelText = inStr;
    }
    [UIView animateWithDuration:0.25
                     animations:
     ^{
         mbLoadingScreen.alpha = 1.0f;
         
     }];
}
+ (void) stopActivityIndicatorFromView: (UIView *) inView{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (!inView) {
        inView = [[[UIApplication sharedApplication] windows] lastObject];
    }
    if([inView viewWithTag: mbIndicatorTag])
    {
        MBProgressHUD *mbLoadingScreen = (MBProgressHUD *)[inView viewWithTag:mbIndicatorTag];
        [UIView animateWithDuration: 0.15 animations:^{
            mbLoadingScreen.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [mbLoadingScreen hide:YES];
            [mbLoadingScreen removeFromSuperview];
        }];
    }
}
+ (void) showToast: (NSString *) text inView:(UIView *) inView{
    if (!inView) {
        
        inView = [[[UIApplication sharedApplication] windows] lastObject];
    }
    MBProgressHUD *mLoadingScreen =(MBProgressHUD*)[inView viewWithTag:mbToastTag];
    if(mLoadingScreen==nil){
        mLoadingScreen = [[MBProgressHUD alloc]initWithView:inView];
       mLoadingScreen.detailsLabelFont = [UIFont fontWithName:@"Helvetica" size:12];
        mLoadingScreen.detailsLabelText = text;
        mLoadingScreen.tag=mbToastTag;
        mLoadingScreen.mode = MBProgressHUDModeText;
        mLoadingScreen.margin = 10.f;
        mLoadingScreen.yOffset = 150.f;
        [inView addSubview:mLoadingScreen];
    }
    else {
        mLoadingScreen.detailsLabelText = text;
    }
    [UIView animateWithDuration:0.25
                     animations:
     ^{
         mLoadingScreen.alpha = 1.0f;
     }];
    [mLoadingScreen hide:YES afterDelay:2];
    
}



@end
