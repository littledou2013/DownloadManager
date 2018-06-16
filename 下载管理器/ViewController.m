//
//  ViewController.m
//  下载管理器
//
//  Created by 陈小双 on 2018/6/16.
//  Copyright © 2018年 陈小双. All rights reserved.
//

#import "ViewController.h"
#import "LDDownloader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LDDownloader * downloader = [[LDDownloader alloc]init];
    [downloader downloadWithURL:[NSURL URLWithString:@"https://dldir1.qq.com/qqfile/QQforMac/QQ_V6.4.0.dmg"] progress:^(float progress) {
        NSLog(@"progress : %f", progress);
    } completion:^(NSString *filePath) {
        NSLog(@"filePath : %@", filePath);
    } failed:^(NSString *errorMsg) {
        NSLog(@"errorMsg : %@", errorMsg);
    }];
}


@end
