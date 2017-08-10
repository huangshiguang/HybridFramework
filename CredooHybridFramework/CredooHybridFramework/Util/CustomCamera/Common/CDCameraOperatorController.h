//
//  CDCameraOperatorController.h
//  YDT
//
//  Created by Taurus on 16/10/22.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDCameraOperatorController;

extern NSInteger const ErrorCodeCancel;

typedef void(^CDCameraOperatorCompletion)(CDCameraOperatorController *controller, UIImage *image, NSError *error);

@interface CDCameraOperatorController : UIViewController

@property (nonatomic, copy) CDCameraOperatorCompletion completion;
- (void)handleCompletion:(CDCameraOperatorCompletion)completion;

@end
