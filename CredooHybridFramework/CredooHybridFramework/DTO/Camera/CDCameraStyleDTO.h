//
//  CDCameraStyleDTO.h
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/21.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDBaseDTO.h"
#import <UIKit/UIKit.h>
#import "CDCameraButtonStyle.h"

@interface CDCameraStyleDTO : CDBaseDTO

@property (nonatomic, assign) UIInterfaceOrientation orientation;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, copy) NSArray <CDCameraButtonStyle*> *components;

@end

