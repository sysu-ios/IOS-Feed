//
//  AttentionViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/7.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "AttentionViewController.h"
#import "Attention/FriendViewController.h"

@interface AttentionViewController ()

@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screen = [[UIScreen mainScreen] bounds];
    // Do any additional setup after loading the view.
    // 兴趣文字框
    UILabel *attentionLabel = [[UILabel alloc] init];
    attentionLabel.text = @"关注的人更新动态会出现在这里";
    attentionLabel.font = [UIFont systemFontOfSize:18];
    CGFloat attentionLabelWidth = 300;
    CGFloat attentionLabelHeight = 50;
    CGFloat attentionLabelTopView = 260;
    attentionLabel.frame = CGRectMake((screen.size.width - attentionLabelWidth) / 2, attentionLabelTopView, attentionLabelWidth, attentionLabelHeight);
    attentionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:attentionLabel];
    // 兴趣按钮
    UIButton *attentionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [attentionButton setTitle:@"关注感兴趣的人" forState:UIControlStateNormal];
    [attentionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [attentionButton setBackgroundColor:[UIColor colorWithRed:50 / 255.0 green: 144 / 255.0 blue:255 / 255.0 alpha:1]];
    attentionButton.titleLabel.font = [UIFont systemFontOfSize:18];
    CGFloat attentionButtonWidth = 330;
    CGFloat attentionButtonHeight = 50;
    CGFloat attentionButtonTopView = attentionLabelTopView + attentionLabelHeight + 10;
    attentionButton.frame = CGRectMake((screen.size.width - attentionButtonWidth) / 2, attentionButtonTopView, attentionButtonWidth, attentionButtonHeight);
    [attentionButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:attentionButton];
}

- (void)onClick:(id)sender
{
    FriendViewController *friendViewController = [[FriendViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:friendViewController];
    [self presentViewController:navigationController animated:TRUE completion:nil];
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
