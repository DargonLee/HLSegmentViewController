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

@property (nonatomic,strong) NSMutableArray <UIButton *>*itemButtons;

@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic,strong) UIButton *selectedButton;

@property (nonatomic,strong) HLSegmentViewConfig *config;

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

- (void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    [self.itemButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemButtons = nil;
    for (NSString *item in items) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = self.itemButtons.count;
        [btn setTitle:item forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.backgroundColor = [self randomColor];
        [self.contentScrollView addSubview:btn];
        [self.itemButtons addObject:btn];
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
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.width + self.config.indicExtraWidth * 2;
        self.indicatorView.centerX = button.centerX;
    }];
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
    self.indicatorView.width = btn.width;
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.y = self.height - self.indicatorView.height;
    
}

- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
