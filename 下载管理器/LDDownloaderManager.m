//
//  LDDownloaderManager.m
//  下载管理器
//
//  Created by 陈小双 on 2018/6/19.
//  Copyright © 2018年 陈小双. All rights reserved.
//

#import "LDDownloaderManager.h"
#import "LDDownloader.h"

@implementation LDDownloaderManager
+(instancetype)sharedDownloaderManager {
    static LDDownloaderManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(void)downloadWithURL:(NSURL *)url progress:(void (^)(float progress))progress completion:(void (^)(NSString * filePath))completion failed:(void (^)(NSString * errorMsg))failed {
    LDDownloader *downloader = [[LDDownloader alloc] init];
    [downloader downloadWithURL:url progress:progress completion:failed failed:failed];
}

@end
