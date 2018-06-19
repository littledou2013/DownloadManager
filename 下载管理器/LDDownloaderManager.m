//
//  LDDownloaderManager.m
//  下载管理器
//
//  Created by 陈小双 on 2018/6/19.
//  Copyright © 2018年 陈小双. All rights reserved.
//

#import "LDDownloaderManager.h"
#import "LDDownloader.h"
@interface LDDownloaderManager()
/** 下载缓冲池 */
@property (nonatomic, strong) NSMutableDictionary *downloaderCache;



@end

@implementation LDDownloaderManager

- (NSMutableDictionary *)downloaderCache {
    if (!_downloaderCache) {
        _downloaderCache = [NSMutableDictionary dictionary];
    }
    return _downloaderCache;
}

/**
每次实例化一个 HKDownloader 对应一个文件的下载操作!!
如果才操作没有执行完毕,不需要再次开启!
解决思路: 下载缓冲池!
*/
+(instancetype)sharedDownloaderManager {
    static LDDownloaderManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(void)downloadWithURL:(NSURL *)url progress:(void (^)(float progress))progress completion:(void (^)(NSString * filePath))completion failed:(void (^)(NSString * errorMsg))failed {
    if ([self.downloaderCache objectForKey:url.path]) {
        NSLog(@"下载任务已存在");
        return;
    }
    LDDownloader *downloader = [[LDDownloader alloc] init];
    [downloader downloadWithURL:url progress:progress completion:failed failed:failed];
    [self.downloaderCache setObject:downloader forKey:url.path];
}

@end
