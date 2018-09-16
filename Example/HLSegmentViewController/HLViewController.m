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

#import "HLSegmentViewController.h"

@interface HLViewController ()

@property (nonatomic,weak) HLSegmentViewController *segmentVC;

@end

@implementation HLViewController


- (HLSegmentViewController *)segmentVC
{
    if(!_segmentVC){
        HLSegmentViewController *vc = [[HLSegmentViewController alloc]init];
        vc.view.backgroundColor = [UIColor lightGrayColor];
        [self addChildViewController:vc];
        self.segmentVC = vc;
    }
    return _segmentVC;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    
    
    // 添加几个自控制器
    // 在contentView, 展示子控制器的视图内容
    
    NSArray *items = @[@"专辑", @"声音", @"下载中"];
    
    TopLineViewController *vc1 = [[TopLineViewController alloc]init];
    
    HotViewController *vc2 = [[HotViewController alloc]init];
    
    VideoViewController *vc3 = [[VideoViewController alloc]init];
    
    
    [self.segmentVC setupSegmentItems:items childViewControllers:@[vc1,vc2,vc3]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *items = @[@"头条投案天", @"热点新闻", @"视频哈哈哈", @"社会嗯嗯嗯", @"订阅卡卡",@"科技哔哔"];
        
        // 添加几个自控制器
        // 在contentView, 展示子控制器的视图内容
        
        // 头条
        TopLineViewController *vc1 = [[TopLineViewController alloc] init];
        // 热点
        HotViewController *vc2 = [[HotViewController alloc] init];
        
        // 视频
        VideoViewController *vc3 = [[VideoViewController alloc] init];
        // 社会
        ScoietyViewController *vc4 = [[ScoietyViewController alloc] init];

        // 订阅
        ReaderViewController *vc5 = [[ReaderViewController alloc] init];

        // 科技
        ScienceViewController *vc6 = [[ScienceViewController alloc] init];
        
        
        [self.segmentVC setupSegmentItems:items childViewControllers:@[vc1, vc2, vc3, vc4, vc5,vc6]];
        
        [self.segmentVC.segmentView updateWithConfit:^(HLSegmentViewConfig *config) {
            config.segmentBarColor = [UIColor greenColor];
        }];
    });
    
    
}

@end
