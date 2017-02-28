//
//  QRCodeVIew.h
//  LouXiaoShiYiLang
//
//  Created by lt on 17/2/28.
//  Copyright © 2017年 SaveYourTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeVIew : UIImageView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)showQRCode:(NSString *)info;

@end
