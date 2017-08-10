//
//  CDAlertDTO.h
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/28.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDBaseDTO.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDAlertDTO : CDBaseDTO

@property (nonatomic, nullable, copy) NSString *title;
@property (nonatomic, nullable, copy) NSString *content;

@property (nonatomic, nullable, copy) NSString *cancelActionTitle;
@property (nonatomic, nullable, copy) NSString *confirmActionTitle;

@property (nonatomic, nullable, copy) NSString *cancelAction;
@property (nonatomic, nullable, copy) NSString *confirmAction;

@end

NS_ASSUME_NONNULL_END
