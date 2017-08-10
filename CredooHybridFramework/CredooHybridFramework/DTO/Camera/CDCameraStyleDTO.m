//
//  CDCameraStyleDTO.m
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/21.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDCameraStyleDTO.h"
#import <NSObject+YYModel.h>

@implementation CDCameraStyleDTO

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"components" : [CDCameraButtonStyle class]};
}

@end
