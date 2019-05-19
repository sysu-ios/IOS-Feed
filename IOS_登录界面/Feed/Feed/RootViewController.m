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
#import "LogIn/MyInfoViewController.h"
@interface RootViewController ()
@property (nonatomic, strong) LogInViewController *logInViewController;
@property (nonatomic, strong) MyInfoViewController *myInfoViewController;
@property (nonatomic, strong) UINavigationController *myInfoNavigationController;
@property (nonatomic, strong) UINavigationController *logInNavigationController;
@property (nonatomic, strong) NSMutableArray *tabBarArray;
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
    self.logInViewController = [[LogInViewController alloc] init];
    self.logInNavigationController = [[UINavigationController alloc] initWithRootViewController:self.logInViewController];
    self.logInNavigationController.tabBarItem.title = @"登录";
    self.logInNavigationController.tabBarItem.image = [UIImage imageNamed:@"无用户"];
    self.tabBarArray = [[NSMutableArray alloc] initWithArray:@[homeNavigationController, videoNavigationController, self.logInNavigationController]];
    self.viewControllers = [NSArray arrayWithArray:self.tabBarArray];
    // 状态栏(statusbar)
    // 添加观察者模式KVO
    // 4.设置用户界面
    self.myInfoViewController = [[MyInfoViewController alloc] init];
    self.myInfoNavigationController = [[UINavigationController alloc] initWithRootViewController: self.myInfoViewController];
    self.myInfoNavigationController.tabBarItem.title = @"已登录";
    self.myInfoNavigationController.tabBarItem.image = [UIImage imageNamed:@"用户"];
    [self.logInViewController addObserver:self forKeyPath:@"isOnLine" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    BOOL newState = [change valueForKey:@"new"];
    if (newState)
    {
        self.tabBarArray[2] = self.myInfoNavigationController;
        self.viewControllers = [NSArray arrayWithArray:self.tabBarArray];
    }
    else
    {
        self.tabBarArray[2] = self.logInNavigationController;
        self.viewControllers = [NSArray arrayWithArray:self.tabBarArray];
    }
}

-(void)dealloc
{
    [self.logInViewController removeObserver:self forKeyPath:@"isOnLine"];
}

@end
