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
{
    CAShapeLayer * _progresslayer;
    LDDownloader *_downloader;
}
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _progresslayer = [CAShapeLayer layer];
    [_progresslayer setFrame:self.progressView.bounds];
    _progresslayer.path = [UIBezierPath bezierPathWithOvalInRect:self.progressView.bounds].CGPath;
    _progresslayer.strokeColor = [UIColor orangeColor].CGColor;
    _progresslayer.fillColor = [UIColor clearColor].CGColor;
    _progresslayer.lineWidth = 10;
    _progresslayer.strokeStart = 0;
    _progresslayer.strokeEnd = 0;
    [self.progressView.layer addSublayer:_progresslayer];
}
- (IBAction)start:(id)sender {
    _downloader = [[LDDownloader alloc]init];
    [_downloader downloadWithURL:[NSURL URLWithString:@"https://dldir1.qq.com/qqfile/QQforMac/QQ_V6.4.0.dmg"] progress:^(float progress) {
        NSLog(@"progress : %f", progress);
        dispatch_async(dispatch_get_main_queue(), ^{
            _progresslayer.strokeEnd = progress;
            self.progressLabel.text = [NSString stringWithFormat:@"%%%d", (int)(progress * 100)];
        });
    } completion:^(NSString *filePath) {
        NSLog(@"filePath : %@", filePath);
        _progresslayer.strokeEnd = 1;
         self.progressLabel.text = @"%100";
    } failed:^(NSString *errorMsg) {
        NSLog(@"errorMsg : %@", errorMsg);
    }];
}
- (IBAction)pause:(id)sender {
    [_downloader pause];
}


@end
