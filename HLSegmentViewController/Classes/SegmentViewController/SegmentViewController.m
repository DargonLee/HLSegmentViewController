//
//  SegmentViewController.m
//  SegmentViewController
//
//  Created by Harlan on 2018/9/14.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import "SegmentViewController.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface SegmentViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *titleScrollView;

@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) NSMutableArray *titleButtons;

@property (nonatomic, weak) UIButton *selectButton;

@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, assign) BOOL isInitialize;

@end

@implementation SegmentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isInitialize == NO) {
        // 4.设置所有标题
        [self setupAllTitle];
        
        _isInitialize = YES;
    }
    
}

+ (instancetype)segmentControllerWithAddChildViewControllerBlock:(void(^)(SegmentViewController *))addBlock
{
    SegmentViewController *segmentVC = [[SegmentViewController alloc]init];
    
    if(addBlock){
        addBlock(segmentVC);
    }
    return segmentVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // iOS7以后,导航控制器中scollView顶部会添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma 设置所有标题
- (void)setupAllTitle
{
    // 添加所有标题按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat btnH = self.titleScrollView.bounds.size.height-1;
    CGFloat btnX = 0;
    CGFloat btnW = 80;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        btnX = i * btnW;
        titleButton.frame = CGRectMake(btnX, 0, btnW, btnH);
        if (self.titleColor) {
            [titleButton setTitleColor:self.titleColor forState:UIControlStateNormal];
        }else{
            [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (self.normalFont) {
            titleButton.titleLabel.font = self.normalFont;
        }else{
            titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        
        
        // 监听按钮点击
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 把标题按钮保存到对应的数组
        [self.titleButtons addObject:titleButton];
        
        if (i == 0) {
            [self titleClick:titleButton];
        }
        [self.titleScrollView addSubview:titleButton];
    }
    
    //添加指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.frame = CGRectMake(0, self.titleScrollView.bounds.size.height-3, btnW, 2);
    if (self.titleColor) {
        indicatorView.backgroundColor = self.titleColor;
    }else{
        indicatorView.backgroundColor = [UIColor redColor];
    }
    indicatorView.layer.masksToBounds = YES;
    indicatorView.layer.cornerRadius = 1;
    [self.titleScrollView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 设置标题的滚动范围
    self.titleScrollView.contentSize = CGSizeMake(count*btnW, 0);
    
    // 设置内容的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * kScreenW, 0);
}

#pragma 标题按钮点击方法
- (void)titleClick:(UIButton *)button
{
    NSInteger index = button.tag;
    [self selectedButton:button];
    [self setupViewController:index];
    [self.contentScrollView setContentOffset:CGPointMake(index * kScreenW, 0) animated:YES];
}

- (void)selectedButton:(UIButton *)button
{
    self.selectButton.transform = CGAffineTransformIdentity;
    if (self.titleColor) {
        [self.selectButton setTitleColor:self.titleColor forState:UIControlStateNormal];
    }else{
        [self.selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (self.selectedTitleColor) {
        [button setTitleColor:self.selectedTitleColor forState:UIControlStateNormal];
    }else{
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    // 字体缩放:形变
    [UIView animateWithDuration:0.25 animations:^{
        button.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.indicatorView.transform = CGAffineTransformMakeTranslation(button.tag*button.bounds.size.width, 0);
    }];
    // 标题居中
    [self setupTitleCenter:button];
    self.selectButton = button;
}

- (void)setupTitleCenter:(UIButton *)button
{
    CGFloat offsetX = button.center.x - kScreenW * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - kScreenW;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
#pragma 添加标题滚动视图
- (UIScrollView *)titleScrollView
{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc]init];
        CGFloat y = self.navigationController.navigationBarHidden ? 20 : 64;
        _titleScrollView.frame = CGRectMake(0, y, self.view.bounds.size.width, 46);
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        if (self.titleViewBgColor) {
            _titleScrollView.backgroundColor = self.titleViewBgColor;
        }else{
            _titleScrollView.backgroundColor = [UIColor whiteColor];
        }
        [self.view addSubview:_titleScrollView];
    }
    return _titleScrollView;
}

#pragma 添加内容滚动视图
- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc]init];
        CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
        _contentScrollView.frame = CGRectMake(0,y , self.view.bounds.size.width, self.view.bounds.size.height - y);
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.bounces = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.delegate = self;
        [self.view addSubview:_contentScrollView];
    }
    return _contentScrollView;
}

- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

#pragma mark - UIScrollViewDelegate
// 只要一滚动就需要字体渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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
}


/*
 颜色:3种颜色通道组成 R:红 G:绿 B:蓝
 
 白色: 1 1 1
 黑色: 0 0 0
 红色: 1 0 0
 */

//滚动完成的时候掉用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/kScreenW;
    
    UIButton *titleButton = self.titleButtons[index];
    
    [self selectedButton:titleButton];
    
    [self setupViewController:index];
    
}

- (void)setupViewController:(NSInteger)index
{
    UIViewController *vc = self.childViewControllers[index];
    if (vc.view.superview) {
        return;
    }
    CGFloat x = index * kScreenW;
    vc.view.frame = CGRectMake(x, 0, kScreenW, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
}

@end
