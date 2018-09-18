//
//  HLSegmentView.h
//  SegmentViewController
//
//  Created by Harlan on 2018/9/15.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLSegmentViewConfig.h"

@class HLSegmentView;
@protocol HLSegmentViewDelegate <NSObject>

- (void)segmentView:(HLSegmentView *)segmentView didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

@interface HLSegmentView : UIView

+ (instancetype)segmentViewWithFrame:(CGRect)frame;

@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic,strong) NSArray <NSString *>*items;

@property (nonatomic,strong) NSMutableArray <UIButton *>*itemButtons;

@property (nonatomic,weak) id <HLSegmentViewDelegate> delegate;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,strong) HLSegmentViewConfig *config;

- (void)updateWithConfit:(void(^)(HLSegmentViewConfig *config))configBlock;

- (void)updateIndicatorViewWithScrollView:(UIScrollView *)scrollView;

@end
