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
    [self.downloaderCache setObject:downloader forKey:url.path];
    
    //传递block的参数
    /**
     下载完成之后清除下载操作
     
     问题:下载完成是异步的回调
     
     */
    [downloader downloadWithURL:url progress:progress completion:^(NSString *filePath){
        //1.从下载缓冲池中删除下载操作!
        [self.downloaderCache removeObjectForKey:url.path];
        //2.执行调用方传递的 Block
        if (completion) {
            completion(filePath);
        }
    } failed:^(NSString *errorMsg) {
        //1.从下载缓冲池中删除下载操作!
        [self.downloaderCache removeObjectForKey:url.path];
        if (failed) {
            failed(errorMsg);
        }
    }];
}

@end
