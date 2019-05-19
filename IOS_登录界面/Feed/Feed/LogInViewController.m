//
//  LogInViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/6.
//  Copyright © 2019 peiyu wang. All rights reserved.
//
// 登录主界面,

#import "LogInViewController.h"
#import "LogIn/SignUpViewController.h"
#import "LogIn/ForgetPassWordViewController.h"
@interface LogInViewController ()
// 用户名文字输入框
@property (nonatomic, strong) UITextField *UserNameTextField;
// 用户密码文字输入框
@property (nonatomic, strong) UITextField *PassWordTextField;
// 用于记录是否登录的BOOL类型
@property (nonatomic, assign) BOOL isOnLine;
@end

@implementation LogInViewController

// 初始化默认为未登录
- (instancetype)init
{
    self = [super init];
    if (self)
        self.isOnLine = NO;
    return self;
}

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
    CGFloat imageWidth = 200;
    CGFloat imageHeight = 100;
    CGFloat imageTopView = 180;
    // 1. FeedlLogo
    UIImageView *HeadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    HeadImageView.frame = CGRectMake((screen.size.width - imageWidth) / 2, imageTopView, imageWidth, imageHeight);
    [self.view addSubview:HeadImageView];

    // 2. 用户名 标签
    CGFloat UsernameLabelWidth = 100;
    CGFloat UsernameLabelHeight = 20;
    CGFloat UsernameLabelTopView = imageTopView + imageHeight + 20;
    UILabel *UsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, UsernameLabelTopView, UsernameLabelWidth, UsernameLabelHeight)];
    UsernameLabel.text = @"用户名";
    [UsernameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    UsernameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:UsernameLabel];
    
    // 3. 用户名 TextField
    CGFloat UserNameTextFieldWidth = 320;
    CGFloat UserNameTextFieldHeight = 40;
    CGFloat UserNameTextFieldTopView = UsernameLabelTopView + UsernameLabelHeight + 10;
    self.UserNameTextField = [[UITextField alloc] initWithFrame:CGRectMake((screen.size.width - UserNameTextFieldWidth) / 2, UserNameTextFieldTopView, UserNameTextFieldWidth, UserNameTextFieldHeight)];
    self.UserNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.UserNameTextField.placeholder = @"请输入用户名：";
    self.UserNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.UserNameTextField.returnKeyType = UIReturnKeyNext;//Next按钮
    self.UserNameTextField.delegate = self;
    [self.view addSubview:self.UserNameTextField];
    
    // 4. 密码 标签
    CGFloat PassWordLabelWidth = 100;
    CGFloat PassWordLabelHeight = 20;
    CGFloat PassWordLabelTopView = UserNameTextFieldTopView + UserNameTextFieldHeight + 30;
    UILabel *PassWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, PassWordLabelTopView, PassWordLabelWidth, PassWordLabelHeight)];
    [PassWordLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    PassWordLabel.textColor = [UIColor whiteColor];
    PassWordLabel.text = @"密码";
    [self.view addSubview:PassWordLabel];
    
    // 5. 用户密码 TextField
    CGFloat PassWordTextFieldWidth = 320;
    CGFloat PassWordTextFieldHeight = 40;
    CGFloat PassWordTextFieldTopView = PassWordLabelHeight + PassWordLabelTopView + 10;
    self.PassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake((screen.size.width - PassWordTextFieldWidth) / 2, PassWordTextFieldTopView, PassWordTextFieldWidth, PassWordTextFieldHeight)];
    self.PassWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.PassWordTextField.placeholder = @"请输入密码：";
    self.PassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.PassWordTextField.secureTextEntry = YES;
    self.PassWordTextField.returnKeyType = UIReturnKeyDone;//Done按钮
    self.PassWordTextField.delegate = self;
    [self.view addSubview:self.PassWordTextField];
    
    // 6. 注册 按钮
    UIButton *signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat signUpButtonWidth = 70;
    CGFloat signUpButtonHeight = 30;
    CGFloat signUpButtonTopView = PassWordTextFieldTopView + PassWordTextFieldHeight + 15;
    signUpButton.frame = CGRectMake(50, signUpButtonTopView, signUpButtonWidth, signUpButtonHeight);
    [signUpButton setTitle:@"注册" forState:UIControlStateNormal];
    signUpButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    signUpButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signUpButton addTarget:self action:@selector(SignUpOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    // 7. 忘记密码 按钮
    UIButton *forgetNameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat forgetNameButtonWidth = 70;
    CGFloat forgetNameButtonHeight = 30;
    CGFloat forgetNameButtonTopView = signUpButtonTopView;
    forgetNameButton.frame = CGRectMake(screen.size.width - 50 - forgetNameButtonWidth, forgetNameButtonTopView, forgetNameButtonWidth, forgetNameButtonHeight);
    [forgetNameButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetNameButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [forgetNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetNameButton addTarget:self action:@selector(ForgetPasswordOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetNameButton];
    
    //8. 登录 按钮
    UIButton *logInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat logInButtonWidth = 160;
    CGFloat logInButtonHeight = 40;
    CGFloat logInButtonTopView = forgetNameButtonTopView + forgetNameButtonHeight + 20;
    logInButton.frame = CGRectMake((screen.size.width - logInButtonWidth) / 2, logInButtonTopView, logInButtonWidth, logInButtonHeight);
    [logInButton setTitle:@"登  录" forState:UIControlStateNormal];
    logInButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:26];
    [logInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logInButton.backgroundColor = [UIColor colorWithRed:238 / 255.0 green: 173 / 255.0 blue:14 / 255.0 alpha:1];
    [logInButton addTarget:self action:@selector(LoginOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logInButton];
}

// 注册用户事件处理
- (void)SignUpOnClick:(id)sender
{
    SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];

    [self.navigationController pushViewController:signUpViewController animated:YES];
}

// 忘记密码事件处理
- (void)ForgetPasswordOnClick:(id)sender
{
    ForgetPassWordViewController *forgetPassWordViewController = [[ForgetPassWordViewController alloc] init];
    [self.navigationController pushViewController:forgetPassWordViewController animated:YES];
}

// 查询是否存在响应账户密码存在则处理
- (void)LoginOnClick:(id)sender
{
    // 查询数据库是否存在用户，如果不存在弹出alert提醒
    /* if (!findByUserName(self.UserNameTextField.text))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"不存在该用户" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
     */
    // 查询到该用户后，检查登录的密码是否与用户登记密码对应
    /*
    else if (!findPasswordByUserName(self.PassWordTextField.text))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"密码不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
     */
    // 验证通过，登录，isOnLine设置为YES
    //else
        self.isOnLine = YES;
}

// 设置 return 回车代理
#pragma mark - textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.UserNameTextField)
    {
        [self.PassWordTextField becomeFirstResponder];
    }else if (textField == self.PassWordTextField){
        [self LoginOnClick:nil];
    }
    return YES;
}

@end
