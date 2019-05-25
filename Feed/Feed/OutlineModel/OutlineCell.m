///
//  OutlineCell.m
//  Feed
//
//  Created by student8 on 2019/5/11.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "OutlineCell.h"
#import "Outline.h"
#import "OutlineFrame.h"

#define kCellBorder 10
#define kIconWH 40

@interface OutlineCell()
{
    UILabel *_name;
    UIImageView *_avatar;
    UILabel *_identity;
    UILabel *_title;
    UIImageView *_pic1;
    UIImageView *_pic2;
    UIImageView *_pic3;
    UILabel *_time;
    UILabel *_comment;
    UIImageView *_commentImage;
    UILabel *_like;
    UIImageView *_likeImage;
    UILabel *_transmit;
    UIImageView *_transmitImage;
}

@end

@implementation OutlineCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //不清楚高度则先添加基本得内部所有子控件
        [self setData];
    }
    
    return self;
}

#pragma  设置数据以及高度frame
-(void)setOutlineframe:(OutlineFrame *)outlineframe
{
    _outlineframe = outlineframe;
    
    //2.设置概况数据
    [self settingOutlineData];
    
    //3.设置子控件的frame
    [self settingOutlineFrame];
}

#pragma  设置数据
-(void)settingOutlineData
{
    Outline *outline = _outlineframe.outline;
    
    _name.text = outline.name;
    NSURL *url1 = [NSURL URLWithString:outline.imageList[0]];//url请求实在UI主线程中进行的
    _avatar.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url1]];//通过网络url获取UIImage
    _identity.text = outline.identity;
    
    _title.text = outline.title;
    _title.numberOfLines = 0;
    
    _time.text = [outline.time stringByAppendingString:@" · "];
    _comment.text = outline.comment;
    _commentImage.image = [UIImage imageNamed:@"评论"];
    _like.text = outline.like;
    _likeImage.image = [UIImage imageNamed:@"登录头像"];
    _transmit.text = outline.share;
    _transmitImage.image = [UIImage imageNamed:@"登录头像"];
    
    // 配图
    if (outline.imageList.count > 0) {
        NSURL *url1 = [NSURL URLWithString:outline.imageList[0]];//url请求实在UI主线程中进行的
        _pic1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url1]];//通过网络url获取UIImage
    }
    if (outline.imageList.count > 1) {
        NSURL *url2 = [NSURL URLWithString:outline.imageList[1]];//url请求实在UI主线程中进行的
        _pic2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url2]];//通过网络url获取UIImage
    }
    if (outline.imageList.count > 2) {
        NSURL *url3 = [NSURL URLWithString:outline.imageList[2]];//url请求实在UI主线程中进行的
        _pic3.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url3]];//通过网络url获取UIImage
    }

}

#pragma  设置概况高度frame
-(void) settingOutlineFrame
{
    //1.标题
    _title.frame = _outlineframe.titleFrame;
    
    //2.配图
    if (_outlineframe.outline.imageList.count > 2) {
        _pic1.frame = _outlineframe.picFrame1;
        _pic2.frame = _outlineframe.picFrame2;
        _pic3.frame = _outlineframe.picFrame3;
    }
    else {
        _pic1.frame = _outlineframe.picFrame1;
    }
    
    //3.昵称，头像，身份
    _name.frame = _outlineframe.nameFrame;
    _avatar.frame = _outlineframe.avatarFrame;
    _identity.frame = _outlineframe.identityFrame;
    
    //4.评论数，点赞数
    _comment.frame = _outlineframe.commentFrame;
    _commentImage.frame = _outlineframe.commentPicFrame;
    _like.frame = _outlineframe.likeFrame;
    _likeImage.frame = _outlineframe.likePicFrame;
    _transmit.frame = _outlineframe.transmitFrame;
    _transmitImage.frame = _outlineframe.transmitPicFrame;
 
    //5.时间
    _time.frame = _outlineframe.timeFrame;
}



#pragma  添加基本的内部控件
-(void)setData
{
    //1.标题
    _title= [[UILabel alloc] init];
    [self.contentView addSubview:_title];
    
    //2.配图
    _pic1= [[UIImageView alloc] init];
    [self.contentView addSubview:_pic1];
    _pic2= [[UIImageView alloc] init];
    [self.contentView addSubview:_pic2];
    _pic3= [[UIImageView alloc] init];
    [self.contentView addSubview:_pic3];
    
    //3.作者
    _name = [[UILabel alloc] init];
    _name.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview: _name];
    _avatar = [[UIImageView alloc] init];
    _avatar.layer.cornerRadius = 25.0f; //圆形头像
    _avatar.layer.masksToBounds = YES;
    [self.contentView addSubview: _avatar];
    _identity = [[UILabel alloc] init];
    _identity.font = [UIFont systemFontOfSize:12];
    _identity.textColor = [UIColor grayColor];
    [self.contentView addSubview: _identity];
    
    //4.评论数，点赞数
    _comment = [[UILabel alloc] init];
    _comment.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_comment];
    _commentImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_commentImage];
    
    _like = [[UILabel alloc] init];
    _like.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_like];
    _likeImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_likeImage];
    
    _transmit = [[UILabel alloc] init];
    _transmit.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_transmit];
    _transmitImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_transmitImage];
    
    
    //5.时间
    _time = [[UILabel alloc] init];
    _time.font = [UIFont systemFontOfSize:12];
    _time.textColor = [UIColor grayColor];
    [self.contentView addSubview:_time];
}

+(NSString *)getID
{
    return @"cell";
}


@end





















