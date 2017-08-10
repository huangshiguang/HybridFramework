//
//  CDCameraOverlyView.m
//  YDT
//
//  Created by Taurus on 16/10/22.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDCameraOverlyView.h"

@implementation CDCameraOverlyView

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.bounds;
        [self addSubview:imageView];
        [self sendSubviewToBack:imageView];
        
        self.backgroundImageView = imageView;
    }
    return _backgroundImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundImageView.frame = self.bounds;
}

- (CGRect)resultImageRectWithScale:(CGFloat)scale {
    CGSize overlyViewSize = self.frame.size;
    UIEdgeInsets insets = self.cameraEdgeInsets;
    return CGRectMake(self.cameraEdgeInsets.left *scale,
                      self.cameraEdgeInsets.top *scale,
                      (overlyViewSize.width - insets.left - insets.right) *scale,
                      (overlyViewSize.height - insets.top - insets.bottom) *scale);
}

@end
