//
//  CDBaseContainerAPI.h
//  RexxarDemo
//
//  Created by 易愿 on 16/11/15.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Rexxar/Rexxar.h>
#import "CredooHybridConstant.h"

@protocol CDBaseContainerAPIProtocol <NSObject>

- (void)performWithRequest:(NSURLRequest *)request values:(NSDictionary *)values completed:(void (^)(NSData *data))completed;

@end

@interface CDBaseContainerAPI : NSObject <RXRContainerAPI,CDBaseContainerAPIProtocol>

// apiName 为 /api/method,  H5请求的完整Url http://rexxar-container/api/method
@property (nonatomic, copy) NSString *apiName;

// 子类需要实现的方法
- (void)performWithRequest:(NSURLRequest *)request values:(NSDictionary *)values completed:(void (^)(NSData *data))completed;

// 封装返回给H5的数据
- (NSData *)responseDataWithCode:(NSNumber *)code message:(NSString *)message data:(NSDictionary *)data;

@end
