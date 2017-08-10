//
//  CDLoggerContainerAPI.m
//  CredooHybridFramework
//
//  Created by 徐佳良 on 2016/11/18.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDLoggerContainerAPI.h"

@implementation CDLoggerContainerAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiName = @"/api/logger";
    }
    return self;
}


- (void)performWithRequest:(NSURLRequest *)request values:(NSDictionary *)values completed:(void (^)(NSData *data))completed{
    completed([super responseDataWithCode:kApiSuccessCode message:@"" data:@{@"content" : values[@"content"]}]);
}

@end
