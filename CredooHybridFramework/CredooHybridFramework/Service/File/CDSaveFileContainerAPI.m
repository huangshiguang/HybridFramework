//
//  CDSaveFileContainerAPI.m
//  RexxarDemo
//
//  Created by 易愿 on 16/11/15.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDSaveFileContainerAPI.h"
#import <NSObject+YYModel.h>
#import "CDFileDTO.h"

static const NSString *kApiPrefixName = @"/api/photo/save";

@implementation CDSaveFileContainerAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiName = @"/api/file/save";
    }
    return self;
}

- (void)performWithRequest:(NSURLRequest *)request values:(NSDictionary *)values
{
    CDFileDTO *dto = [CDFileDTO modelWithDictionary:values];
    if ([dto.directory isKindOfClass:[NSString class]] &&
        [dto.fileName isKindOfClass:[NSString class]] &&
        [dto.fileData isKindOfClass:[NSData class]]) {
        
        BOOL success = [dto saveFileOrReplaceIfExsitsError:nil];
        if (success) {
        } else {
        }
    }
}


@end
