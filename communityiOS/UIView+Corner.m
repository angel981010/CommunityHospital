//
//  UIView+Corner.m
//  communityiOS
//
//  Created by tjufe on 16/7/17.
//  Copyright © 2016年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

-(void)cornerWithCornerRadio:(CGSize)radio rectCorner:(UIRectCorner)corner
{
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //    CGSize radio = CGSizeMake(5, 5);//圆角尺寸
    //    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerBottomLeft;//这只圆角位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = self.bounds;
    masklayer.path = path.CGPath;//设置路径
    self.layer.mask = masklayer;
}

@end
