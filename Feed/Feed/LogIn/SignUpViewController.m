//
//  SignUpViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/7.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()
@property (nonatomic, strong) UITextField *UserNameTextField;
@property (nonatomic, strong) UITextField *PassWordTextField;
@property (nonatomic, strong) UITextField *ConfirmPassWordTextField;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screen = [[UIScreen mainScreen] bounds];
    // 1. 登录头像
    self.view.backgroundColor = [UIColor colorWithRed:174 / 255.0 green: 200 / 255.0 blue: 238 / 255.0 alpha:1];
    UIImage *image = [UIImage imageNamed:@"登录头像"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat imageWidth = 150;
    CGFloat imageHeight = 150;
    CGFloat imageTopView = 150;
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
    self.PassWordTextField.returnKeyType = UIReturnKeyNext;//Next按钮
    self.PassWordTextField.delegate = self;
    [self.view addSubview:self.PassWordTextField];
    
    // 6. 确认密码 标签
    CGFloat ConfirmPassWordLabelWidth = 200;
    CGFloat ConfirmPassWordLabelHeight = 20;
    CGFloat ConfirmPassWordLabelTopView = PassWordTextFieldHeight + PassWordTextFieldTopView + 35;
    UILabel *ConfirmPassWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, ConfirmPassWordLabelTopView, ConfirmPassWordLabelWidth, ConfirmPassWordLabelHeight)];
    ConfirmPassWordLabel.text = @"Confirm Password";
    [self.view addSubview:ConfirmPassWordLabel];
    
    // 7. 用户密码 TextField
    CGFloat ConfirmPassWordTextFieldWidth = 320;
    CGFloat ConfirmPassWordTextFieldHeight = 40;
    CGFloat ConfirmPassWordTextFieldTopView = ConfirmPassWordLabelHeight + ConfirmPassWordLabelTopView + 10;
    self.ConfirmPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake((screen.size.width - ConfirmPassWordTextFieldWidth) / 2, ConfirmPassWordTextFieldTopView, ConfirmPassWordTextFieldWidth, ConfirmPassWordTextFieldHeight)];
    self.ConfirmPassWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.ConfirmPassWordTextField.placeholder = @"请再一次输入密码：";
    self.ConfirmPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.ConfirmPassWordTextField.secureTextEntry = YES;
    self.ConfirmPassWordTextField.returnKeyType = UIReturnKeyDone;//Done按钮
    self.ConfirmPassWordTextField.delegate = self;
    [self.view addSubview:self.ConfirmPassWordTextField];
    
    // 8. Create 按钮
    UIButton *CreateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat CreateButtonWidth = 70;
    CGFloat CreateButtonHeight = 30;
    CGFloat CreateButtonTopView = ConfirmPassWordTextFieldTopView + ConfirmPassWordTextFieldHeight + 45;
    CreateButton.frame = CGRectMake(50, CreateButtonTopView, CreateButtonWidth, CreateButtonHeight);
    [CreateButton setTitle:@"Create" forState:UIControlStateNormal];
    [CreateButton setTitleColor:[UIColor colorWithRed:120 / 255.0 green: 164 / 255.0 blue:255 / 255.0 alpha:1] forState:UIControlStateNormal];
    CreateButton.backgroundColor = [UIColor colorWithRed:248 / 255.0 green: 248 / 255.0 blue:255 / 255.0 alpha:1];
    [CreateButton addTarget:self action:@selector(CreateOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CreateButton];
    
    // 9. Cancel 按钮
    UIButton *CancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat CancelButtonWidth = 70;
    CGFloat CancelButtonHeight = 30;
    CGFloat CancelButtonTopView = CreateButtonTopView;
    CancelButton.frame = CGRectMake(screen.size.width - 50 - CancelButtonWidth, CancelButtonTopView, CancelButtonWidth, CancelButtonHeight);
    [CancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [CancelButton setTitleColor:[UIColor colorWithRed:120 / 255.0 green: 164 / 255.0 blue:255 / 255.0 alpha:1] forState:UIControlStateNormal];
    CancelButton.backgroundColor = [UIColor colorWithRed:248 / 255.0 green: 248 / 255.0 blue:255 / 255.0 alpha:1];
    [CancelButton addTarget:self action:@selector(CancelOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CancelButton];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)CreateOnClick:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:^{
        
    }];
}

- (void)CancelOnClick:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:^{
        
    }];
}

#pragma mark - textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.UserNameTextField)
    {
        [self.PassWordTextField becomeFirstResponder];
    }else if (textField == self.PassWordTextField){
        [self.ConfirmPassWordTextField becomeFirstResponder];
    }else{
        [self CreateOnClick:nil];
    }
    return YES;
}

@end
