//
//  ForgetPassWordViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/17.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "ForgetPassWordViewController.h"
#import "ModifyPassWordViewController.h"
@interface ForgetPassWordViewController ()
@property (nonatomic, strong) UITextField *PhoneTextField;
@property (nonatomic, strong) UITextField *VerifyTextField;
@end

@implementation ForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screen = [[UIScreen mainScreen] bounds];
    // 0. 背景图片
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ditu"]];
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    // 0.0 背景模糊图片
    UIImageView *SecondBackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    SecondBackImageView.userInteractionEnabled = YES;
    [self.view addSubview:SecondBackImageView];
    // 设置返回按钮
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(CancelOnClick:)];
    [cancelButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = cancelButton;
    // 账号验证标签
    CGFloat topicLabelWidth = 200;
    CGFloat topicLabelHeight = 20;
    CGFloat topicLabelTopView = 136;
    UILabel *topicLabel = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width - topicLabelWidth) / 2, topicLabelTopView, topicLabelWidth, topicLabelHeight)];
    topicLabel.text = @"① 账号验证 ";
    topicLabel.textAlignment = NSTextAlignmentCenter;
    [topicLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:26]];
    topicLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:topicLabel];
    
    // 1. 手机号 标签
    CGFloat PhoneLabelWidth = 200;
    CGFloat PhoneLabelHeight = 20;
    CGFloat PhoneLabelTopView = 220;
    UILabel *PhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, PhoneLabelTopView, PhoneLabelWidth, PhoneLabelHeight)];
    PhoneLabel.text = @"请输入手机号";
    [PhoneLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    PhoneLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:PhoneLabel];

    // 2. 手机号 TextField
    CGFloat PhoneTextFieldWidth = 320;
    CGFloat PhoneTextFieldHeight = 40;
    CGFloat PhoneTextFieldTopView = PhoneLabelTopView + PhoneLabelHeight + 30;
    self.PhoneTextField = [[UITextField alloc] initWithFrame:CGRectMake((screen.size.width - PhoneTextFieldWidth) / 2, PhoneTextFieldTopView, PhoneTextFieldWidth, PhoneTextFieldHeight)];
    self.PhoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.PhoneTextField.placeholder = @"请输入手机号：";
    self.PhoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.PhoneTextField.returnKeyType = UIReturnKeyNext;//Next按钮
    [self.view addSubview:self.PhoneTextField];
    
    // 3. 手机验证 标签
    CGFloat VerifyLabelWidth = 200;
    CGFloat VerifyLabelHeight = 20;
    CGFloat VerifyLabelTopView = PhoneTextFieldHeight + PhoneTextFieldTopView + 60;
    UILabel *VerifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, VerifyLabelTopView, VerifyLabelWidth, VerifyLabelHeight)];
    VerifyLabel.text = @"请输入验证码";
    [VerifyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    VerifyLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:VerifyLabel];
    
    // 3. 手机号验证 TextField
    CGFloat VerifyTextFieldWidth = 320;
    CGFloat VerifyTextFieldHeight = 40;
    CGFloat VerifyTextFieldTopView = VerifyLabelTopView + VerifyLabelHeight + 30;
    self.VerifyTextField = [[UITextField alloc] initWithFrame:CGRectMake((screen.size.width - VerifyTextFieldWidth) / 2, VerifyTextFieldTopView, VerifyTextFieldWidth, VerifyTextFieldHeight)];
    self.VerifyTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.VerifyTextField.placeholder = @"请输入手机号：";
    self.VerifyTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.VerifyTextField.returnKeyType = UIReturnKeyNext;//Next按钮
    [self.view addSubview:self.VerifyTextField];
    
    // 4. 按钮
    UIButton *CompleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat CompleteButtonWidth = 160;
    CGFloat CompleteButtonHeight = 40;
    CGFloat CompleteButtonTopView = VerifyTextFieldTopView + 100;
    CompleteButton.frame = CGRectMake((screen.size.width - CompleteButtonWidth) / 2, CompleteButtonTopView, CompleteButtonWidth, CompleteButtonHeight);
    [CompleteButton setTitle:@"下 一 步" forState:UIControlStateNormal];
    CompleteButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:26];
    [CompleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CompleteButton.backgroundColor = [UIColor colorWithRed:238 / 255.0 green: 173 / 255.0 blue:14 / 255.0 alpha:1];
    [CompleteButton addTarget:self action:@selector(CompleteOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CompleteButton];
}

- (void)CancelOnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)CompleteOnClick:(id)sender
{
    // 调用数据库查询
    if (![self.PhoneTextField.text isEqualToString:@"17853211788"])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"不存在该手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (![self.VerifyTextField.text isEqualToString:@"1234"])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"验证码不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        ModifyPassWordViewController *modifyPassWordViewController = [[ModifyPassWordViewController alloc] init];
        [self.navigationController pushViewController:modifyPassWordViewController animated:YES];
    }
}

@end
