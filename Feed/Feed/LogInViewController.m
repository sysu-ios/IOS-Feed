//
//  LogInViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/6.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "LogInViewController.h"
#import "LogIn/SignUpViewController.h"

@interface LogInViewController ()
@property (nonatomic, strong) UITextField *UserNameTextField;
@property (nonatomic, strong) UITextField *PassWordTextField;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screen = [[UIScreen mainScreen] bounds];
    // 1. 登录头像
    self.view.backgroundColor = [UIColor colorWithRed:174 / 255.0 green: 200 / 255.0 blue: 238 / 255.0 alpha:1];
    UIImage *image = [UIImage imageNamed:@"登录头像"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat imageWidth = 150;
    CGFloat imageHeight = 150;
    CGFloat imageTopView = 200;
    imageView.frame = CGRectMake((screen.size.width - imageWidth) / 2, imageTopView, imageWidth, imageHeight);
    [self.view addSubview:imageView];
    
    // 2. 用户名 标签
    CGFloat UsernameLabelWidth = 100;
    CGFloat UsernameLabelHeight = 20;
    CGFloat UsernameLabelTopView = imageTopView + imageHeight + 30;
    UILabel *UsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, UsernameLabelTopView, UsernameLabelWidth, UsernameLabelHeight)];
    UsernameLabel.text = @"Username";
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
    PassWordLabel.text = @"Password";
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
    
    // 6. sign up 按钮
    UIButton *signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat signUpButtonWidth = 70;
    CGFloat signUpButtonHeight = 30;
    CGFloat signUpButtonTopView = PassWordTextFieldTopView + PassWordTextFieldHeight + 45;
    signUpButton.frame = CGRectMake(50, signUpButtonTopView, signUpButtonWidth, signUpButtonHeight);
    [signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signUpButton setTitleColor:[UIColor colorWithRed:120 / 255.0 green: 164 / 255.0 blue:255 / 255.0 alpha:1] forState:UIControlStateNormal];
    signUpButton.backgroundColor = [UIColor colorWithRed:248 / 255.0 green: 248 / 255.0 blue:255 / 255.0 alpha:1];
    [signUpButton addTarget:self action:@selector(SignUpOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    // 7. Log in 按钮
    UIButton *logInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat logInButtonWidth = 70;
    CGFloat logInButtonHeight = 30;
    CGFloat logInButtonTopView = signUpButtonTopView;
    logInButton.frame = CGRectMake(screen.size.width - 50 - logInButtonWidth, logInButtonTopView, logInButtonWidth, logInButtonHeight);
    [logInButton setTitle:@"Log In" forState:UIControlStateNormal];
    [logInButton setTitleColor:[UIColor colorWithRed:120 / 255.0 green: 164 / 255.0 blue:255 / 255.0 alpha:1] forState:UIControlStateNormal];
    logInButton.backgroundColor = [UIColor colorWithRed:248 / 255.0 green: 248 / 255.0 blue:255 / 255.0 alpha:1];
    [self.view addSubview:logInButton];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)SignUpOnClick:(id)sender
{
    SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:signUpViewController];
    [self presentViewController:navigationController animated:TRUE completion:nil];
}

// 查询是否存在响应账户密码存在则处理
- (void)LoginOnClick:(id)sender
{
    
}

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
