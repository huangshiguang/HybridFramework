//
//  CDGetFileContainerAPI.m
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/18.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDGetFileContainerAPI.h"
#import "CDFileDTO.h"
#import <NSObject+YYModel.h>

@implementation CDGetFileContainerAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiName = @"/api/file/get";
    }
    return self;
}

- (void)performWithRequest:(NSURLRequest *)request values:(NSDictionary *)values
{
    CDFileDTO *dto = [CDFileDTO modelWithDictionary:values];
    if ([dto.directory isKindOfClass:[NSString class]] &&
        [dto.fileName isKindOfClass:[NSString class]]) {
        
        NSData *data = [dto getFileError:nil];
        if (!data) {
//            self.responseData = [self responseDataWithCode:kApiSuccessCode message:@"" data:@{@"fileData" : data}];
        } else {
//            self.responseData = nil;
        }
    }
}

@end
