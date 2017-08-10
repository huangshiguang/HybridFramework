//
//  CDCameraWidget.m
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/18.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDCameraWidget.h"
#import "CDCustomCameraController.h"
#import "CDCustomCameraMode.h"
#import "CDCameraStyleDTO.h"
#import "CDCameraButtonStyle.h"
#import <NSObject+YYModel.h>
#import <ReactiveCocoa.h>
#import "CDFileDTO.h"
#import <NSDate+YYAdd.h>

@interface CDCameraWidget ()

@property (nonatomic, strong) CDCameraStyleDTO *cameraStyle;
@property (nonatomic, strong) CDCustomCameraController *cameraController;

@property (nonatomic, weak) UIButton *confirmButton;
@property (nonatomic, weak) UIButton *snapButton;

@property (nonatomic, strong) UIImage *imagePrepareToUse;

@end

@implementation CDCameraWidget

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.widgetName = @"/widget/camera";
    }
    return self;
}

- (void)finished {
    self.cameraController = nil;
    self.cameraStyle = nil;
}

- (void)prepareWithDictionary:(NSDictionary *)dic {
    [super prepareWithDictionary:dic];
    
    self.cameraStyle = [CDCameraStyleDTO modelWithDictionary:dic];
}

- (void)performWithController:(RXRViewController *)controller {
//    CDCameraStyleDTO *style = self.cameraStyle;
//    
//    
//    for (CDCameraStyleDTO *dto in style.buttons) {
//        
//    }
//    {
//        backgroundImage = "base64" // base64
//        Components = (
//           {
//               type ="normalbutton|imagebutton"
//               x = 1.0
//               y = 1.0
//               widht = 1.0
//               height = 1.0
//               title = "title"
//               image = "base64"
//               titleColor = "ffffff" // 十六进制
//               actionType = "cancelAc|takePhotoButton|sysUsePhotoButton|customAction"
//               action = "functionOne"
//           },
//           {
//               x = 1.0
//               y = 1.0
//               widht = 1.0
//               height = 1.0
//               title = "title"
//               titleColor = "ffffff" // 十六进制
//               action = "functionTwo"
//           }
//        )
//    }
    
    CDCameraStyleDTO *style = self.cameraStyle;
    
    __block CDCameraOverlyView *overlyView = [[CDCameraOverlyView alloc] init];
    RAC(overlyView.backgroundImageView, image) = RACObserve(self, imagePrepareToUse);
    
    
    CDCustomCameraMode *mode = [[CDCustomCameraMode alloc] init];
    mode.cameraOverlyView = overlyView;
    
    self.cameraController = [[CDCustomCameraController alloc] initWithMode:mode];
    
    for (CDCameraButtonStyle *buttonStyle in style.components) {
        __block UIButton *button;
        if ([buttonStyle.type isEqualToString:@"normalbutton"]) {
            button = [buttonStyle generateButtonWithType:UIButtonTypeSystem];
        } else {
            button = [buttonStyle generateButtonWithType:UIButtonTypeCustom];
        }
    
        @weakify(self);
        /// 拍照
        if ([buttonStyle.actionType isEqualToString:@"takePhoto"]) {
            self.snapButton = button;
            if (!buttonStyle.image) {
                
                // 没有照片使用本地默认文件
                NSString *path = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
                UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:path] pathForResource:@"takePhoto@2x" ofType:@"png"]];
                [button setImage:image forState:UIControlStateNormal];
                buttonStyle.image = image;
            }
            button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIButton *input) {
                @strongify(self);
                if (input.selected) {
                    // 删除图片，重新拍摄
                    self.imagePrepareToUse = nil;
                } else {
                    // 拍摄照片，并显示图片
                    [self.cameraController takePhoto:^(CDCustomCameraController *cameraVC, UIImage *image, NSError *error) {
                        @strongify(self);
                        self.imagePrepareToUse = image;
                    }];
                }
                
                input.selected = !input.selected;
                return [RACSignal empty];
            }];
        }
        /// 取消拍照
        else if ([buttonStyle.actionType isEqualToString:@"cancel"]) {
            button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                [self.cameraController dismissViewControllerAnimated:NO completion:^{
                    @strongify(self);
                    [self finished];
                }];
                return [RACSignal empty];
            }];
        }
        /// 确定使用照片
        else if ([buttonStyle.actionType isEqualToString:@"confirm"]) {
            RAC(button, hidden) = [RACObserve(self, imagePrepareToUse) map:^id(id value) {
                return @(value == nil);
            }];
            button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                UIImage *image = overlyView.backgroundImageView.image;
                
                if (image) {
                    CDFileDTO *file = [[CDFileDTO alloc] init];
                    file.directory = @"images";
                    file.fileName = [NSString stringWithFormat:@"photo_%@", [[NSDate date] stringWithFormat:@"yyyyMMddHHmmSS"]];
                    file.fileData = UIImagePNGRepresentation(image);
                    
                    NSString *js;
                    NSError *error;
                    if ([file saveFileOrReplaceIfExsitsError:&error]) {
                        js = [NSString stringWithFormat:@"%@(%@)", buttonStyle.action, [self actionParamsJsonWithCode:0 message:@"success" data:@{@"image" : [file relativePath]}]];
                    } else {
                        js = [NSString stringWithFormat:@"%@(%@)", buttonStyle.action, [self actionParamsJsonWithCode:-1 message:@"failed" data:nil]];
                    }
                    NSLog(@"%@", js);
                    
                    [controller.webView stringByEvaluatingJavaScriptFromString:js];
                    [self.cameraController dismissViewControllerAnimated:NO completion:^{
                        @strongify(self);
                        [self finished];
                    }];
                }
                return [RACSignal empty];
            }];
        }
        /// 自定义
        else if ([buttonStyle.actionType isEqualToString:@"custom"]) {
            button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                NSString *js = [NSString stringWithFormat:@"%@(%@)", buttonStyle.action, [self actionParamsJsonWithCode:0 message:@"success" data:@{}]];
                [controller.webView stringByEvaluatingJavaScriptFromString:js];
                return [RACSignal empty];
            }];
        }
        
        [overlyView addSubview:button];
    }
    
    [controller presentViewController:self.cameraController animated:NO completion:nil];
}

@end
