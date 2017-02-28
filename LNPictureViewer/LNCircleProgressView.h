//
//  LNCircleProgressView.h
//  LNPictureViewer
//
//  Created by 百纬健康 on 2017/2/28.
//  Copyright © 2017年 李宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNCircleProgressView : UIView

@property (nonatomic, assign) CGFloat progressValue;// 范围: 0 ~ 1

//背景圆环
@property (nonatomic, strong) CAShapeLayer *backCircle;
//前面圆环
@property (nonatomic, strong) CAShapeLayer *foreCircle;

//初始化方法
//size = CGRectMake(背景圆环半径, 背景圆环线宽, 前面圆环半径, 后面圆环线宽)
+ (instancetype)viewWithFrame:(CGRect)frame circlesSize:(CGRect)size;

@end
