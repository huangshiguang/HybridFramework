//
//  CDAlertWidget.m
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/28.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDAlertWidget.h"
#import <NSObject+YYModel.h>

@interface CDAlertWidget ()

@property (nonatomic, strong) NSDictionary *params;

@end

@implementation CDAlertWidget

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.widgetName = @"/widget/showAlert";
    }
    return self;
}

- (void)prepareWithDictionary:(NSDictionary *)dic {
    [super prepareWithDictionary:dic];
    self.params = dic;
}

- (void)performWithController:(RXRViewController *)controller {
    CDAlertDTO *dto = [CDAlertDTO modelWithDictionary:self.params];
    if ([self.delegate respondsToSelector:@selector(showAlertWithInfo:)]) {
        [self.delegate showAlertWithInfo:dto];
    }
}

@end
