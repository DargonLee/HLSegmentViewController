//
//  SegmentViewController.h
//  SegmentViewController
//
//  Created by Harlan on 2018/9/14.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLSegmentView.h"

@interface HLSegmentViewController : UIViewController


/**
 segment 视图
 */
@property (nonatomic,strong) HLSegmentView *segmentView;

/**
 创建segment控制器

 @param items segment 标题
 @param vcs segment 控制器
 */
- (void)setupSegmentItems:(NSArray <NSString *>*)items childViewControllers:(NSArray <UIViewController *>*)childVCs;



@end
