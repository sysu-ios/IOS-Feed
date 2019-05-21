//
//  MyInfoViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/17.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "MyInfoViewController.h"
#import "InfoCell.h"
#import "SignUpViewController.h"
#import "inputViewController.h"
#import "PlacePicker/PlacePicker.h"
#define cellIdentifier  @"CellIdentifier"

@interface MyInfoViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *HeadImageView;
@end

@implementation MyInfoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

// 从数据库加载数据
- (void)loadData
{
    // 从数据库加载数据
    self.infoList = [[UserModel alloc] init];
    // self.infoList from database
    // 。。。。。。
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
    // 1. 中间单元表
    CGFloat tableViewWidth = screen.size.width;
    CGFloat tableViewTopView = 60;
    CGFloat tabViewHeight = 50 * 7 + 60 * 2 + tableViewTopView;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewTopView, tableViewWidth, tabViewHeight) style: UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[InfoCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.02];
    [self.view addSubview:self.tableView];
    
    self.HeadImageView = [[UIImageView alloc] initWithImage:self.infoList.UserIcon];
    self.HeadImageView.frame = CGRectMake(160, 0, 45, 45);
    self.HeadImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.02];
}


#pragma mark -- UITableDateSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 4;
    else
        return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[InfoCell alloc] init];
    }
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.02];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(InfoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    if (section == 0)
    {
        switch (row) {
            case 0:
            {
                cell.infoName.text = @"头像";
                CGRect Frame = cell.infoName.frame;
                // 1. 添加infoName label
                cell.infoName.frame = CGRectMake(Frame.origin.x, Frame.origin.y + 15, Frame.size.width, Frame.size.height);
                [cell.infoContent addSubview:self.HeadImageView];
            }
                break;
            case 1:
                cell.infoName.text = @"手机号";
                cell.infoContent.text = self.infoList.PhoneNumber;
                break;
            case 2:
                cell.infoName.text = @"邮箱";
                cell.infoContent.text = self.infoList.Email;
                break;
            case 3:
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 200, 60);
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 8, view.frame.size.width, view.frame.size.height);
    NSArray *titles = @[[NSString stringWithFormat:@"用户名：%@", self.infoList.UserName], @" "];
    label.text = titles[section];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size: 20];
    [view addSubview:label];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0 && [indexPath row] == 0)
        return 65;
    return 50;
}

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
                [self changeUserIconAction];
                self.infoList.UserIcon = self.HeadImageView.image;
                // 写入数据库
                // InsertUserIcon
            }
                break;
            case 1:
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                alert.title = @"请输入手机号";
                alert.view.backgroundColor = [UIColor whiteColor];
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"请输入手机号";
                    textField.keyboardType = UIKeyboardTypeNumberPad;
                }];
                UIAlertAction *createAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.infoList.phoneNumber = cell.infoContent.text = [alert.textFields firstObject].text;
                    // 写入数据库
                    // InsertPhoneNumber
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
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                alert.title = @"请输入你的邮箱";
                alert.view.backgroundColor = [UIColor whiteColor];
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.keyboardType = UIKeyboardTypeEmailAddress;
                    textField.placeholder = @"请填入邮箱号";
                }];
                UIAlertAction *createAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 写入数据库
                    // InsertEmail
                    self.infoList.Email = cell.infoContent.text = [alert.textFields firstObject].text;
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:createAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
                break;
            }
            case 3:
            {
                inputViewController *input = [[inputViewController alloc] init];
                input.modalPresentationStyle = UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
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
                    self.infoList.Sex = cell.infoContent.text = @"男";
                    // 写入数据库
                    // InsertSex
                }];
                UIAlertAction *womanAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.infoList.Sex = cell.infoContent.text = @"女";
                    // 写入数据库
                    // InsertSex
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
                    self.infoList.Birthday = cell.infoContent.text = [dateFormatter stringFromDate:theDate];
                    // 写入数据库
                    // InsertBirthday
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
                // 写入数据库
                // InsertPlace
                [self presentViewController:placePicker animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
    }
}

- (void) getInputIntroduction:(NSString *)introduction
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    InfoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.infoList.Introduction = cell.infoContent.text = introduction;
    // 写入数据库
    // InsertIntroduction
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

//更换头像
- (void)changeUserIconAction
{
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
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
