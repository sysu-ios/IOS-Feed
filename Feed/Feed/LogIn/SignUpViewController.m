//
//  SignUpViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/7.
//  Copyright © 2019 peiyu wang. All rights reserved.
// 注册界面

#import "SignUpViewController.h"
#import "PersonalInfoViewController.h"
// 更改头像采用调用相册和相机的方法
// 实现导航协议以及imagePicker协议达到调用系统相册相机方法
@interface SignUpViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
// 注册用户名文字输入框
@property (nonatomic, strong) UITextField *UserNameTextField;
// 注册密码文字输入框
@property (nonatomic, strong) UITextField *PassWordTextField;
// 确认密码文字输入框
@property (nonatomic, strong) UITextField *ConfirmPassWordTextField;
// 用户头像视图
@property (nonatomic, strong) UIImageView *HeadImageView;
@end

@implementation SignUpViewController

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
    CGFloat imageWidth = 100;
    CGFloat imageHeight = 100;
    CGFloat imageTopView = 150;
    // 设置返回按钮
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(CancelOnClick:)];
    [cancelButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = cancelButton;
    // 1. 设置登录头像
    // 先传入默认头像
    self.HeadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头像"]];
    self.HeadImageView.frame = CGRectMake((screen.size.width - imageWidth) / 2, imageTopView, imageWidth, imageHeight);
    // 设置头像阴影
    [self.HeadImageView setBackgroundColor:[UIColor grayColor]];
    self.HeadImageView.layer.cornerRadius = 50;
    self.HeadImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.HeadImageView.clipsToBounds = YES;
    self.HeadImageView.layer.borderWidth = 3;
    self.HeadImageView.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6].CGColor;
    // 给头像视图添加手势交互
    UITapGestureRecognizer *changeUserIconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeUserIconAction:)];
    [self.HeadImageView addGestureRecognizer:changeUserIconTap];
    // 给头像视图打开交互响应
    self.HeadImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.HeadImageView];
    
    // 1.1添加头像背景和外发光等个性化设置
    CALayer *layer = [[CALayer alloc] init];
    layer.position = self.HeadImageView.layer.position;
    layer.bounds = self.HeadImageView.bounds;
    layer.cornerRadius = self.HeadImageView.layer.cornerRadius;
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowRadius = 5;
    layer.shadowOffset = CGSizeMake(2,2);
    layer.shadowOpacity = 1;
    [self.view.layer addSublayer:layer];
    [self.view bringSubviewToFront:self.HeadImageView];

    // 2. 用户名 标签
    CGFloat UsernameLabelWidth = 100;
    CGFloat UsernameLabelHeight = 20;
    CGFloat UsernameLabelTopView = imageTopView + imageHeight + 30;
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
    self.PassWordTextField.returnKeyType = UIReturnKeyNext;//Done按钮
    self.PassWordTextField.delegate = self;
    [self.view addSubview:self.PassWordTextField];
    
    // 6. 确认用户密码 Label
    CGFloat ConfirmPassWordLabelWidth = 100;
    CGFloat ConfirmPassWordLabelHeigth = 20;
    CGFloat ConfirmPassWordLabelTopView = PassWordTextFieldHeight + PassWordTextFieldTopView + 30;
    UILabel *ConfirmPassWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, ConfirmPassWordLabelTopView, ConfirmPassWordLabelWidth, ConfirmPassWordLabelHeigth)];
    [ConfirmPassWordLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    ConfirmPassWordLabel.textColor = [UIColor whiteColor];
    ConfirmPassWordLabel.text = @"确认密码";
    [self.view addSubview:ConfirmPassWordLabel];
    
    // 7. 确认用户密码 TextField
    CGFloat ConfirmPassWordTextFieldWidth = 320;
    CGFloat ConfirmPassWordTextFieldHeight = 40;
    CGFloat ConfirmPassWordTextFieldTopView = ConfirmPassWordLabelHeigth + ConfirmPassWordLabelTopView + 10;
    self.ConfirmPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake((screen.size.width - ConfirmPassWordTextFieldWidth) / 2, ConfirmPassWordTextFieldTopView, ConfirmPassWordTextFieldWidth, ConfirmPassWordTextFieldHeight)];
    self.ConfirmPassWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.ConfirmPassWordTextField.placeholder = @"请确认密码";
    self.ConfirmPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.ConfirmPassWordTextField.secureTextEntry = YES;
    self.ConfirmPassWordTextField.returnKeyType = UIReturnKeyDone;
    self.ConfirmPassWordTextField.delegate = self;
    [self.view addSubview:self.ConfirmPassWordTextField];
    
    //8. 注册 按钮
    UIButton *SignUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat SignUpButtonWidth = 160;
    CGFloat SignUpButtonHeight = 40;
    CGFloat SignUpButtonTopView = ConfirmPassWordTextFieldHeight + ConfirmPassWordTextFieldTopView + 30;
    SignUpButton.frame = CGRectMake((screen.size.width - SignUpButtonWidth) / 2, SignUpButtonTopView, SignUpButtonWidth, SignUpButtonHeight);
    [SignUpButton setTitle:@"注  册" forState:UIControlStateNormal];
    SignUpButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:26];
    [SignUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SignUpButton.backgroundColor = [UIColor colorWithRed:238 / 255.0 green: 173 / 255.0 blue:14 / 255.0 alpha:1];
    [SignUpButton addTarget:self action:@selector(CreateOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SignUpButton];
    // 创建数据模型
}

// 注册按钮
- (void)CreateOnClick:(id)sender
{
    // 检查用户名是否已存在
    // 调用数据库查询是否已存在此用户if(findByUserName(self.UserNameTextField.text)
    if ([self.UserNameTextField.text isEqual: @"123"])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"用户名已存在" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    // 检查是否输入了密码
    else if ([self.PassWordTextField.text isEqual: @""])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    // 检查是否输入了用户名
    else if ([self.UserNameTextField.text isEqual: @""])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"请输入用户名" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    // 检查两次输入密码是否相等
    else if (![self.PassWordTextField.text isEqualToString: self.ConfirmPassWordTextField.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"两次输入的密码不相同" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    // 如果不存在以上情况则注册成功，将用户信息的用户名一起返回给下一层界面
    // ！！！不要在此时将用户信息存入数据库，等到下一级注册成功才是最终成功，再写入
    else
    {
        PersonalInfoViewController *personalInfoViewController = [[PersonalInfoViewController alloc] init];
        personalInfoViewController.infoList.UserName = self.UserNameTextField.text;
        personalInfoViewController.infoList.Password =self.PassWordTextField.text;
        personalInfoViewController.infoList.UserIcon = self.HeadImageView.image;
        [self.navigationController pushViewController:personalInfoViewController animated:YES];
    }
}

// 取消(返回上级)按钮
- (void)CancelOnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

// textField协议代理
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


// 更换头像，对点击手势的响应
- (void)changeUserIconAction:(UITapGestureRecognizer *)tap{
    UIAlertController *userIconActionSheet = [UIAlertController alertControllerWithTitle:@"请选择上传类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相机选择");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"系统相册选择");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel");
    }];
    [userIconActionSheet addAction:photoAction];
    [userIconActionSheet addAction:albumAction];
    [userIconActionSheet addAction:cancelAction];
    [self presentViewController:userIconActionSheet animated:YES completion:nil];
}

#pragma mark -- 调用系统相册以及拍照功能的实现
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    self.HeadImageView.image = img;
    // 裁剪图片后插入数据库
    //UIImage *compressImg = [self imageWithImageSimple:img scaledToSize:CGSizeMake(100, 100)];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// 压缩图片方法，如果要写入数据库可以考虑调用裁剪后存入
/*
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
*/
@end
