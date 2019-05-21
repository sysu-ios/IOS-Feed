//
//  HomeViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/6.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "HomeViewController.h"
#import "Home/ScrollViewController.h"
#import "Home/Scroll/AttentionViewController.h"
#import "Home/Scroll/RecommendViewController.h"
#import "Home/Scroll/PEViewController.h"
#import "Home/Scroll/TechViewController.h"
#import "Home/Scroll/MilitaryViewController.h"
#import "Home/Scroll/EnterViewController.h"
#define NavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // CGRect screen = [[UIScreen mainScreen] bounds];
    ScrollViewController *scrollViewController = [[ScrollViewController alloc] init];
    scrollViewController.cbs_titleArray = @[@"关注", @"推荐", @"娱乐", @"军事", @"科技", @"体育"];
    //设置各个标签对应的ViewController，如果数量不对会崩溃
    scrollViewController.cbs_viewArray = @[@"AttentionViewController", @"RecommendViewController", @"PEViewController", @"TechViewController", @"MilitaryViewController", @"EnterViewController"];
    scrollViewController.cbs_Type = CBSSegmentHeaderTypeScroll;
    scrollViewController.cbs_buttonHeight = 40;
    scrollViewController.cbs_NavTopHeight = 0;
    scrollViewController.cbs_topHeight = NavAndStatusHight + scrollViewController.cbs_NavTopHeight;
    [scrollViewController initSegment];
    [self addChildViewController:scrollViewController];
    [self.view addSubview:scrollViewController.view];
}


@end
