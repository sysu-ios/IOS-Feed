//
//  AddPhoto.m
//  testProject
//
//  Created by 王睿泽 on 2019/5/20.
//  Copyright © 2019 王睿泽. All rights reserved.
//

#define MaxColumn 3 // 每行显示数量
#define MaxImageCount 9 // 最多显示图片个数
#define deleImageWH 20 // 删除按钮的宽高
#define AddIcon @"add.jpeg" // 添加按钮图片



#import "AddPhoto.h"
@interface AddPhoto()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    // 标识被编辑的按钮 -1 为添加新的按钮
    NSInteger editTag;
}
@end

@implementation AddPhoto

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [self createButtonWithImage:AddIcon andSeletor:@selector(addNew:)];
        [self addSubview:btn];
    }
    return self;
}

-(NSMutableArray *)photos{
    if(!_photos){
        _photos = [NSMutableArray array];
    }
    return _photos;
}

// 添加新的控件
- (void)addNew:(UIButton *)btn
{
    // 标识为添加一个新的图片
    editTag = -1;
    [self callImagePicker];
}

// 修改旧的控件
- (void)changeOld:(UIButton *)btn
{
    editTag = btn.tag;
    [self callImagePicker];
}

// 调用图片选择器
- (void)callImagePicker
{
    UIImagePickerController *pc = [[UIImagePickerController alloc] init];
    pc.allowsEditing = YES;
    pc.delegate = self;
    [self.window.rootViewController presentViewController:pc animated:YES completion:nil];
}


// 根据图片名称或者图片创建一个新的显示控件
- (UIButton *)createButtonWithImage:(id)imageNameOrImage andSeletor : (SEL)selector
{
    UIImage *addImage = nil;
    if ([imageNameOrImage isKindOfClass:[NSString class]]) {
        addImage = [UIImage imageNamed:imageNameOrImage];
    }
    else if([imageNameOrImage isKindOfClass:[UIImage class]])
    {
        addImage = imageNameOrImage;
    }
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:addImage forState:UIControlStateNormal];
    [addBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = self.subviews.count;
    
    if(self.subviews.count != 0) {
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeContactAdd];
        dele.bounds = CGRectMake(0, 0, deleImageWH, deleImageWH);
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        dele.frame = CGRectMake(self.frame.size.width / 3 - 2 - dele.frame.size.width, 0, dele.frame.size.width, dele.frame.size.height);
        dele.transform = CGAffineTransformRotate(dele.transform, M_PI_4);
        dele.tintColor = [UIColor whiteColor];
        
        [addBtn addSubview:dele];
    }
    return addBtn;
    
}


// 删除图片
- (void)deletePic : (UIButton *)btn
{
    [self.photos removeObject:[(UIButton *)btn.superview imageForState:UIControlStateNormal]];
    [btn.superview removeFromSuperview];
    if ([[self.subviews lastObject] isHidden]) {
        [[self.subviews lastObject] setHidden:NO];
    }
    //通知代理
    [_delegate DidPhotoChanged];
}

// 对所有子控件进行布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    unsigned long count = self.subviews.count;
    CGFloat btnW = self.frame.size.width / 3 - 2;
    CGFloat btnH = btnW;
    CGFloat marginX = 2;
    CGFloat marginY = marginX;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnX = (i % MaxColumn) * (marginX + btnW) + marginX;
        CGFloat btnY = (i / MaxColumn) * (marginY + btnH) + marginY;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}

#pragma mark - UIImagePickerController 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (editTag == -1) {
        // 创建一个新的控件
        UIButton *btn = [self createButtonWithImage:image andSeletor:@selector(changeOld:)];
        [self insertSubview:btn atIndex:self.subviews.count - 1];
        [self.photos addObject:image];
        if (self.subviews.count - 1 == MaxImageCount) {
            [[self.subviews lastObject] setHidden:YES];
            
        }
    }
    else
    {
        // 根据tag修改需要编辑的控件
        UIButton *btn = (UIButton *)[self viewWithTag:editTag];
        unsigned long index = [self.photos indexOfObject:[btn imageForState:UIControlStateNormal]];
        [self.photos removeObjectAtIndex:index];
        [btn setImage:image forState:UIControlStateNormal];
        [self.photos insertObject:image atIndex:index];
    }
    // 退出图片选择控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //通知代理
    [_delegate DidPhotoChanged];
}

@end
