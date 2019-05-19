//
//  UserInfo.h
//  Feed
//
//  Created by peiyu wang on 2019/5/14.
//  Copyright © 2019 peiyu wang. All rights reserved.
//
// 用户个人信息列表
// 查询至少需要findByUserName以及findByEmail以及findByEmail(信息唯一可以准确查询, 手机邮箱想设置忘记密码验证需要设置)
// 最好其他项也都有模糊查询(like)，这样比较好加东西

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject
// 用户名 唯一标识id
@property (nonatomic, strong) NSString *UserName;
// 密码
@property (nonatomic, strong) NSString *PassWord;
// 头像
@property (nonatomic, strong) UIImage *UserIcon;
// 手机号
@property (nonatomic, strong) NSString *phoneNumber;
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

-(instancetype)init;

@end

NS_ASSUME_NONNULL_END
