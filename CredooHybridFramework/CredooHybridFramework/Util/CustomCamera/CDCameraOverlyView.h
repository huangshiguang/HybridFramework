//
//  CDCameraOverlyView.h
//  YDT
//
//  Created by Taurus on 16/10/22.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCameraOverlyView : UIView

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, assign) UIEdgeInsets cameraEdgeInsets;

- (CGRect)resultImageRectWithScale:(CGFloat)scale;

@end
