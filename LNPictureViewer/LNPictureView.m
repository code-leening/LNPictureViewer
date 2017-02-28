//
//  LNPictureView.m
//  LNPictureViewer
//
//  Created by 百纬健康 on 2017/2/28.
//  Copyright © 2017年 李宁. All rights reserved.
//

#import "LNPictureView.h"
#import "UIImageView+WebCache.h"
#import "LNCircleProgressView.h"

#define LNScreenHeigth [UIScreen mainScreen].bounds.size.height
#define LNScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LNPictureView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) LNCircleProgressView *progressView;
@property (nonatomic,strong) NSMutableArray *imageViewArr;

@end

@implementation LNPictureView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI
{
    self.backgroundColor = [UIColor blackColor];
    self.userInteractionEnabled = YES;
    
    self.frame = [UIScreen mainScreen].bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenLNPictureView)];
    [self addGestureRecognizer:tap];
    
    _imageViewArr = [NSMutableArray array];
    
    
}

-(void)setViewAlpha:(CGFloat)viewAlpha
{
    self.alpha = viewAlpha;
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    [self creatImageView];
}

-(void)creatImageView
{
    for (int i = 0; i < _imageArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(LNScreenWidth*i, 0, LNScreenWidth, LNScreenWidth*1.5);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
        [_imageViewArr addObject:imageView];
    }
}

-(void)showLNPictureViewAndIndex:(NSInteger)index
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self addSubview:self.progressView];
    
    //先加载第一张图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(LNScreenWidth*index, 0, LNScreenWidth, LNScreenWidth*1.5);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[index]] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [_progressView setHidden:NO];
        CGFloat x = receivedSize/1.0;
        _progressView.progressValue = receivedSize/expectedSize;
        NSLog(@"第0张*****总大小：%ld  已下载：%ld===下载百分比：%f",expectedSize,receivedSize,x/expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            [_progressView setHidden:YES];
        }
    }];
    _pageControl.currentPage = index;
    [_scrollView setContentOffset:CGPointMake(LNScreenWidth*index, 0) animated:NO];
    [_scrollView addSubview:imageView];
    [self addSubview:self.progressView];
}

-(void)hidenLNPictureView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UIScroolViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/LNScreenWidth;
    _pageControl.currentPage = index;
    
    
    UIImageView *imageV = (UIImageView *)_imageViewArr[index];
    [imageV sd_setImageWithURL:[NSURL URLWithString:_imageArray[index]] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [_progressView setHidden:NO];
        CGFloat x = receivedSize/1.0;
        _progressView.progressValue = receivedSize/expectedSize;
        NSLog(@"第%ld张*****总大小：%ld  已下载：%ld===下载百分比：%f",index,expectedSize,receivedSize,x/expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            [_progressView setHidden:YES];
        }
    }];
    
}



-(LNCircleProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [LNCircleProgressView viewWithFrame:CGRectMake(80, 200, 100, 100)
                                                circlesSize:CGRectMake(34, 2, 30, 30)];
        _progressView.layer.cornerRadius = 10;
        _progressView.center = self.center;
        
        //阴影
        _progressView.backgroundColor = [UIColor clearColor];
        _progressView.backCircle.shadowColor = [UIColor grayColor].CGColor;
        _progressView.backCircle.shadowRadius = 3;
        _progressView.backCircle.shadowOffset = CGSizeMake(0, 0);
        _progressView.backCircle.shadowOpacity = 1;
        _progressView.backCircle.fillColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:0.8].CGColor;
        _progressView.backCircle.strokeColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1].CGColor;
        
        _progressView.foreCircle.lineCap = @"butt";
        _progressView.foreCircle.strokeColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1].CGColor;;
        _progressView.progressValue = 0.2;
    }
    return _progressView;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, LNScreenWidth, LNScreenWidth*1.5);
        _scrollView.center = self.center;
        //_scrollView.backgroundColor = self.backgroundColor;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(LNScreenWidth*_imageArray.count, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, 0, LNScreenWidth, 10);
        _pageControl.center = CGPointMake(LNScreenWidth/2, LNScreenHeigth-60);
        _pageControl.numberOfPages = self.imageArray.count;
    }
    
    return _pageControl;
}

@end
