//
//  CDCustomCamerMode.m
//  YDT
//
//  Created by Taurus on 16/10/22.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDCustomCameraMode.h"

@implementation CDCustomCameraMode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isNeedConfirm = YES;
    }
    return self;
}

@end
