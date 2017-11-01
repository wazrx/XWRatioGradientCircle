//
//  XWRatioGradientCircle.m
//  XWRatioGradientCircle
//
//  Created by 肖文 on 2017/11/1.
//  Copyright © 2017年 NineTonTech. All rights reserved.
//

#import "XWRatioGradientCircle.h"

@implementation XWRatioGradientCircle{
    NSArray<NSArray<UIColor *> *> *_colors;
    NSArray<NSNumber *> *_ratios;
    CGFloat _lineWidth;
    CGFloat _radius;
}

#pragma mark - Initialize Methods

+ (XWRatioGradientCircle *)xw_circleWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth graidentColors:(NSArray<NSArray<UIColor *> *> *)colors ratios:(NSArray<NSNumber *> *)ratios{
    if (radius <= 0 || !ratios.count|| !colors.count || colors.count != ratios.count) {
        return nil;
    }
    XWRatioGradientCircle *circle = [XWRatioGradientCircle new];
    circle.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
    circle->_colors = colors;
    circle->_ratios = ratios;
    circle->_lineWidth = lineWidth ?: 4;
    circle->_radius = radius;
    [circle _xw_initailizeUI];
    return circle;
}

- (void)_xw_initailizeUI{
    __block CGPoint lastEndPoints = CGPointMake(0.5, 0);
    __block CGFloat totalRatio = 0;
    __block CGFloat startAngle = -M_PI / 2.0f;
    [_colors enumerateObjectsUsingBlock:^(NSArray<UIColor *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        totalRatio += _ratios[idx].floatValue;
        CALayer *layer = ({
            CAGradientLayer *layer = [CAGradientLayer new];
            layer.frame = self.bounds;
            layer.colors = @[(id)obj.firstObject.CGColor, (id)obj.lastObject.CGColor];
            layer.startPoint = lastEndPoints;
            layer.endPoint = ({
                CGFloat angles = (90 - 360 * totalRatio) * M_PI / 180.0f;
                CGFloat yRatio = -sin(angles) / 2.0f + 0.5;
                CGFloat xRatio = 0.5 + cos(angles) / 2.0f;
                lastEndPoints = CGPointMake(xRatio, yRatio);
                lastEndPoints;
            });
            layer.mask = ({
                CAShapeLayer *mask = [CAShapeLayer new];
                mask.fillColor = [UIColor clearColor].CGColor;
                mask.strokeColor = [UIColor redColor].CGColor;
                mask.lineWidth = _lineWidth;
                CGFloat endAngle = totalRatio * 360 * M_PI / 180.0f - M_PI / 2.0f;
                mask.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_radius, _radius) radius:(_radius - _lineWidth * 2) startAngle:startAngle endAngle:endAngle clockwise:YES].CGPath;
                mask.lineCap = kCALineCapRound;
                startAngle = endAngle;
                mask;
            });
            layer;
        });
        [self.layer addSublayer:layer];
    }];
}
@end
