//
//  CDBaseWidget.h
//  RexxarDemo
//
//  Created by 易愿 on 16/11/16.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Rexxar/Rexxar.h>

@interface CDBaseWidget : NSObject <RXRWidget>

@property (nonatomic, copy) NSString *widgetName;

- (void)prepareWithDictionary:(NSDictionary *)dic;

- (void)performWithController:(RXRViewController *)controller;

- (NSString *)actionParamsJsonWithCode:(NSInteger)code message:(NSString *)message data:(NSDictionary *)data;

@end
