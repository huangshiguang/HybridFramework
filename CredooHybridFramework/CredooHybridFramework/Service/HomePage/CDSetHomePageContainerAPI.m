//
//  CDSetHomePageContainerAPI.m
//  CredooHybridFramework
//
//  Created by 刘志刚(外包) on 16/11/18.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDSetHomePageContainerAPI.h"
#import <NSObject+YYModel.h>


@implementation CDSetHomePageContainerAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiName = @"/api/updateHomePageUrl";
    }
    return self;
}

- (void)performWithRequest:(NSURLRequest *)request values:(NSDictionary *)values completed:(void (^)(NSData *data))completed{
    [[NSUserDefaults standardUserDefaults]setValue:values[@"url"] forKey:@"homePageUrl"];
    completed([super responseDataWithCode:@(0) message:@"Operation Success" data:nil]);
    
}


@end
