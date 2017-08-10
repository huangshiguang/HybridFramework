//
//  CDCustomCameraMode.h
//  YDT
//
//  Created by Taurus on 16/10/22.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDCameraOverlyView.h"

@interface CDCustomCameraMode : NSObject

@property (nonatomic, assign) BOOL isNeedConfirm;
@property (nonatomic, assign) BOOL subviewsRotations;
@property (nonatomic, strong) CDCameraOverlyView *cameraOverlyView;

@property (nonatomic, assign) UIInterfaceOrientation orientation;

@end
