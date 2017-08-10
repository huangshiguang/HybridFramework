
//
//  CDBaseContainerAPI.m
//  RexxarDemo
//
//  Created by 易愿 on 16/11/15.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDBaseContainerAPI.h"
#import <YYKit.h>

@interface CDBaseContainerAPI ()

@property (nonatomic, copy) NSString *scheme;
@property (nonatomic, copy) NSString *host;
@property (nonatomic,strong) NSData *responseData;
@end

@implementation CDBaseContainerAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scheme = kApiSchemeDefault;
        self.host = kApiHostDefault;
    }
    return self;
}

- (BOOL)shouldInterceptRequest:(NSURLRequest *)request
{
    // http://rexxar-container/api/event_location
//    if ([request.URL.scheme isEqualToString:self.scheme] &&
//        [request.URL.host isEqualToString:self.host] &&
//        [request.URL.path hasPrefix:self.apiName]) {
//        return YES;
//    }
    //不匹配scheme 和host
    if ([request.URL.path hasPrefix:self.apiName]) {
        return YES;
    }

    return NO;
}

- (void)performWithRequest:(NSURLRequest *)request
{
    // 解析数据
    NSData *data = request.HTTPBody;
    NSString *encodeStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSString *decodeStr = [encodeStr rxr_decodingStringUsingURLEscape];
    
    NSMutableDictionary *form = [[NSMutableDictionary alloc] init];
    NSArray<NSString *> *keyValues = [decodeStr componentsSeparatedByString:@"&"];
    if (keyValues.count > 0) {
        for (NSString *keyValue in keyValues) {
            NSArray *array = [keyValue componentsSeparatedByString:@"="];
            if (array.count == 2) {
                [form setObject:array[1] forKey:array[0]];
            }
        }
    }
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    [self performWithRequest:request values:[form copy] completed:^(NSData *data) {
        self.responseData = data;
        dispatch_semaphore_signal(sema);
    }];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (NSURLResponse *)responseWithRequest:(NSURLRequest *)request
{
     NSURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:[self defaultStatusCode] HTTPVersion:kApiHttpVersionDefault headerFields:[self defaultHeaders]];
    return response;
}

-(NSDictionary *)defaultHeaders{
    return @{@"Access-Control-Allow-Origin":@"*",
             @"Access-Control-Allow-Headers":@"X-Requested-With",
             @"Access-Control-Allow-Methods":@"GET,POST,OPTIONS"
             };
}

-(NSInteger)defaultStatusCode{
    return 200;
}

#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]

- (void)performWithRequest:(NSURLRequest *)request values:(NSDictionary *)values completed:(void (^)(NSData *data))completed{
    completed([self responseDataWithCode:@(-1) message:@"Unknow Error" data:nil]);
    
    mustOverride();
}

- (NSData *)responseDataWithCode:(NSNumber *)code message:(NSString *)message data:(NSDictionary *)data {
    code = code ? code : @1;
    message = message ? message : @"";
    NSDictionary *dictionary = @{@"code" : code, @"message" : message, @"data" : data ? data : [NSDictionary dictionary]};
    return [dictionary modelToJSONData];
}

#pragma mark - Getter & Setter 


- (NSString *)scheme {
    if (!_scheme) {
        _scheme = kApiSchemeDefault;
    }
    return _scheme;
}

- (NSString *)host {
    if (!_host) {
        _host = kApiHostDefault;
    }
    return _host;
}

- (NSString *)apiName {
    if (!_apiName) {
        _apiName = @"";
    }
    return _apiName;
}

@end
