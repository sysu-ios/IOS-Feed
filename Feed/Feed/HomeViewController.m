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
    CGRect screen = [[UIScreen mainScreen] bounds];
    /*UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    label.text = @"123";
    [self.view addSubview:label];*/
    ScrollViewController *scrollViewController = [[ScrollViewController alloc] init];
    scrollViewController.cbs_titleArray = @[@"关注", @"推荐", @"娱乐", @"军事", @"科技", @"体育"];
    //设置各个标签对应的ViewController，如果数量不对会崩溃
    scrollViewController.cbs_viewArray = @[@"AttentionViewController", @"RecommendViewController", @"PEViewController", @"TechViewController", @"MilitaryViewController", @"EnterViewController"];
    scrollViewController.cbs_Type = CBSSegmentHeaderTypeScroll;
    //scrollViewController.cbs_headerColor = [UIColor grayColor];
    scrollViewController.cbs_buttonHeight = 40;
    scrollViewController.cbs_NavTopHeight = 0;
    scrollViewController.cbs_topHeight = NavAndStatusHight + scrollViewController.cbs_NavTopHeight;
    //先设置cbs_titleArray和cbs_viewArray再调用initSegment
    [scrollViewController initSegment];
    [self addChildViewController:scrollViewController];
    [self.view addSubview:scrollViewController.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
