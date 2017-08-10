//
//  CDNavTitleWidget.m
//  CredooHybridFramework
//
//  Created by 徐佳良 on 2016/11/19.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDNavTitleWidget.h"

@interface CDNavTitleWidget()

@property (nonatomic,strong) NSString *title;

@end

@implementation CDNavTitleWidget

- (BOOL)canPerformWithURL:(NSURL *)URL
{
    NSString *path = URL.path;
    if (path && [path isEqualToString:@"/widget/nav_title"]) {
        return YES;
    }
    return NO;
}

- (void)prepareWithDictionary:(NSDictionary *)dic{
    self.title = dic[@"title"];
}

- (void)performWithController:(RXRViewController *)controller
{
    if (controller) {
        controller.title = self.title;
    }
}

@end
