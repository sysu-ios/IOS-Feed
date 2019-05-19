//
//  inputViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/16.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

// 用于个人介绍弹出的输入框

#import "inputViewController.h"
#define TabBarHeight 49
@interface inputViewController () <UITextViewDelegate>
// textView
@property (nonatomic, strong) UITextView *textView;
// placeHoldLabel
@property (nonatomic, strong) UILabel *placeHoldLabel;
// noticeLabel
@property (nonatomic, strong) UILabel *noticeLabel;
// cancel button
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation inputViewController

// 懒加载
-(UITextView *)textView
{
    if (!_textView)
        _textView = [[UITextView alloc] init];
    return _textView;
}

-(UILabel *)placeHoldLabel
{
    if (!_placeHoldLabel)
        _placeHoldLabel = [[UILabel alloc] init];
    return _placeHoldLabel;
}

-(UILabel *)noticeLabel
{
    if (!_noticeLabel)
        _noticeLabel = [[UILabel alloc] init];
    return _noticeLabel;
}

-(UIButton *)cancelButton
{
    if (!_cancelButton)
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    return _cancelButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    CGRect screen = [[UIScreen mainScreen] bounds];
    // 添加文本框
    CGFloat textViewHeight = 160;
    self.textView.frame = CGRectMake(0, screen.size.height - textViewHeight - TabBarHeight, screen.size.width, textViewHeight);
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDefault;
    self.textView.keyboardType = UIKeyboardTypeDefault;
    self.textView.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.view addSubview:self.textView];
    // 添加占位符
    CGFloat leftView = 5;
    CGFloat rightView = 5;
    self.placeHoldLabel.frame = CGRectMake(leftView, 5, screen.size.width / 2 - leftView, 25);
    self.placeHoldLabel.enabled = NO;
    self.placeHoldLabel.font = [UIFont systemFontOfSize:12];
    self.placeHoldLabel.numberOfLines = 0;
    self.placeHoldLabel.text = @"请输入你的详细介绍";
    [self.textView addSubview:self.placeHoldLabel];
    // 添加限制字符通知
    self.noticeLabel.frame = CGRectMake(screen.size.width / 2, textViewHeight - TabBarHeight - 10, screen.size.width / 2 - rightView, 25);
    self.noticeLabel.textAlignment = NSTextAlignmentRight;
    self.noticeLabel.text = @"你还可以输入50字";
    self.noticeLabel.numberOfLines = 0;
    self.noticeLabel.font = [UIFont systemFontOfSize:12];
    self.noticeLabel.enabled = NO;
    [self.textView addSubview:self.noticeLabel];
    // 添加cancaelButton
    self.cancelButton.frame = CGRectMake(5, textViewHeight - TabBarHeight - 10, 50, 30);
    self.cancelButton.backgroundColor = [UIColor clearColor];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;;
    [self.cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.textView addSubview:self.cancelButton];
}

#pragma mark -- textView Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.textView.text length] == 0) {
        [self.placeHoldLabel setHidden:NO];
    }
    else
    {
        [self.placeHoldLabel setHidden:YES];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if ([self.target respondsToSelector:self.action])
            [self.target performSelector:self.action withObject:self.textView.text];
        [textView resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        return NO;
    }
    if (range.location >= 50) {
        self.noticeLabel.text = @"还能输入0字";
        return NO;
    }
    else
    {
        self.noticeLabel.text = [NSString stringWithFormat:@"还能输入%lu字", 50 - range.location - 1];
        return YES;
    }
}

// 键盘弹出时调用，响应对键盘的监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 获取键盘frame
    CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 获取键盘弹出时长
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat end = endFrame.origin.y != screenH?endFrame.size.height:0;
    // 修改底部视图距离底部的间距
    CGRect screen = [[UIScreen mainScreen] bounds];
    // 添加文本框
    CGFloat textViewHeight = 160;
    self.textView.frame = CGRectMake(0, screen.size.height - textViewHeight - end, screen.size.width, textViewHeight);
    //self.textView.frame = CGRectMake(0, self.textView.frame.origin.y - endFrame.origin.y, self.textView.frame.size.width, self.textView.frame.size.height);
    // 约束动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

// 取消输入
- (void)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
