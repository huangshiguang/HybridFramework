//
//  CDCameraButtonStyle.h
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/21.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDButtonStyle.h"

@interface CDCameraButtonStyle : CDButtonStyle

/**
 ActionType
 
 custom    : 调用Action
 cancel    : 取消拍摄并调用Action
 
 takePhoto : 拍摄并调用Action
    >>> data: { image : base64 }
*/
@property (nonatomic, copy) NSString *actionType;

@end
