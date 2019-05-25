//
//  OutlineFrame.m
//  Feed
//
//  Created by student8 on 2019/5/11.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#define kCellBorder 10
#define kIconWH 40
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#import "OutlineFrame.h"
#import "Outline.h"

@implementation OutlineFrame

-(id) initOutlineFrame:(Outline *)outline
{
    _outline = outline;
    
    //具有3张配图时标题和图片的位置大小设置
    if (_outline.imageList.count > 2) {
        //1.标题位置大小设置
        CGFloat titleX = kCellBorder;
        CGFloat titleY = kCellBorder;
        CGRect contentSize = [self getContentFrameDynamic: _outline.title selectFrameType:1];
        _titleFrame = CGRectMake(titleX, titleY, contentSize.size.width, contentSize.size.height);
    
        //2.3张配图的位置大小设置
        CGFloat picX = titleX;
        CGFloat picY = CGRectGetMaxY(_titleFrame) +kCellBorder;
        _picFrame1 = CGRectMake(picX, picY, 120, 90);
        _picFrame2 = CGRectMake(picX+120+kCellBorder, picY, 120, 90);
        _picFrame3 = CGRectMake(picX+240+2*kCellBorder, picY, 120, 90);
    }
    //只有一张配图时标题和图片的位置大小设置
    else {
        //1.标题位置大小设置
        CGFloat titleX = kCellBorder;
        CGFloat titleY = kCellBorder;
        CGRect contentSize = [self getContentFrameDynamic: _outline.title selectFrameType:2];
        _titleFrame = CGRectMake(titleX, titleY, contentSize.size.width, contentSize.size.height);
        
        //2.1张配图的位置大小设置
        CGFloat picX = SCREEN_WIDTH -120 - kCellBorder;
        CGFloat picY = titleY;
        _picFrame1 = CGRectMake(picX, picY, 120, 90);
    }
    
    //3.作者名字位置大小设置
    CGFloat nameX = kCellBorder;
    CGFloat nameY = CGRectGetMaxY(_picFrame1) +kCellBorder;
    CGSize nameSize = [self getLabelHeighDynamic:_outline.name];
    _nameFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    //4.评论数位置大小设置
    CGFloat commentX = CGRectGetMaxX(_nameFrame) + kCellBorder;
    CGFloat commentY = nameY;
    CGSize commentSize = [self getLabelHeighDynamic:_outline.comment];
    _commentFrame = CGRectMake(commentX, commentY, commentSize.width, commentSize.height);
    
    //5.发布时间位置大小设置
    CGFloat timeX = CGRectGetMaxX(_commentFrame) + kCellBorder;
    CGFloat timeY = nameY;
    CGSize timeSize =  [self getLabelHeighDynamic:_outline.time];
    _timeFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    _cellHeight = CGRectGetMaxY(_timeFrame) + kCellBorder;
    
    
    
    return self;
}

#pragma 根据文字长度动态确定label的高度
-(CGSize)getLabelHeighDynamic:(NSString *)word
{
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
    CGSize size = [word sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    return size;
}

#pragma 根据正文内容多少,动态确定正文content的frame

-(CGRect)getContentFrameDynamic:(NSString *)word selectFrameType:(NSInteger)frame_type
{
    // 宽度W
    CGFloat contentW;
    if(frame_type == 1) {
        contentW = SCREEN_WIDTH - 2 *kCellBorder;
    }
    else {
        contentW = SCREEN_WIDTH - 3 *kCellBorder - 120;
    }
    // label的字体 HelveticaNeue  Courier
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
    CGRect tmpRect = [word boundingRectWithSize:CGSizeMake(contentW, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    
    return tmpRect;
    
}
@end
