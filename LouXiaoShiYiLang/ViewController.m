//
//  ViewController.m
//  LouXiaoShiYiLang
//
//  Created by lt on 17/2/28.
//  Copyright © 2017年 SaveYourTime. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeVIew.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic, strong) QRCodeVIew *codeView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.codeView];
    [self.codeView showQRCode:[self getCodeString]];
    
    UITapGestureRecognizer *codeViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeViewTapped:)];
    codeViewTap.cancelsTouchesInView = NO;
    [self.codeView addGestureRecognizer:codeViewTap];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (NSString *)getCodeString
{
    NSString *phone = @"18027251193";
    NSInteger date = [[NSDate date] timeIntervalSince1970];
    date *= 1000;
    NSString *info = [NSString stringWithFormat:@"8160|%@|%ld|440106B008",phone,date];
    return info;
}

- (void)codeViewTapped:(UITapGestureRecognizer *)tap
{
    [self.codeView showQRCode:[self getCodeString]];
}


#pragma mark - get

- (QRCodeVIew *)codeView
{
    if (!_codeView)
    {
        CGRect codeViewFrame = CGRectMake(0, 100, 200, 200);
        _codeView = [[QRCodeVIew alloc] initWithFrame:codeViewFrame];
        _codeView.center = self.view.center;
        _codeView.userInteractionEnabled = YES;
    }
    return _codeView;
}
@end
