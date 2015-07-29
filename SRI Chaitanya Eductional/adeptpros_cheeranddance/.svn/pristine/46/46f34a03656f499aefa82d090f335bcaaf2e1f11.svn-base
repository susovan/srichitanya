//
//  NSString+dsfcs.m
//  Cheer&Dance
//
//  Created by Madhava Reddy on 3/10/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "NSString+dsfcs.h"

@implementation NSString (dsfcs)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)self,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(encoding)));
}
@end
