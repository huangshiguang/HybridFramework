//
//  CDCameraButtonStyleDTO.m
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/21.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDButtonStyle.h"
#import <UIColor+YYAdd.h>
#import "CDFileDTO.h"
#import <NSObject+YYModel.h>

@interface CDButtonStyle ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation CDButtonStyle

- (UIButton *)generateButtonWithType:(UIButtonType)type {
    if (!_button) {
        _button = [UIButton buttonWithType:type];
    }
    
    _button.frame = self.frame;
    
    if ([self.type isEqualToString:@"normalbutton"]) {
        [_button setImage:nil forState:UIControlStateNormal];
        [_button setTitleColor:self.titleColor forState:UIControlStateNormal];
        if (self.titleFont) {
            NSDictionary *atts = @{NSFontAttributeName:self.titleFont, NSForegroundColorAttributeName : self.titleColor};
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:self.title attributes:atts];
            [_button setAttributedTitle:attString forState:UIControlStateNormal];
        } else {
            [_button setAttributedTitle:nil forState:UIControlStateNormal];
            [_button setTitle:self.title forState:UIControlStateNormal];
            [_button setTitleColor:self.titleColor forState:UIControlStateNormal];
        }
    } else if ([self.type isEqualToString:@"imagebutton"]) {
        [_button setTitle:nil forState:UIControlStateNormal];
        [_button setImage:self.image forState:UIControlStateNormal];
    }
    return _button;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }
    return _titleColor;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary {
    CDButtonStyle *style = [super modelWithDictionary:dictionary];
    if (dictionary[@"titleColor"]) {
        style.titleColor = [UIColor colorWithHexString:dictionary[@"titleColor"]];
    }
    if (dictionary[@"titleSize"]) {
        style.titleFont = [UIFont systemFontOfSize:[dictionary[@"titleSize"] integerValue]];
    }
    return style;
}

@end
