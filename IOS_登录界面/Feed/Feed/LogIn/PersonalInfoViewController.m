//
//  PersonalInfoViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/14.
//  Copyright © 2019 peiyu wang. All rights reserved.
// 用户个人信息界面

#import "PersonalInfoViewController.h"
// tableViewCell的Cell自定义
#import "InfoCell.h"
#import "SignUpViewController.h"
#import "inputViewController.h"
#import "PlacePicker/PlacePicker.h"
#define cellIdentifier  @"CellIdentifier"

@interface PersonalInfoViewController () <UITableViewDelegate, UITableViewDataSource>
// tableView
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation PersonalInfoViewController
// infoList的懒加载
@synthesize infoList = _infoList;
- (UserInfo *)infoList
{
    if (!_infoList)
        _infoList = [[UserInfo alloc] init];
    return _infoList;
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
    // 返回按钮
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"返回上一级" style:UIBarButtonItemStylePlain target:self action:@selector(ReturnOnClick:)];
    [cancelButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = cancelButton;
    // 1. 中间单元表
    CGFloat tableViewWidth = screen.size.width;
    CGFloat tableViewTopView = 60;
    CGFloat tabViewHeight = 50 * 6 + 60 * 2 + tableViewTopView;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewTopView, tableViewWidth, tabViewHeight) style: UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[InfoCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.02];
    [self.view addSubview:self.tableView];
    
    UIButton *CompleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat CompleteButtonWidth = 160;
    CGFloat CompleteButtonHeight = 40;
    CGFloat CompleteButtonTopView = 600;
    CompleteButton.frame = CGRectMake((screen.size.width - CompleteButtonWidth) / 2, CompleteButtonTopView, CompleteButtonWidth, CompleteButtonHeight);
    [CompleteButton setTitle:@"完 成" forState:UIControlStateNormal];
    CompleteButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:26];
    [CompleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CompleteButton.backgroundColor = [UIColor colorWithRed:238 / 255.0 green: 173 / 255.0 blue:14 / 255.0 alpha:1];
    [CompleteButton addTarget:self action:@selector(CompleteOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CompleteButton];
    //[self print];
}


#pragma mark -- UITableDateSource 和 delegate 协议方法
// 返回每个section中row个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// 返回section个数，两列section无区别，只是为了设计上的美观
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

// 每个cell的设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[InfoCell alloc] init];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

// 设置每个cell中的数据信息，将数据加载放到willDisPlay中加快加载速度
- (void)tableView:(UITableView *)tableView willDisplayCell:(InfoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    if (section == 0)
    {
        switch (row) {
            case 0:
                cell.infoName.text = @"手机号";
                cell.infoContent.text = self.infoList.phoneNumber;
                break;
            case 1:
                cell.infoName.text = @"邮箱";
                cell.infoContent.text = self.infoList.Email;
                break;
            case 2:
                cell.infoName.text = @"个人介绍";
                cell.infoContent.text = self.infoList.Introduction;
                break;
            default:
                break;
        }
    }
    else
    {
        switch (row) {
            case 0:
                cell.infoName.text = @"性别";
                cell.infoContent.text = self.infoList.Sex;
                break;
            case 1:
                cell.infoName.text = @"生日";
                cell.infoContent.text = self.infoList.Birthday;
                break;
            case 2:
                cell.infoName.text = @"地区";
                cell.infoContent.text = self.infoList.Region;
                break;
            default:
                break;
        }
    }
}

// 每个section的表头内容
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"";
    else
        return @" ";
}

// 每个section的表头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

// 每个section的表头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

// 每列row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

// cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    InfoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (section == 0)
    {
        switch (row) {
            case 0:
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                alert.title = @"请输入手机号";
                alert.view.backgroundColor = [UIColor whiteColor];
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"请输入手机号";
                    textField.keyboardType = UIKeyboardTypeNumberPad;
                }];
                UIAlertAction *createAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 传值
                    self.infoList.phoneNumber = cell.infoContent.text = [alert.textFields firstObject].text;
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:createAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
                break;
            }
            case 1:
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                alert.title = @"请输入你的邮箱";
                alert.view.backgroundColor = [UIColor whiteColor];
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.keyboardType = UIKeyboardTypeEmailAddress;
                    textField.placeholder = @"请填入邮箱号";
                }];
                UIAlertAction *createAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 传值
                    self.infoList.phoneNumber = cell.infoContent.text = [alert.textFields firstObject].text;
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:createAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
                break;
            }
            case 2:
            {
                // 调用自定义的textField
                inputViewController *input = [[inputViewController alloc] init];
                input.modalPresentationStyle = UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
                // target-action传值
                input.target = self;
                input.action = @selector(getInputIntroduction:);
                [self presentViewController:input animated:YES completion:^{
                }];
                break;
            }
            default:
                break;
        }
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        switch (row) {
            case 0:
            {
                alert.title = @"选择你的性别";
                UIAlertAction *manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 传值
                    self.infoList.Sex = cell.infoContent.text = @"男";
                }];
                UIAlertAction *womanAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 传值
                    self.infoList.Sex = cell.infoContent.text = @"女";
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:manAction];
                [alert addAction:womanAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
                break;
            }
            case 1:
            {
                alert.title = @"选择你的生日";
                alert.message = @"\n\n\n\n\n\n\n\n\n\n";
                UIDatePicker *datePicker = [[UIDatePicker alloc] init];
                CGRect pickerFrame = datePicker.frame;
                datePicker.frame = CGRectMake((alert.view.frame.size.width - pickerFrame.size.width) / 2, pickerFrame.origin.y + 25, datePicker.frame.size.width, datePicker.frame.size.height);
                //简体中文设置
                datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
                datePicker.datePickerMode = UIDatePickerModeDate;
                [alert.view addSubview:datePicker];
                UIAlertAction *createAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSDate *theDate = datePicker.date;
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    dateFormatter.dateFormat = @"YYYY-MM-dd";
                    // 传值
                    self.infoList.Birthday = cell.infoContent.text = [dateFormatter stringFromDate:theDate];
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:createAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:^{
                }];
                break;
            }
            case 2:
            {
                PlacePicker *placePicker = [[PlacePicker alloc] init];
                placePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
                placePicker.sendValueBlock = ^(NSMutableDictionary *value) {
                    cell.infoContent.text = [NSString stringWithFormat:@"%@:%@:%@", value[@"province"], value[@"city"], value[@"district"]];
                };
                [self presentViewController:placePicker animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
    }
}

- (void)CompleteOnClick:(id)sender
{
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
    InfoCell *cell1 = [self.tableView cellForRowAtIndexPath:indexPath1];
    InfoCell *cell2 = [self.tableView cellForRowAtIndexPath:indexPath2];
    if (![self checkPhone:cell1.infoContent.text])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请重新输入手机号" message:@"未输入手机号或手机号格式不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (![self checkEmail:cell2.infoContent.text])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请重新输入邮箱" message:@"未输入邮箱或邮箱格式不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        id LoginController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3];
        // 将注册的用户名传给登录视图
        [LoginController setValue:self.infoList.UserName forKeyPath:@"UserNameTextField.text"];
        // 将InfoList的个人信息写入数据库
        // InsertModel(self.infoList);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)ReturnOnClick:(id)sender
{
    SignUpViewController *signUpController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    // 清除掉上一级输入的密码
    [signUpController setValue:@"" forKeyPath:@"PassWordTextField.text"];
    [signUpController setValue:@"" forKeyPath:@"ConfirmPassWordTextField.text"];
    [self.navigationController popViewControllerAnimated:YES];
}

// just for test
/*
-(void)print
{
    NSLog(@"%@", self.infoList.UserName);
    NSLog(@"%@", self.infoList.PassWord);
    NSLog(@"%@", self.infoList.Birthday);
    NSLog(@"%@", self.infoList.Sex);
    NSLog(@"%@", self.infoList.Introduction);
    NSLog(@"%@", self.infoList.UserIcon);
}
*/

// target-section获取InPutView输入的文本
- (void) getInputIntroduction:(NSString *)introduction
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    InfoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    // 传值
    self.infoList.Introduction = cell.infoContent.text = introduction;
}

//判断是否为电话号码
- (BOOL)checkPhone:(NSString *)mobileNum {
    NSString * MOBILE = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}

- (BOOL)checkEmail:(NSString *)email{
    NSString *regex =@"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:email];
}

@end
