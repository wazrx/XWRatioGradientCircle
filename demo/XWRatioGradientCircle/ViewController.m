//
//  ViewController.m
//  XWRatioGradientCircle
//
//  Created by 肖文 on 2017/11/1.
//  Copyright © 2017年 NineTonTech. All rights reserved.
//

#import "ViewController.h"
#import "XWRatioGradientCircle.h"

#ifndef XW_HEX
#define XW_HEX(_hex_)   [UIColor xw_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_)) alpha:1.0f]
#endif
@interface UIColor (XWAdd)
@end

@implementation UIColor (XWAdd)
+ (UIColor *)xw_colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha{
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XWRatioGradientCircle *circle = [XWRatioGradientCircle xw_circleWithRadius:100 lineWidth:10 graidentColors:@[@[XW_HEX(9926B5), XW_HEX(631D9F)], @[XW_HEX(007E9F), XW_HEX(00D8B2)], @[XW_HEX(CA4061), XW_HEX(E17466)], @[XW_HEX(F7B64A), XW_HEX(F8DE5F)]] ratios:@[@0.4, @0.3, @0.12, @0.18]];
    circle.center = self.view.center;
    [self.view addSubview:circle];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
