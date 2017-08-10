//
//  CDFileDTO.h
//  RexxarDemo
//
//  Created by 易愿 on 16/11/15.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDBaseDTO.h"

#define kDirectoryImages @"images"

@interface CDFileDTO : CDBaseDTO

@property (nonatomic, assign) NSSearchPathDirectory directoryType;
@property (nonatomic, copy) NSString *directory;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, strong) NSData *fileData;

- (NSData *)getFileError:(NSError **)error;
- (BOOL)saveFileOrReplaceIfExsitsError:(NSError **)error;
- (BOOL)removeFileError:(NSError **)error;

- (NSString *)relativePath;

@end
