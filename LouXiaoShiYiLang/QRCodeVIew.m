//
//  QRCodeVIew.m
//  LouXiaoShiYiLang
//
//  Created by lt on 17/2/28.
//  Copyright © 2017年 SaveYourTime. All rights reserved.
//

#import "QRCodeVIew.h"

@interface QRCodeVIew()

@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, strong) CIImage *outputImage;

/**
 *  使用CIFilter滤镜类生成二维码
 */
- (void)generateQRCodeFilter;

/**
 *  对生成的二维码进行加工，使其更清晰
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight;

@end

@implementation QRCodeVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        CGFloat scale = [UIScreen mainScreen].scale;
        CGFloat size = (self.frame.size.width < self.frame.size.height ? self.frame.size.width : self.frame.size.height);
        CGRect rect = CGRectMake(0, 0, size, size);
        self.size = CGRectGetWidth(rect) * scale;
    }
    return self;
}

- (void)showQRCode:(NSString *)info
{
    self.info = info;
    [self generateQRCodeFilter];
    UIImage *image = [self createNonInterpolatedUIImageFormCIImage:self.outputImage withSize:self.size];
    [self setImage:image];
    self.alpha = 0;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1;
    }completion:^(BOOL complete){
        
    }];
}

- (void)generateQRCodeFilter
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [self.info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];              //通过kvo方式给一个字符串，生成二维码
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];      //设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    
    //设置背景颜色和填充颜色 默认白色背景黑色填充
    
    CIColor *color1 = [CIColor colorWithCGColor:[UIColor blackColor].CGColor];
    CIColor *color2 = [CIColor colorWithCGColor:[UIColor whiteColor].CGColor];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: filter.outputImage ,@"inputImage",
                                color1,@"inputColor0",
                                color2,@"inputColor1",nil];
    CIFilter *newFilter = [CIFilter filterWithName:@"CIFalseColor" withInputParameters:parameters];
    
    self.outputImage = [newFilter outputImage];                     //拿到二维码图片
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceRGB颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    return outputImage;
}

//- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight
//{
//    CGRect extentRect = CGRectIntegral(ciImage.extent);
//    CGFloat scale = MIN(widthAndHeight / CGRectGetWidth(extentRect), widthAndHeight / CGRectGetHeight(extentRect));
//    // 1.创建bitmap;
//    size_t width = CGRectGetWidth(extentRect) * scale;
//    size_t height = CGRectGetHeight(extentRect) * scale;
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extentRect];
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    CGContextDrawImage(bitmapRef, extentRect, bitmapImage);
//    // 保存bitmap到图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    CGContextRelease(bitmapRef);
//    CGImageRelease(bitmapImage);
//    UIImage *image = [UIImage imageWithCGImage:scaledImage];
//    return image; // 黑白图片
//}




@end
