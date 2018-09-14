//
//  SegmentViewController.h
//  SegmentViewController
//
//  Created by Harlan on 2018/9/14.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentViewController : UIViewController


/**
 使用此方法创建控制器（唯一方法）

 @param addBlock 添加子控制器block
 @return 返回实例对象
 */
+ (instancetype)segmentControllerWithAddChildViewControllerBlock:(void(^)(SegmentViewController *))addBlock;

/**
 正常标题颜色
 */
@property (nonatomic,strong) UIColor *titleViewBgColor;

/**
 正常标题颜色
 */
@property (nonatomic,strong) UIColor *titleColor;

/**
 选中标题颜色
 */
@property (nonatomic,strong) UIColor *selectedTitleColor;

/**
 正常标题大小
 */
@property (nonatomic,strong) UIFont *normalFont;


@end
