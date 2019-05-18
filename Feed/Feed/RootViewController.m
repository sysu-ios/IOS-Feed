//
//  RootViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/6.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "LogInViewController.h"
#import "ReleaseViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 设置首页标签
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    homeNavigationController.tabBarItem.title = @"首页";
    homeNavigationController.tabBarItem.image = [UIImage imageNamed:@"首页"];
    // 2. 设置发布标签
    ReleaseViewController *releaseViewController = [[ReleaseViewController alloc] init];
    UINavigationController *videoNavigationController = [[UINavigationController alloc] initWithRootViewController:releaseViewController];
    videoNavigationController.tabBarItem.title = @"发布";
    videoNavigationController.tabBarItem.image = [UIImage imageNamed:@"相机"];
    // 3. 设置登录标签
    LogInViewController *logInViewController = [[LogInViewController alloc] init];
    UINavigationController *logInNavigationController = [[UINavigationController alloc] initWithRootViewController:logInViewController];
    logInNavigationController.tabBarItem.title = @"登录";
    logInNavigationController.tabBarItem.image = [UIImage imageNamed:@"用户"];
    //为viewControllers添加引用
    self.viewControllers = @[homeNavigationController, videoNavigationController, logInNavigationController];
    // 状态栏(statusbar)

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
