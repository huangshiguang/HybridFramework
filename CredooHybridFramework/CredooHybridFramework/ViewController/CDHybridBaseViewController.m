//
//  CDHybridBaseViewController.m
//  CredooHybridFramework
//
//  Created by 徐佳良 on 2016/11/19.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDHybridBaseViewController.h"
#import "CDSaveFileContainerAPI.h"
#import "CDRemoveFileContainerAPI.h"
#import "CDGetFileContainerAPI.h"
#import "CDSetHomePageContainerAPI.h"
#import "AddressBookContainerAPI.h"
#import "CDGetHomePageContainerAPI.h"
#import "CDLoggerContainerAPI.h"

#import "CDCameraWidget.h"
#import "CDAlertWidget.h"

@interface CDHybridBaseViewController ()
@end

@implementation CDHybridBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CDCameraWidget *camera = [[CDCameraWidget alloc] init];
    CDAlertWidget *alert = [[CDAlertWidget alloc] init];
    alert.delegate = self;
    self.widgets = @[camera, alert];
    
    //改变请求
    //    NSDictionary *headers = @{@"Customer-Authorization": @"Bearer token"};
    //    NSDictionary *parameters = @{@"apikey": @"apikey value"};
    //    RXRRequestDecorator *requestDecorator = [[RXRRequestDecorator alloc] initWithHeaders:headers parameters:parameters];
    //    [RXRRequestInterceptor setDecorators:@[(RXRRequestDecorator *)requestDecorator]];
    //    [NSURLProtocol registerClass:[RXRRequestInterceptor class]];
    //    [RXRRequestInterceptor registerInterceptor];
}

-(void)dealloc{
//    [RXRRequestInterceptor unregisterInterceptor];
//    [RXRContainerInterceptor unregisterInterceptor];
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
