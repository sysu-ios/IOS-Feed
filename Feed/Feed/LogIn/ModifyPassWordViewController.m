//
//  ModifyPassWordViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/17.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "ModifyPassWordViewController.h"

@interface ModifyPassWordViewController ()
@property (nonatomic, strong) UITextField *ModifyPassWordTextField;
@property (nonatomic, strong) UITextField *ConfirmModifyPassWordTextField;
@end

@implementation ModifyPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"返回上一步" style:UIBarButtonItemStylePlain target:self action:@selector(CancelOnClick:)];
    [cancelButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = cancelButton;
    // 账号验证标签
    CGFloat topicLabelWidth = 200;
    CGFloat topicLabelHeight = 20;
    CGFloat topicLabelTopView = 136;
    UILabel *topicLabel = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width - topicLabelWidth) / 2, topicLabelTopView, topicLabelWidth, topicLabelHeight)];
    topicLabel.text = @"② 重置密码 ";
    topicLabel.textAlignment = NSTextAlignmentCenter;
    [topicLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:26]];
    topicLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:topicLabel];
    
    // 1. 手机号 标签
    CGFloat ModifyPassWordLabelWidth = 200;
    CGFloat ModifyPassWordLabelHeight = 20;
    CGFloat ModifyPassWordLabelTopView = 220;
    UILabel *ModifyPassWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, ModifyPassWordLabelTopView, ModifyPassWordLabelWidth, ModifyPassWordLabelHeight)];
    ModifyPassWordLabel.text = @"密码";
    [ModifyPassWordLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    ModifyPassWordLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:ModifyPassWordLabel];
    
    // 2. 手机号 TextField
    CGFloat ModifyPassWordTextFieldWidth = 320;
    CGFloat ModifyPassWordTextFieldHeight = 40;
    CGFloat ModifyPassWordTextFieldTopView = ModifyPassWordLabelTopView + ModifyPassWordLabelHeight + 30;
    self.ModifyPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake((screen.size.width - ModifyPassWordTextFieldWidth) / 2, ModifyPassWordTextFieldTopView, ModifyPassWordTextFieldWidth, ModifyPassWordTextFieldHeight)];
    self.ModifyPassWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.ModifyPassWordTextField.placeholder = @"请输入密码：";
    self.ModifyPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.ModifyPassWordTextField.returnKeyType = UIReturnKeyNext;//Next按钮
    [self.view addSubview:self.ModifyPassWordTextField];
    
    // 3. 手机验证 标签
    CGFloat ConfirmModifyPassWordLabelWidth = 200;
    CGFloat ConfirmModifyPassWordLabelHeight = 20;
    CGFloat ConfirmModifyPassWordLabelTopView = ModifyPassWordTextFieldHeight + ModifyPassWordTextFieldTopView + 60;
    UILabel *ConfirmModifyPassWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, ConfirmModifyPassWordLabelTopView, ConfirmModifyPassWordLabelWidth, ConfirmModifyPassWordLabelHeight)];
    ConfirmModifyPassWordLabel.text = @"确认密码";
    [ConfirmModifyPassWordLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    ConfirmModifyPassWordLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:ConfirmModifyPassWordLabel];
    
    // 3. 手机号验证 TextField
    CGFloat ConfirmModifyPassWordTextFieldWidth = 320;
    CGFloat ConfirmModifyPassWordTextFieldHeight = 40;
    CGFloat ConfirmModifyPassWordTextFieldTopView = ConfirmModifyPassWordLabelTopView + ConfirmModifyPassWordLabelHeight + 30;
    self.ConfirmModifyPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake((screen.size.width - ConfirmModifyPassWordTextFieldWidth) / 2, ConfirmModifyPassWordTextFieldTopView, ConfirmModifyPassWordTextFieldWidth, ConfirmModifyPassWordTextFieldHeight)];
    self.ConfirmModifyPassWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.ConfirmModifyPassWordTextField.placeholder = @"请再次确认密码：";
    self.ConfirmModifyPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.ConfirmModifyPassWordTextField.returnKeyType = UIReturnKeyNext;//Next按钮
    [self.view addSubview:self.ConfirmModifyPassWordTextField];
    
    // 4. 按钮
    UIButton *CompleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat CompleteButtonWidth = 160;
    CGFloat CompleteButtonHeight = 40;
    CGFloat CompleteButtonTopView = ConfirmModifyPassWordTextFieldTopView + 100;
    CompleteButton.frame = CGRectMake((screen.size.width - CompleteButtonWidth) / 2, CompleteButtonTopView, CompleteButtonWidth, CompleteButtonHeight);
    [CompleteButton setTitle:@"完 成" forState:UIControlStateNormal];
    CompleteButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:26];
    [CompleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CompleteButton.backgroundColor = [UIColor colorWithRed:238 / 255.0 green: 173 / 255.0 blue:14 / 255.0 alpha:1];
    [CompleteButton addTarget:self action:@selector(CompleteOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CompleteButton];
}

-(void)CancelOnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)CompleteOnClick:(id)sender
{
    // 调用数据库查询
    if ([self.ModifyPassWordTextField.text isEqualToString:@""])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更改失败" message:@"密码不得为空" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if (![self.ConfirmModifyPassWordTextField.text isEqualToString:self.ModifyPassWordTextField.text])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更改失败" message:@"两次输入密码不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
