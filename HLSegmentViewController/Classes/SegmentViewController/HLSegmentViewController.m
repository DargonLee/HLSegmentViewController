//
//  SegmentViewController.m
//  SegmentViewController
//
//  Created by Harlan on 2018/9/14.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import "HLSegmentViewController.h"
#import "UIView+Frame.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface HLSegmentViewController ()<UIScrollViewDelegate,HLSegmentViewDelegate>

@property (nonatomic,weak) UIScrollView *contentScrollView;

@end

@implementation HLSegmentViewController

- (HLSegmentView *)segmentView
{
    if(!_segmentView){
        HLSegmentView *segmentView = [HLSegmentView segmentViewWithFrame:CGRectZero];
        segmentView.delegate = self;
        segmentView.backgroundColor = [UIColor brownColor];
        [self.view addSubview:segmentView];
        self.segmentView = segmentView;
    }
    return _segmentView;
}

- (UIScrollView *)contentScrollView
{
    if(!_contentScrollView){
        UIScrollView *contentScrollView = [[UIScrollView alloc]init];

        contentScrollView.delegate = self;
        contentScrollView.pagingEnabled = YES;
        contentScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:contentScrollView];
        self.contentScrollView = contentScrollView;
    }
    return _contentScrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)setupSegmentItems:(NSArray<NSString *> *)items childViewControllers:(NSArray<UIViewController *> *)childVCs
{
    NSAssert(items.count != 0 || items.count == childVCs.count, @"个数不一致, 请自己检查");
    [self.segmentView setItems:items];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
    }
    self.contentScrollView.contentSize = CGSizeMake(items.count * self.view.width, 0);
    [self.segmentView setSelectIndex:0];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (self.segmentView.superview == self.view) {
        self.segmentView.frame = CGRectMake(0, 60, self.view.width, 35);
        CGFloat contentViewY = self.segmentView.y + self.segmentView.height;
        CGRect contentFrame = CGRectMake(0, contentViewY, self.view.width, self.view.height - contentViewY);
        self.contentScrollView.frame = contentFrame;
        self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
        return;
    }
    CGRect contentFrame = CGRectMake(0, 0,self.view.width,self.view.height);
    self.contentScrollView.frame = contentFrame;
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
}

- (void)showChildVCViewsAtIndex:(NSInteger)index
{
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    UIViewController *vc = self.childViewControllers[index];
    CGFloat offsetX = index * self.contentScrollView.width;
    vc.view.frame = CGRectMake(offsetX, 0, self.contentScrollView.width, self.contentScrollView.height);
    [self.contentScrollView addSubview:vc.view];
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma HLSegmentViewDelegate
- (void)segmentView:(HLSegmentView *)segmentView didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"%ld----%ld", (long)fromIndex, (long)toIndex);
    [self showChildVCViewsAtIndex:toIndex];
}

#pragma UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = self.contentScrollView.contentOffset.x/self.contentScrollView.width;
    self.segmentView.selectIndex = index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

/*
 // 字体缩放 1.缩放比例 2.缩放哪两个按钮
 NSInteger leftIndex = scrollView.contentOffset.x/kScreenW;
 NSInteger rightIndex = leftIndex + 1;
 
 // 获取左边的按钮
 UIButton *leftBtn = self.titleButtons[leftIndex];
 NSInteger count = self.titleButtons.count;
 
 //获取右边的按钮
 UIButton *rightBtn;
 if (rightIndex < count) {
 rightBtn = self.titleButtons[rightIndex];
 }
 
 // 0 ~ 1 =>  1 ~ 1.3
 // 计算缩放比例
 CGFloat scaleR = scrollView.contentOffset.x/kScreenW;
 scaleR -= leftIndex;
 
 //左边缩放比例
 CGFloat scaleL = 1 - scaleR;
 
 // 缩放按钮
 leftBtn.transform = CGAffineTransformMakeScale(scaleL * 0.3 + 1, scaleL * 0.3 + 1);
 rightBtn.transform = CGAffineTransformMakeScale(scaleR * 0.3 + 1, scaleR * 0.3 + 1);
 
 //改变指示器位置
 
 self.indicatorView.transform = CGAffineTransformMakeTranslation(scaleR*rightBtn.bounds.size.width+(leftBtn.center.x-leftBtn.bounds.size.width*0.5), 0);
 
 //颜色渐变
 if (self.titleColor == [UIColor redColor] || self.titleColor == nil) {
 UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
 UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
 [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
 [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
 }
 */

@end
