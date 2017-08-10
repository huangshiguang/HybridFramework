//
//  CDViewStyle.h
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/21.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CDBaseDTO.h"

@interface CDViewStyle : CDBaseDTO

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

- (CGRect)frame;

@end
