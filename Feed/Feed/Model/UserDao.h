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
-(NSArray *)queryUser;
//清空数据库
-(void)removeAllUser;


#endif /* UserDao_h */
