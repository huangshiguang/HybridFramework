//
//  CDCameraButtonStyleDTO.h
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/21.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDBaseDTO.h"
#import "CDViewStyle.h"

@interface CDButtonStyle : CDViewStyle

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, copy) NSString *action;

- (UIButton *)generateButtonWithType:(UIButtonType)type;

@end
