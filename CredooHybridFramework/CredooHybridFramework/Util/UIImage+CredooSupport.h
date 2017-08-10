//
//  UIImage+CredooSupport.h
//  YDT
//
//  Created by 易愿 on 16/9/20.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CredooSupport)

- (UIImage *)imageCompressionWithBytesLimit:(CGFloat)limit;
+(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
- (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage width:(CGFloat)width height:(CGFloat)height;

- (UIImage *)clipImageInRect:(CGRect)rect;
- (UIImage *)fixupOrientation:(UIImageOrientation)orientation;

@end
