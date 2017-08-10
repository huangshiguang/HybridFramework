//
//  CDCustomCameraController.h
//  YDT
//
//  Created by Taurus on 16/10/22.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDCustomCameraMode.h"

@class CDCustomCameraController;

typedef void(^CDCameraCompletion)(CDCustomCameraController *controller, UIImage *image, NSError *error);

@interface CDCustomCameraController : UINavigationController

@property (nonatomic, strong) CDCustomCameraMode *mode;
@property (nonatomic, copy) CDCameraCompletion completion;

- (instancetype)initWithMode:(CDCustomCameraMode *)mode;
- (void)handleCompletion:(CDCameraCompletion)completion;

- (void)takePhoto:(CDCameraCompletion)completion;

@end
