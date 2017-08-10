//
//  CDCameraPreviewController.m
//  YDT
//
//  Created by 易愿 on 16/10/21.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDCameraPreviewController.h"
#import "AppDelegate.h"

@interface CDCameraPreviewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) LLSimpleCamera *camera;

@end

@implementation CDCameraPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    // create camera vc
    self.camera = [[LLSimpleCamera alloc] initWithQuality:AVCaptureSessionPresetHigh
                                                 position:LLCameraPositionRear
                                             videoEnabled:NO];
    
    // attach to a view controller
    [self.camera attachToViewController:self withFrame:self.view.bounds];
    // read: http://stackoverflow.com/questions/5427656/ios-uiimagepickercontroller-result-image-orientation-after-upload
    self.camera.fixOrientationAfterCapture = YES;
    self.camera.useDeviceOrientation = YES;
    
    [self.camera setOnError:^(LLSimpleCamera *camera, NSError *error) {
        NSLog(@"Camera error: %@", error);
        
        if([error.domain isEqualToString:LLSimpleCameraErrorDomain]) {
            if(error.code == LLSimpleCameraErrorCodeCameraPermission ||
               error.code == LLSimpleCameraErrorCodeMicrophonePermission) {
            }
        }
    }];
    
    if (self.mode) {
        self.mode.cameraOverlyView.frame = self.view.bounds;
        [self.view addSubview:self.mode.cameraOverlyView];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.mode.cameraOverlyView.frame = self.view.bounds;
    self.camera.view.frame = self.view.bounds;
}

- (void)snapButtonPressed {
    __weak typeof(self) weakSelf = self;
    [self.camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
        if (weakSelf.completion) {
            weakSelf.completion(weakSelf, image, error);
        }
    } exactSeenImage:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.camera start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
