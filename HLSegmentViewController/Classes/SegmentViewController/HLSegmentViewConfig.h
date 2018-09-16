//
//  HLSegmentViewConfig.h
//  SegmentViewController
//
//  Created by Harlan on 2018/9/16.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLSegmentViewConfig : NSObject

+ (instancetype)defaultConfig;


@property (nonatomic, strong) UIColor *segmentBarColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectColor;
@property (nonatomic, strong) UIFont  *font;
@property (nonatomic, strong) UIColor *indicColor;
@property (nonatomic, assign) CGFloat indicHeight;
@property (nonatomic, assign) CGFloat indicExtraWidth;


/**
 HLSegmentView 背景颜色
 */
@property (nonatomic,copy) HLSegmentViewConfig *(^segmentViewBgColor)(UIColor *color);

/**
 HLSegmentView 文字正常颜色
 */
@property (nonatomic,copy) HLSegmentViewConfig *(^itemNormalColor)(UIColor *color);

/**
 HLSegmentView 文字选中颜色
 */
@property (nonatomic,copy) HLSegmentViewConfig *(^itemSelectColor)(UIColor *color);

/**
 HLSegmentView 文字大小
 */
@property (nonatomic,copy) HLSegmentViewConfig *(^itemFont)(UIFont *font);

/**
 HLSegmentView 指示器颜色
 */
@property (nonatomic,copy) HLSegmentViewConfig *(^indicatorColor)(UIColor *color);

/**
 HLSegmentView 指示器高度
 */
@property (nonatomic,copy) HLSegmentViewConfig *(^indicatorHeight)(CGFloat height);

/**
 HLSegmentView 指示器扩展宽度（在自适应的宽度基础上增加）
 */
@property (nonatomic,copy) HLSegmentViewConfig *(^indicatorExtraWidth)(CGFloat width);


@end
