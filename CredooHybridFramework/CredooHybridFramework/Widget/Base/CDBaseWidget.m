//
//  CDBaseWidget.m
//  RexxarDemo
//
//  Created by 易愿 on 16/11/16.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDBaseWidget.h"
#import <NSObject+YYModel.h>

NSString const * kData = @"data";

@implementation CDBaseWidget

- (BOOL)canPerformWithURL:(NSURL *)URL
{
    NSString *path = URL.path;
    if (path && [path isEqualToString:self.widgetName]) {
        return YES;
    }
    return NO;
}

- (void)prepareWithURL:(NSURL *)URL
{
    //原来的是放在data里面的
//    NSString *json = [[URL rxr_queryDictionary] rxr_itemForKey:kData];
//    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error;
//    NSDictionary *jsonDic;
//    if (jsonData) {
//         jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
//    }
//
//    [self prepareWithDictionary:jsonDic];
    //现有的是拼接在url后面的
    NSDictionary *data = [self getURLParameters:[URL absoluteString]];
    [self prepareWithDictionary:data];
}

- (void)performWithController:(RXRViewController *)controller {}

- (void)prepareWithDictionary:(NSDictionary *)dic{
    
}

- (NSString *)actionParamsJsonWithCode:(NSInteger)code message:(NSString *)message data:(NSDictionary *)data {
    message = message ? message : @"";
    NSDictionary *result = @{@"code" : @(code),
                             @"message" : message,
                             @"data" : data ? data : [NSDictionary dictionary]};
    return [result modelToJSONString];
}

#pragma mark - Getter & Setter

- (NSString *)widgetName {
    if (![_widgetName isKindOfClass:[NSString class]]) {
        _widgetName = @"";
    }
    return _widgetName;
}
#pragma mark - 解析url的参数
/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}
@end
