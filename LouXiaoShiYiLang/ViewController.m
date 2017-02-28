//
//  ViewController.m
//  LouXiaoShiYiLang
//
//  Created by lt on 17/2/28.
//  Copyright © 2017年 SaveYourTime. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeVIew.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *phoneField;

@property (nonatomic, strong) QRCodeVIew *codeView;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.confirmBtn];
    [self.view addSubview:self.codeView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)confirmBtnClicked
{
    NSString *phone = self.phoneField.text;
    NSInteger date = [[NSDate date] timeIntervalSince1970];
    date *= 1000;
    NSString *info = [NSString stringWithFormat:@"8002%@%ld400106B008",phone,date];
    NSLog(@"%@",info);
    [self.codeView showQRCode:info];
}

#pragma mark -lazy
- (UITextField *)phoneField
{
    if (!_phoneField)
    {
        CGRect frame = CGRectMake((self.view.frame.size.width - 150 - 75) / 2, (self.view.frame.size.height / 2) - 160, 150, 40);
        _phoneField = [[UITextField alloc] initWithFrame:frame];
        _phoneField.borderStyle = UITextBorderStyleRoundedRect;
        _phoneField.layer.cornerRadius = 10;
        _phoneField.font = [UIFont systemFontOfSize:13];
        
    }
    return _phoneField;

}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn)
    {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(self.phoneField.frame.size.width + self.phoneField.frame.origin.x+15, self.phoneField.frame.origin.y, 60, 40);
        _confirmBtn.layer.cornerRadius = 10;
        [_confirmBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
        [_confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        _confirmBtn.backgroundColor = [UIColor redColor];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (QRCodeVIew *)codeView
{
    if (!_codeView)
    {
        CGRect codeViewFrame = CGRectMake(0, 100, 200, 200);
        _codeView = [[QRCodeVIew alloc] initWithFrame:codeViewFrame];
        _codeView.center = self.view.center;
    }
    return _codeView;

}


@end
