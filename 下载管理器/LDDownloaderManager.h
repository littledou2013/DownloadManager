//
//  LDDownloaderManager.h
//  下载管理器
//
//  Created by 陈小双 on 2018/6/19.
//  Copyright © 2018年 陈小双. All rights reserved.
// 负责管理所有下载任务 -- 单例

#import <Foundation/Foundation.h>

@interface LDDownloaderManager : NSObject
+(instancetype)sharedDownloaderManager;

/**
 *  下载指定url的文件
 *  需要扩展:通知调用者下载的相关信息
 *  1.进度,通知百分比
 *  2.是否完成,通知下载保存的路径
 *  3.错误,通知错误信息
 
 *  代理 / block
 *  @param url 要下载的url
 */
-(void)downloadWithURL:(NSURL *)url progress:(void (^)(float progress))progress completion:(void (^)(NSString * filePath))completion failed:(void (^)(NSString * errorMsg))failed;

/**
 *  暂停下载
 */
-(void)pauseWithURL:(NSURL *)url;

@end
