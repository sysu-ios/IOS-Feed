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
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

// 用户名 唯一标识id
@property (nonatomic, strong) NSString *UserName;
// 密码
@property (nonatomic, strong) NSString *Password;
// 头像
@property (nonatomic, strong) UIImage *UserIcon;
// 手机号
@property (nonatomic, strong) NSString *PhoneNumber;
// 邮箱
@property (nonatomic, strong) NSString *Email;
// 介绍
@property (nonatomic, strong) NSString *Introduction;
// 性别
@property (nonatomic, strong) NSString *Sex;
// 生日
@property (nonatomic, strong) NSString *Birthday;
// 居住地
@property (nonatomic, strong) NSString *Region;

//发帖数
@property (assign,nonatomic)NSInteger PostNum;
//点赞数
@property (assign,nonatomic)NSInteger PraiseNum;
//关注数
@property (assign,nonatomic)NSInteger AttentionNum;
//粉丝数
@property (assign,nonatomic)NSInteger FanNum;

-(instancetype)init;
+(instancetype)init;

@end

NS_ASSUME_NONNULL_END

#endif /* UserModel_h */

