//
//  LDDownloader.h
//  下载管理器
//
//  Created by 陈小双 on 2018/6/16.
//  Copyright © 2018年 陈小双. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDDownloader : NSObject
/**
 *  下载指定url的文件
 *
 *  @param url 要下载的url
 */
-(void)downloadWithURL:(NSURL *)url;
@end
