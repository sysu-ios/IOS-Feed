//
//  User.h
//  Feed
//
//  Created by 王广浩 on 2019/5/11.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#ifndef UserModel_h
#define UserModel_h

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (copy,nonatomic)NSString *iconPath; //头像路径
@property (copy,nonatomic)NSString *name; //用户名
@property (copy,nonatomic)NSString *password; //密码

@property (assign,nonatomic)NSInteger age; //年龄
@property (assign,nonatomic)char gender; //性别
@property (copy,nonatomic)NSString *place; //地区

@property (assign,nonatomic)NSInteger postNum; //发帖数
@property (assign,nonatomic)NSInteger praiseNum; //点赞数
@property (assign,nonatomic)NSInteger attentionNum; //关注数
@property (assign,nonatomic)NSInteger fanNum; //粉丝数


@end

#endif /* UserModel_h */
