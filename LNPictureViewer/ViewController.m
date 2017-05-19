//
//  ViewController.m
//  LNPictureViewer
//
//  Created by 百纬健康 on 2017/2/28.
//  Copyright © 2017年 李宁. All rights reserved.
//

#import "ViewController.h"
#import "LNPictureView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeCustom];
    butn.frame = CGRectMake(100, 100, 180, 60);
    butn.layer.borderWidth = 1.0;
    butn.backgroundColor = [UIColor purpleColor];
    [butn setTitle:@"点击浏览图片" forState:0];
    [butn addTarget:self action:@selector(clickButn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butn];
    
    
}

-(void)clickButn
{
    NSArray *imageArray = @[@"http://ww3.sinaimg.cn/large/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg",
                            @"http://ww1.sinaimg.cn/large/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg",
                            @"http://ww1.sinaimg.cn/large/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"];
    LNPictureView *pictureView = [[LNPictureView alloc] init];
    pictureView.isScalePinchGesture = YES;//添加放大、缩小手势，默认不添加该手势
    pictureView.viewAlpha = 1;//背景透明度
    pictureView.imageArray = imageArray;
    [pictureView showLNPictureViewAndIndex:1];//显示第几张图片
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
