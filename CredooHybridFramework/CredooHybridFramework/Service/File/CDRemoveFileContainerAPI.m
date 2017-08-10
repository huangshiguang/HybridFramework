//
//  CDRemoveFileContainerAPI.m
//  RexxarDemo
//
//  Created by 易愿 on 16/11/15.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDRemoveFileContainerAPI.h"
#import <NSObject+YYModel.h>
#import "CDFileDTO.h"

@implementation CDRemoveFileContainerAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiName = @"/api/file/remove";
    }
    return self;
}

- (void)performWithRequest:(NSURLRequest *)request values:(NSDictionary *)values
{
    CDFileDTO *dto = [CDFileDTO modelWithDictionary:values];
    if ([dto.directory isKindOfClass:[NSString class]] &&
        [dto.fileName isKindOfClass:[NSString class]]) {
        
        BOOL success = [dto removeFileError:nil];
        
    }
}

@end
