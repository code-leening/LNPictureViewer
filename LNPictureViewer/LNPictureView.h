//
//  LNPictureView.h
//  LNPictureViewer
//
//  Created by 百纬健康 on 2017/2/28.
//  Copyright © 2017年 李宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNPictureView : UIView

@property (nonatomic,assign) BOOL isScalePinchGesture;//是否添加放大和缩小手势（默认不添加）
@property (nonatomic,assign) CGFloat viewAlpha;//遮罩层的透明度
@property (nonatomic,strong) NSArray *imageArray;//图片网址数组

-(void)showLNPictureViewAndIndex:(NSInteger)index;//显示第几张图片
-(void)hidenLNPictureView;

@end
