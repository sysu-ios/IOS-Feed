//
//  MyToolBar.m
//  testProject
//
//  Created by 王睿泽 on 2019/5/22.
//  Copyright © 2019 王睿泽. All rights reserved.
//

#import "MyToolBar.h"

@implementation MyToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        //键盘
        UIButton *buttonKeyboard = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonKeyboard setImage:[UIImage imageNamed:@"keyboard.jpg"] forState:UIControlStateNormal];
        buttonKeyboard.tag = TagKeyboard;
        
        // 按钮点击事件
        [buttonKeyboard addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:buttonKeyboard];
        
        //提及用户@
        UIButton *buttonMention = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonMention setTitle:@"@" forState:UIControlStateNormal];
        buttonMention.titleLabel.font = [UIFont systemFontOfSize:25];
        [buttonMention setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [buttonMention setTitleColor:UIColor.orangeColor forState:UIControlStateHighlighted];
        buttonMention.tag = TagMention;
        // 按钮点击事件
        [buttonMention addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:buttonMention];
        
        //话题
        UIButton *buttonTopic = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonTopic setTitle:@"#" forState:UIControlStateNormal];
        buttonTopic.titleLabel.font = [UIFont systemFontOfSize:25];
        [buttonTopic setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [buttonTopic setTitleColor:UIColor.orangeColor forState:UIControlStateHighlighted];
        buttonTopic.tag = TagTopic;
        // 按钮点击事件
        [buttonTopic addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:buttonTopic];
        
        //话题
        UIButton *buttonEmotion = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonEmotion setTitle:@"🈚️" forState:UIControlStateNormal];
        buttonEmotion.titleLabel.font = [UIFont systemFontOfSize:25];
        [buttonEmotion setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [buttonEmotion setTitleColor:UIColor.orangeColor forState:UIControlStateHighlighted];
        buttonEmotion.tag = TagEmotion;
        // 按钮点击事件
        [buttonEmotion addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:buttonEmotion];
        
    }
    
    return self;
}

/** 添加一个按钮 */
- (void) addButtonWithIcon:(NSString *) icon tag:(MyToolBarButtonTag) tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    button.tag = tag;
    
    // 按钮点击事件
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
}

/** 设置frame */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonWidth = 40;
    CGFloat buttonHeight = buttonWidth;
    CGFloat buttonY = 2.5;
    
    UIButton *button0 = self.subviews[0];
    button0.frame = CGRectMake(15, buttonY, buttonWidth, buttonHeight);
    
    // 设置每个按钮
    for (int i = 1; i<self.subviews.count; i++) {
        
        UIButton *button = self.subviews[i];
        
        CGFloat buttonHeight = buttonWidth;
        CGFloat buttonX = self.frame.size.width - (4 - i) * (15 + buttonWidth) ;
        CGFloat buttonY = 2.5;
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    }
}

/** 按钮点击 */
- (void) buttonClicked:(UIButton *) button {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didButtonClicked:)]) {
        [self.delegate composeToolBar:self didButtonClicked:button.tag];
    }
}

@end
