//
//  Utility.h
//  SRI Chaitanya Eductional
//
//  Created by susovan on 7/6/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface Utility : NSObject
{

}
+ (BOOL) isInternetAvailable ;
+ (void) startActivityIndicatorOnView: (UIView *) inView withText: (NSString *) inStr;

+ (void) stopActivityIndicatorFromView: (UIView *) inView;
+(void) showToast: (NSString *) text inView:(UIView *) inView;


@end
