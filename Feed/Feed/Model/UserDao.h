//
//  UserDao.h
//  Feed
//
//  Created by 王广浩 on 2019/5/11.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#ifndef UserDao_h
#define UserDao_h

#import <Foundation/Foundation.h>

@class FMDatabase;
@class UserModel;

@interface UserDao : NSObject

+(UserDao *)sharedUserDao;

@property(strong,nonatomic)FMDatabase *db;

//插入数据
-(void)insertUser:(UserModel *)model;
//删除数据
-(void)deleteUser:(UserModel *)model;
//修改数据
-(void)updateUser:(UserModel *)model;

//查询
-(NSMutableArray *)queryUser;
//根据名字查询
-(NSMutableArray *)findByUserName:(NSString *)name;
//根据邮箱查询
-(NSMutableArray *)findByEmail:(NSString *)email;
//根据手机号查询
-(NSMutableArray *)findByPhone:(NSString *)phone;
//模糊查询
-(NSMutableArray *)findByLike:(NSString *)input;

//清空数据库
-(void)removeAllUser;

@end

#endif /* UserDao_h */
