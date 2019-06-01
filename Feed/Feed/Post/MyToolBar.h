//
//  MyToolBar.h
//  testProject
//
//  Created by 王睿泽 on 2019/5/22.
//  Copyright © 2019 王睿泽. All rights reserved.
//

#ifndef MyToolBar_h
#define MyToolBar_h


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MyToolBarButtonTag) {
    TagKeyboard, //键盘
    TagMention, // 提到@
    TagTopic, // 话题
    TagEmotion // 表情
};

@class MyToolBar;
@protocol MyToolBarDelegate <NSObject>

@optional

- (void) composeToolBar:(MyToolBar *) composeToolBar didButtonClicked:(MyToolBarButtonTag) tag;

@end

@interface MyToolBar : UIView

/** 代理 */
@property(nonatomic, strong) id<MyToolBarDelegate> delegate;

@end

#endif /* MyToolBar_h */
