//
//  CDCameraPreviewController.h
//  YDT
//
//  Created by 易愿 on 16/10/21.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDCameraOperatorController.h"
#import "CDCustomCameraMode.h"
#import "LLSimpleCamera.h"

@interface CDCameraPreviewController : CDCameraOperatorController

@property (nonatomic, strong) CDCustomCameraMode *mode;

- (LLSimpleCamera *)camera;

@end

