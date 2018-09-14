//
//  HLViewController.m
//  HLSegmentViewController
//
//  Created by 2461414445@qq.com on 09/14/2018.
//  Copyright (c) 2018 2461414445@qq.com. All rights reserved.
//

#import "HLViewController.h"

#import "TopLineViewController.h"
#import "HotViewController.h"
#import "VideoViewController.h"
#import "ScoietyViewController.h"
#import "ReaderViewController.h"
#import "ScienceViewController.h"

#import "SegmentViewController.h"

@interface HLViewController ()

@end

@implementation HLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //第一种用法
    
    // 当前控制器继承 SegmentViewController 的时候这么写
    //    [self setupAllChildViewController];
    
    
    //第二种用法
    
    
}
- (IBAction)showSementVC:(id)sender
{
    SegmentViewController *vc = [SegmentViewController segmentControllerWithAddChildViewControllerBlock:^(SegmentViewController *segmentVC) {
        
        TopLineViewController *vc1 = [[TopLineViewController alloc] init];
        vc1.title = @"头条";
        [segmentVC addChildViewController:vc1];
        
        HotViewController *vc2 = [[HotViewController alloc] init];
        vc2.title = @"热点";
        [segmentVC addChildViewController:vc2];
        
        // 视频
        VideoViewController *vc3 = [[VideoViewController alloc] init];
        vc3.title = @"视频";
        [segmentVC addChildViewController:vc3];
        // 社会
        ScoietyViewController *vc4 = [[ScoietyViewController alloc] init];
        vc4.title = @"社会";
        [segmentVC addChildViewController:vc4];
        // 订阅
        ReaderViewController *vc5 = [[ReaderViewController alloc] init];
        vc5.title = @"订阅";
        [segmentVC addChildViewController:vc5];
        // 科技
        ScienceViewController *vc6 = [[ScienceViewController alloc] init];
        vc6.title = @"科技";
        [segmentVC addChildViewController:vc6];
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma 添加所有子控制器
- (void)setupAllChildViewController
{
    // 头条
    TopLineViewController *vc1 = [[TopLineViewController alloc] init];
    vc1.title = @"头条";
    [self addChildViewController:vc1];
    
    // 热点
    HotViewController *vc2 = [[HotViewController alloc] init];
    vc2.title = @"热点";
    [self addChildViewController:vc2];
    
    // 视频
    VideoViewController *vc3 = [[VideoViewController alloc] init];
    vc3.title = @"视频";
    [self addChildViewController:vc3];
    // 社会
    ScoietyViewController *vc4 = [[ScoietyViewController alloc] init];
    vc4.title = @"社会";
    [self addChildViewController:vc4];
    // 订阅
    ReaderViewController *vc5 = [[ReaderViewController alloc] init];
    vc5.title = @"订阅";
    [self addChildViewController:vc5];
    // 科技
    ScienceViewController *vc6 = [[ScienceViewController alloc] init];
    vc6.title = @"科技";
    [self addChildViewController:vc6];
}


@end
