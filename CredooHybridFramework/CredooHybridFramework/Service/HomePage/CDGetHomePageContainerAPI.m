//
//  CDGetHomePageContainerAPI.m
//  CredooHybridFramework
//
//  Created by 刘志刚(外包) on 16/11/18.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDGetHomePageContainerAPI.h"
#import <NSObject+YYModel.h>

@interface CDGetHomePageContainerAPI ()
@property (nonatomic,strong) NSString *url;
@end

@implementation CDGetHomePageContainerAPI
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiName = @"/api/getHomePageUrl";
    }
    return self;
}

- (void)performWithRequest:(NSURLRequest *)request values:(NSDictionary *)values completed:(void (^)(NSData *data))completed{
    NSString *val = [[NSUserDefaults standardUserDefaults]objectForKey:@"homePageUrl"];
    completed([super responseDataWithCode:kApiSuccessCode message:@"" data:@{@"homePageUrl" : val==nil?@"":val}]);
}

@end
