//
//  Outline.h
//  Feed
//
//  Created by student8 on 2019/5/11.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Outline : NSObject

@property (nonatomic,copy) NSString *name; //作者名字
@property (nonatomic,copy) NSString *avatar; //作者头像
@property (nonatomic,copy) NSString *identity; //作者身份头衔
@property (nonatomic,copy) NSString *time; //发布时间
@property (nonatomic,copy) NSArray<NSString *> *imageList;
/*@property (nonatomic, copy) NSString *pic1; //图片1
@property (nonatomic, copy) NSString *pic2; //图片2
@property (nonatomic, copy) NSString *pic3; //图片3*/
@property (nonatomic,copy) NSString *title; //标题
@property (nonatomic,copy) NSString *comment; //评论数显示
@property (nonatomic,copy) NSString *like; //点赞数显示

-(id) initWithDict:(NSDictionary *)dict;
+(id) outlineWithDict:(NSDictionary *)dict;

@end

