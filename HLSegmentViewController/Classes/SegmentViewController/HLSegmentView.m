//
//  HLSegmentView.m
//  SegmentViewController
//
//  Created by Harlan on 2018/9/15.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import "HLSegmentView.h"
#import "UIView+Frame.h"

#define kMinMargin 30

@interface HLSegmentView()

@property (nonatomic,weak) UIScrollView *contentScrollView;

@property (nonatomic,strong) UIButton *selectedButton;

@end

@implementation HLSegmentView

- (HLSegmentViewConfig *)config
{
    if (!_config) {
        _config = [HLSegmentViewConfig defaultConfig];
    }
    return _config;
}

- (NSMutableArray<UIButton *> *)itemButtons
{
    if(!_itemButtons){
        
        _itemButtons = [NSMutableArray array];
    }
    return _itemButtons;
}

- (UIView *)indicatorView
{
    if(!_indicatorView){
        CGFloat indicatorH = self.config.indicHeight;
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - indicatorH, 0, indicatorH)];
        indicatorView.backgroundColor = [UIColor redColor];
        [self.contentScrollView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (UIScrollView *)contentScrollView
{
    if(!_contentScrollView){
        UIScrollView *contentScrollView = [[UIScrollView alloc]init];
        contentScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:contentScrollView];
        self.contentScrollView = contentScrollView;
    }
    return _contentScrollView;
}

+ (instancetype)segmentViewWithFrame:(CGRect)frame
{
    HLSegmentView *segmentView = [[HLSegmentView alloc]initWithFrame:frame];
    return segmentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = self.config.segmentBarColor;
    }
    return self;
}

- (void)updateWithConfit:(void (^)(HLSegmentViewConfig *))configBlock
{
    if (configBlock) {
        configBlock(self.config);
    }
    
    for (UIButton *btn in self.itemButtons) {
        [btn setTitleColor:self.config.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.selectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.font;
    }
    self.backgroundColor = self.config.segmentBarColor;
    self.indicatorView.backgroundColor = self.config.indicColor;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (void)updateIndicatorViewWithScrollView:(UIScrollView *)scrollView
{
    // 当前偏移量
    CGFloat currentOffSetX = scrollView.contentOffset.x;
    // 偏移进度
    CGFloat offsetProgress = currentOffSetX / scrollView.width;
    CGFloat progress = offsetProgress - floor(offsetProgress);
    
    NSInteger fromIndex = currentOffSetX/scrollView.width;
    NSInteger toIndex = fromIndex + 1;
    if (toIndex >= self.itemButtons.count) {
        toIndex = fromIndex;
    }
    
    UIButton *fromBtn = self.itemButtons[fromIndex];
    NSInteger count = self.itemButtons.count;
    UIButton *toBtn;
    if (toIndex < count) {
        toBtn = self.itemButtons[toIndex];
    }
    CGFloat scaleR = progress;
    CGFloat scaleL = 1 - scaleR;
    
//    fromBtn.transform = CGAffineTransformMakeScale(scaleL * 0.2 + 1, scaleL * 0.2 + 1);
//    toBtn.transform = CGAffineTransformMakeScale(scaleR * 0.2 + 1, scaleR * 0.2 + 1);

    if(currentOffSetX - (scrollView.width * _selectIndex) < 0){
        self.indicatorView.x = scaleL*(fromBtn.left-toBtn.left) + toBtn.left;
    }else{
        self.indicatorView.x = scaleR*(toBtn.left-fromBtn.left) + fromBtn.left;
    }

    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    [toBtn setTitleColor:rightColor forState:UIControlStateNormal];
    [fromBtn setTitleColor:leftColor forState:UIControlStateNormal];

}
- (void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    [self.itemButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemButtons = nil;
    NSInteger index = 0;
    for (NSString *item in items) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        [btn setTitle:item forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.contentScrollView addSubview:btn];
        [self.itemButtons addObject:btn];
        index ++;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    // 数据过滤
    if (self.itemButtons.count == 0 || selectIndex < 0 || selectIndex > self.itemButtons.count - 1) {
        return;
    }
    _selectIndex = selectIndex;
    UIButton *btn = self.itemButtons[selectIndex];
    [self btnClick:btn];
    
}

- (void)btnClick:(UIButton *)button
{
    if([self.delegate respondsToSelector:@selector(segmentView:didSelectIndex:fromIndex:)]){
        [self.delegate segmentView:self didSelectIndex:button.tag fromIndex:self.selectedButton.tag];
    }
    
    _selectIndex = button.tag;
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    self.indicatorView.width = button.width + self.config.indicExtraWidth * 2;
    self.indicatorView.centerX = button.centerX;
    
    CGFloat offsetX = button.center.x - self.contentScrollView.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.contentScrollView.contentSize.width - self.contentScrollView.width;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentScrollView.frame = self.bounds;
    
    CGFloat totalButtonWidth = 0;
    for (UIButton *btn in self.itemButtons) {
        [btn sizeToFit];
        totalButtonWidth += btn.width;
    }
    CGFloat caculateMargin = (self.width - totalButtonWidth) / (self.items.count + 1);
    if (caculateMargin < kMinMargin) {
        caculateMargin = kMinMargin;
    }
    
    CGFloat lastX = caculateMargin;
    for (UIButton *btn in self.itemButtons) {
        [btn sizeToFit];
        btn.y = 0;
        btn.x = lastX;
        lastX += btn.width + caculateMargin;
    }
    
    self.contentScrollView.contentSize = CGSizeMake(lastX, 0);
    UIButton *btn = self.itemButtons[self.selectIndex];
    self.indicatorView.width = btn.width + self.config.indicExtraWidth * 2;
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.y = self.height - self.indicatorView.height;
    
}

@end
