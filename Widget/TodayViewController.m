//
//  TodayViewController.m
//  Widget
//
//  Created by lt on 17/4/18.
//  Copyright © 2017年 SaveYourTime. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "QRCodeVIew.h"

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, strong) QRCodeVIew *codeView;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.codeView];
    [self reloadCodeView];
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    [self reloadCodeView];
    completionHandler(NCUpdateResultNewData);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    if (activeDisplayMode == NCWidgetDisplayModeCompact)
    {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 105);
        [UIView animateWithDuration:0.3 animations:^{
            
            self.codeView.frame = CGRectMake(self.view.frame.size.width/2 - 50, 2, 100, 100);
        }];
    } else
    {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 205);
        [UIView animateWithDuration:0.3 animations:^{
            self.codeView.frame = CGRectMake(self.view.frame.size.width/2 - 100, 2, 200, 200);
        }];

    }
}

- (void)codeViewClicked:(UITapGestureRecognizer *)tap
{
    [self reloadCodeView];
}

- (void)reloadCodeView
{
    [self.codeView showQRCode:[self getCodeString]];
}

- (NSString *)getCodeString
{
    NSString *phone = @"18027251193";
    NSInteger date = [[NSDate date] timeIntervalSince1970];
    date *= 1000;
    NSString *info = [NSString stringWithFormat:@"8160|%@|%ld|440106B008",phone,date];
    return info;
}

- (QRCodeVIew *)codeView
{
    if (!_codeView)
    {
        CGRect codeViewFrame = CGRectMake(self.view.frame.size.width/2 - 50, 2, 100, 100);
        _codeView = [[QRCodeVIew alloc] initWithFrame:codeViewFrame];
        _codeView.userInteractionEnabled = YES;
        _codeView.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer *codeViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeViewClicked:)];
        [_codeView addGestureRecognizer:codeViewTap];
    }
    return _codeView;
}

@end
