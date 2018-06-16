//
//  LDDownloader.m
//  下载管理器
//
//  Created by 陈小双 on 2018/6/16.
//  Copyright © 2018年 陈小双. All rights reserved.
//
/**
 目的 --> 下载
 1. 先实现一个简单的下载功能!!
 2. 对外提供接口!
 
 */

#define kTimeOut 20.0
#import "LDDownloader.h"
@interface LDDownloader ()
/** 网络文件总大小 */
@property(assign,nonatomic)long long  expectedContentLength;
/** 本地文件总大小 */
@property(assign,nonatomic)long long currentLength;
/** 文件路径 */
@property(copy,nonatomic)NSString * filePath;
/** 下载文件的URL  */
@property(nonatomic,strong)NSURL * downloadURL;
@end
/**
 NSURLSession下载
 1.跟踪进度
 2.断点续传,问题:这个resumeData丢失,再次下载的时候,无法续传!!
 考虑解决方案:
 - 将文件保存在固定的位置
 - 再次下载文件前,先检查固定位置是否存在文件
 - 如果有,直接续传!!!
 
 */
@implementation LDDownloader
//这个方法给外界提供的.内部不要写"碎代码"
-(void)downloadWithURL:(NSURL *)url
{
    //0.保存URL
    self.downloadURL = url;
    
    //1.检查服务器上的文件大小!
    [self serverFileInfoWithURL:url];
    
    NSLog(@"%lld  %@",self.expectedContentLength,self.filePath);

}

#pragma mark - <私有方法>
//检查服务器文件大小
-(void)serverFileInfoWithURL:(NSURL *)url{
    //1.请求
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:kTimeOut];
    request.HTTPMethod = @"HEAD";
    //2.建立网络连接
    NSURLResponse * response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    //3.记录服务器的文件信息
    //3.1 文件长度
    self.expectedContentLength = response.expectedContentLength;
    //3.2 建议保存的文件名,将在的文件保存在tmp ,系统会自动回收
    self.filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:response.suggestedFilename];
    return;
}

@end
