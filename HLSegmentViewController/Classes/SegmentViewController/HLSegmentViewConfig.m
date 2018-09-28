//
//  HLSegmentViewConfig.m
//  SegmentViewController
//
//  Created by Harlan on 2018/9/16.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import "HLSegmentViewConfig.h"

@interface HLSegmentViewConfig()


@end

@implementation HLSegmentViewConfig

+ (instancetype)defaultConfig
{
    HLSegmentViewConfig *config = [[HLSegmentViewConfig alloc]init];
    config.segmentBarColor = [UIColor clearColor];
    config.font = [UIFont systemFontOfSize:15];
    config.normalColor = [UIColor lightGrayColor];
    config.selectColor = [UIColor redColor];
    
    config.indicColor = [UIColor redColor];
    config.indicHeight = 2;
    config.indicExtraWidth = 0;
    config.indicFixedWidth = 0;
    return config;
}

- (HLSegmentViewConfig *(^)(UIColor *))segmentViewBgColor
{
    return ^(UIColor *color){
        self.segmentBarColor = color;
        return self;
    };
}

- (HLSegmentViewConfig *(^)(UIColor *))itemNormalColor
{
    return ^(UIColor *color){
        self.normalColor = color;
        return self;
    };
}

- (HLSegmentViewConfig *(^)(UIColor *))itemSelectColor
{
    return ^(UIColor *color){
        self.selectColor = color;
        return self;
    };
}

- (HLSegmentViewConfig *(^)(UIFont *))itemFont
{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}

- (HLSegmentViewConfig *(^)(UIColor *))indicatorColor
{
    return ^(UIColor *color){
        self.indicColor = color;
        return self;
    };
}

- (HLSegmentViewConfig *(^)(CGFloat))indicatorHeight
{
    return ^(CGFloat height){
        self.indicHeight = height;
        return self;
    };
}

- (HLSegmentViewConfig *(^)(CGFloat))indicatorExtraWidth
{
    return ^(CGFloat width){
        self.indicExtraWidth = width;
        return self;
    };
}

- (HLSegmentViewConfig *(^)(CGFloat))indicatorFixedWidth
{
    return ^(CGFloat width){
        self.indicFixedWidth = width;
        return self;
    };
}

@end
