//
//  CDFileDTO.m
//  RexxarDemo
//
//  Created by 易愿 on 16/11/15.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "CDFileDTO.h"

#define IsValiedString(STRING) [STRING isKindOfClass:[NSString class]]

@implementation CDFileDTO

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.directoryType = NSDocumentDirectory;
    }
    return self;
}

- (NSString *)relativePath {
    return [NSString stringWithFormat:@"%@%@", self.directory, self.fileName];
}

- (NSString *)absoluteDirectory {
    if (IsValiedString(self.directory)) {
        NSString *directory = [NSSearchPathForDirectoriesInDomains(self.directoryType, NSUserDomainMask, YES) firstObject];
        directory = [directory stringByAppendingPathComponent:self.directory];
        return directory;
    }
    return nil;
}

- (NSData *)getFileError:(NSError *__autoreleasing *)error {
    if (IsValiedString(self.directory) && IsValiedString(self.fileName)) {
        NSString *directory = [self absoluteDirectory];
        NSData *data = [[NSData alloc] initWithContentsOfFile:[directory stringByAppendingPathComponent:self.fileName]];
        if (!data && error) {
            NSString *domain = [NSString stringWithFormat:@"Not found the file at path %@", [self.directory stringByAppendingPathComponent:self.fileName]];
            *error = [NSError errorWithDomain:domain code:-1 userInfo:nil];
        }
        return data;
    }
    
    if (error) {
        NSString *domain = [NSString stringWithFormat:@"valied directory or filename : {\n\tdirectory = %@\n\tfilename = %@\n}", self.directory, self.fileName];
        *error = [NSError errorWithDomain:domain code:-1 userInfo:nil];
    }
    return nil;
}

- (BOOL)saveFileOrReplaceIfExsitsError:(NSError *__autoreleasing *)error {
    
    if (IsValiedString(self.directory) &&
        IsValiedString(self.fileName) &&
        self.fileData)
    {
        NSFileManager *manager = [NSFileManager defaultManager];
        // 拼接完整目录
        NSString *directory = [NSSearchPathForDirectoriesInDomains(self.directoryType, NSUserDomainMask, YES) firstObject];
        directory = [directory stringByAppendingPathComponent:self.directory];
        
        // 检查是否存在文件夹，不存在则创建文件夹
        if (![manager fileExistsAtPath:directory]) {
            BOOL result = [manager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:error];
            if (!result) {
                return result;
            } else {
                return [NSError errorWithDomain:@"create directory failed" code:-1 userInfo:nil];
            }
        }
        
        // 创建文件于完整路径
        NSString *filePath = [directory stringByAppendingPathComponent:self.fileName];
        BOOL result = [manager createFileAtPath:filePath contents:self.fileData attributes:nil];
        if (!result && error) {
            *error = [NSError errorWithDomain:@"save image to disk failed" code:-1 userInfo:nil];
        }
        return result;
        
    }
    
    if (error) {
        *error = [NSError errorWithDomain:[self invalidParamDomainWithParamsValues] code:-1 userInfo:nil];
    }
    
    return NO;
}

- (BOOL)removeFileError:(NSError *__autoreleasing *)error {
    if (IsValiedString(self.directory) &&
        IsValiedString(self.fileName)) {
        NSString *directory = [NSSearchPathForDirectoriesInDomains(self.directoryType, NSUserDomainMask, YES) firstObject];
        directory = [directory stringByAppendingPathComponent:self.directory];
        NSString *filePath = [directory stringByAppendingPathComponent:self.fileName];
        
        return [[NSFileManager defaultManager] removeItemAtPath:filePath error:error];
    }
    
    if (error) {
        *error = [NSError errorWithDomain:[self invalidParamDomainWithParamsValues] code:-1 userInfo:nil];
    }
    return NO;
}

- (NSString *)invalidParamDomainWithParamsValues {
    return [NSString stringWithFormat:@"invalid params : {\n\tdirectory = %@\n\tfilename = %@\n}", self.directory, self.fileName];
}

@end
