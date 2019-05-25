//
//  OutlineFrame.h
//  Feed
//
//  Created by student8 on 2019/5/11.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Outline;
@interface OutlineFrame : NSObject
// 作者名字的frame
@property (nonatomic,assign,readonly) CGRect nameFrame;
// 作者头像的frame
@property (nonatomic,assign,readonly) CGRect avatarFrame;
// 作者身份的frame
@property (nonatomic,assign,readonly) CGRect identityFrame;
// 发表时间的frame
@property (nonatomic,assign,readonly) CGRect timeFrame;
// 标题的frame
@property (nonatomic,assign,readonly) CGRect titleFrame;
// 评论数的frame
@property (nonatomic,assign,readonly) CGRect commentFrame;
@property (nonatomic,assign,readonly) CGRect commentPicFrame;
// 点赞数的frame
@property (nonatomic,assign,readonly) CGRect likeFrame;
@property (nonatomic,assign,readonly) CGRect likePicFrame;
// 转发数的frame
@property (nonatomic,assign,readonly) CGRect transmitFrame;
@property (nonatomic,assign,readonly) CGRect transmitPicFrame;
// 大图片的frame
@property (nonatomic,assign,readonly) CGRect picFrame1;
@property (nonatomic,assign,readonly) CGRect picFrame2;
@property (nonatomic,assign,readonly) CGRect picFrame3;
// 整个cell的高度
@property (nonatomic,assign,readonly) CGFloat cellHeight;
// cell数据内容模型
@property (nonatomic,strong) Outline *outline;

-(id) initOutlineFrame:(Outline *)outline chooseStyle:(int)style;

@end
