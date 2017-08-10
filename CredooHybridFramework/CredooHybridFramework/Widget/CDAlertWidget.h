//
//  CDAlertWidget.h
//  CredooHybridFramework
//
//  Created by 易愿 on 16/11/28.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDBaseWidget.h"
#import "CDAlertDTO.h"

@protocol CDAlertWidgetDelegate <NSObject>

- (void)showAlertWithInfo:(CDAlertDTO *)info;

@end

@class CDAlertWidget;

@interface CDAlertWidget : CDBaseWidget

@property (nonatomic, weak) id <CDAlertWidgetDelegate> delegate;

@end
