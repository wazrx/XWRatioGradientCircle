//
//  XWRatioGradientCircle.h
//  XWRatioGradientCircle
//
//  Created by 肖文 on 2017/11/1.
//  Copyright © 2017年 NineTonTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWRatioGradientCircle : UIView


/**
 构建一个比例渐变圆，注意：绘制的起点参考点为最高点

 @param radius 圆半径
 @param lineWidth 绘制线宽，默认为8
 @param colors 渐变颜色数组的数组，每一个元素为一个二维color数组，代表渐变的起点和终点
 @param ratios 每一个渐变线段的比例，和上面的colors对应，注意以圆的最高点为起点
 @return 比例渐变圆
 */
+ (XWRatioGradientCircle *)xw_circleWithRadius:(CGFloat)radius
                                    lineWidth:(CGFloat)lineWidth
                               graidentColors:(NSArray<NSArray<UIColor *> *> *)colors
                                       ratios:(NSArray<NSNumber *> *)ratios;

@end
