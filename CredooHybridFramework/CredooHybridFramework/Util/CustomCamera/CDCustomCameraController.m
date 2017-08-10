//
//  CDCustomCameraController.m
//  YDT
//
//  Created by Taurus on 16/10/22.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDCustomCameraController.h"
#import "CDCameraPreviewController.h"
#import "UIImage+CredooSupport.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"

@interface CDCustomCameraController ()

@property (nonatomic, strong) CDCameraPreviewController *previewController;

@property (nonatomic, assign) UIInterfaceOrientationMask oldOrientationMask;
@property (nonatomic, assign) UIDeviceOrientation oldOrientation;

@end

@implementation CDCustomCameraController
@synthesize previewController = _previewController;

- (instancetype)initWithMode:(CDCustomCameraMode *)mode {
    CDCameraPreviewController *vc = [[CDCameraPreviewController alloc] init];
    if (self = [super initWithRootViewController:vc]) {
        self.mode = mode;

        self.previewController = vc;
        self.previewController.mode = mode;
    }
    return self;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self checkUpVideoEnable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.mode.orientation != UIInterfaceOrientationUnknown) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.oldOrientation = [UIDevice currentDevice].orientation;
        self.oldOrientationMask = delegate.customOrientationMask;
        [delegate setCustomOrientationMask:(1 << self.mode.orientation)];
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            SEL selector = NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val = UIInterfaceOrientationLandscapeLeft;
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.mode.orientation != UIInterfaceOrientationUnknown) {
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] setCustomOrientationMask:self.oldOrientationMask];
            SEL selector = NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val = self.oldOrientation;
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }
    }
}

- (void)checkUpVideoEnable {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (!granted) {
            // 相机未授权
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [[UIAlertController alloc] init];
                alert.message = @"请在iPhone的“设置-隐私-相机”选项中，允许安银通访问你的相机";
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                
            });
        }
    }];
}

- (void)setPreviewController:(CDCameraPreviewController *)previewController {
    if (_previewController != previewController) {
        _previewController.completion = nil;
        _previewController = previewController;
    }
}

- (UIImage *)compressImage:(UIImage *)image mode:(CDCustomCameraMode *)mode {
    if (image) {
        CGFloat scale = image.size.width / self.view.frame.size.width;
        CGRect resultRect = [mode.cameraOverlyView resultImageRectWithScale:scale];
        
        image = [image clipImageInRect:resultRect];
        image = [UIImage imageCompressForWidth:image targetWidth:500];
        
        return image;
    }
    return nil;
}

- (void)handleCompletion:(CDCameraCompletion)completion {
    self.completion = completion;
}

- (void)takePhoto:(CDCameraCompletion)completion {
    __weak typeof(self) weakSelf = self;
    [self.previewController.camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
        if (completion) {
            __strong typeof(weakSelf) self = weakSelf;
            completion(self, image, error);
        }
    } exactSeenImage:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
