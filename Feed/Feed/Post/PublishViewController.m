//
//  PublishViewController.m
//  testProject
//
//  Created by 王睿泽 on 2019/5/18.
//  Copyright © 2019 王睿泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublishViewController.h"
#import "MyTextView.h"
#import "AddPhoto.h"
#import "MyToolBar.h"

@interface PublishViewController ()

@property(strong,nonatomic)UIScrollView *myScrollView;      //滑动视图
@property (nonatomic,strong)UIBarButtonItem *leftButton;    //左侧导航栏按钮
@property (nonatomic,strong)UIBarButtonItem *rightButton;    //右侧导航栏按钮
@property (nonatomic,strong)MyTextView *inputTextView;      //文字输入框
@property (nonatomic,strong)AddPhoto *addPhotoView;         //文字输入框
@property(nonatomic, weak) MyToolBar *toolBar;              //工具栏

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //点击空白处收键盘
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    [self setup];

}

- (void)setup
{
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.myScrollView.backgroundColor=[UIColor whiteColor];
    //内容面板大小
    self.myScrollView .contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 100);
    self.myScrollView.delegate=(id)self;
    [self.view addSubview: self.myScrollView];
    
    [self setupNavigationButton];
    [self setupInputText];
    [self setupPhotoPicker];
    [self setupToolBar];
    
    // 监听键盘通知
    // 键盘将弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // 键盘将缩回
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) setupNavigationButton {
    UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonL.frame = CGRectMake(-15, 0, 50, 50);
    [buttonL setTitle:@"取消" forState:UIControlStateNormal];
    buttonL.titleLabel.font = [UIFont systemFontOfSize:16];
    [buttonL setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [buttonL setAdjustsImageWhenHighlighted:NO];
    buttonL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [buttonL addTarget:self action:@selector(onClickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewL = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];
    [viewL addSubview:buttonL];
    self.leftButton =  [[UIBarButtonItem alloc] initWithCustomView:viewL];
    
    self.navigationItem.leftBarButtonItems = @[self.leftButton];
    
    UIButton *buttonR = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonR.frame = CGRectMake(15, 0, 50, 50);
    [buttonR setTitle:@"发布" forState:UIControlStateNormal];
    buttonR.titleLabel.font = [UIFont systemFontOfSize:16];
    [buttonR setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [buttonR setAdjustsImageWhenHighlighted:NO];
    buttonR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [buttonR addTarget:self action:@selector(onClickSend:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewR = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];
    [viewR addSubview:buttonR];
    self.rightButton =  [[UIBarButtonItem alloc] initWithCustomView:viewR];
    
    self.navigationItem.rightBarButtonItems = @[self.rightButton];
    self.navigationItem.rightBarButtonItem.enabled = false;
    self.navigationItem.rightBarButtonItem.customView.alpha = 0.4;
}

//设置文字输入框
- (void) setupInputText {
    self.inputTextView = [[MyTextView alloc] initWithFrame:self.myScrollView.frame];
    self.inputTextView.frame = CGRectMake(10, 10, self.view.frame.size.width - 20, 200);
    self.inputTextView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    self.inputTextView.font = [UIFont fontWithName:@"Arial" size:17];//设置字体名字和字体大小
    self.inputTextView.delegate = (id)self;//设置它的委托方法
    self.inputTextView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    self.inputTextView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    self.inputTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.inputTextView.scrollEnabled = YES;//是否可以拖动
    self.inputTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.inputTextView.placeholder = @"You were the one, and it was enough...";
    [self.myScrollView addSubview:self.inputTextView];
}

//设置图片选择器
- (void) setupPhotoPicker {
    self.addPhotoView = [[AddPhoto alloc] initWithFrame:self.myScrollView.frame];
    self.addPhotoView.backgroundColor = [UIColor whiteColor];
    self.addPhotoView.frame = CGRectMake(10, 30 + self.inputTextView.frame.size.height, self.view.frame.size.width - 20, 400);
    self.addPhotoView.delegate = (id)self;
    [self.myScrollView addSubview:self.addPhotoView];
}

// 设置工具栏
- (void) setupToolBar {
    MyToolBar *toolBar = [[MyToolBar alloc] init];
    self.toolBar = toolBar;
    toolBar.frame = CGRectMake(0, self.view.frame.size.height - 45, self.view.frame.size.width, 90);
    toolBar.delegate = (id)self;
    
    [self.view addSubview:toolBar];
}

#pragma mark - 移动工作条
// 键盘将弹出
- (void) keyboardWillShow:(NSNotification *) note {
    // 键盘弹出需要时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 移动工具条
    [UIView animateWithDuration:duration animations:^{
        // 获取键盘高度
        CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardHeight = keyboardFrame.size.height;
        
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -1 * keyboardHeight);
    }];
}

// 键盘将缩回
- (void) keyboardWillHide:(NSNotification *) note {
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 移动工具条
    [UIView animateWithDuration:duration animations:^{
//        self.toolBar.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height - self.toolBar.frame.origin.y - 200);
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -45);
    }];
}

#pragma mark --收起键盘
// 滑动空白处隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.inputTextView endEditing:YES];
}

// 点击空白处收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.inputTextView endEditing:YES];
}

#pragma mark - MyToolBarDelegate
/** 工具栏的按钮被点击了 */
- (void)composeToolBar:(MyToolBar *)composeToolBar didButtonClicked:(MyToolBarButtonTag)tag {
    // 判断哪个按钮被点击
    switch (tag) {
        case TagKeyboard: // 键盘
            if(!self.inputTextView.isFirstResponder) {
                [self.inputTextView becomeFirstResponder];
            }
            else {
                [self.inputTextView endEditing:YES];
            }
            break;
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.inputTextView becomeFirstResponder];
}

- (void)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onClickSend:(id)sender {
    self.text = self.inputTextView.text;
    self.pictures = self.addPhotoView.photos;
    
    //将数据发往数据库
    
    
    //回到上一界面
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AddPhotoDelegate
- (void) DidPhotoChanged {
    if(self.inputTextView.text.length != 0 || self.addPhotoView.photos.count != 0) {
        self.navigationItem.rightBarButtonItem.enabled = true;
        self.navigationItem.rightBarButtonItem.customView.alpha = 1;
    }
    else {
        self.navigationItem.rightBarButtonItem.enabled = false;
        self.navigationItem.rightBarButtonItem.customView.alpha = 0.4;
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.markedTextRange == nil) {
        if(self.inputTextView.text.length != 0 || self.addPhotoView.photos.count != 0) {
            self.navigationItem.rightBarButtonItem.enabled = true;
            self.navigationItem.rightBarButtonItem.customView.alpha = 1;
        }
        else {
            self.navigationItem.rightBarButtonItem.enabled = false;
            self.navigationItem.rightBarButtonItem.customView.alpha = 0.4;
        }
    }
}


@end
