//
//  UserDao.m
//  Feed
//
//  Created by 王广浩 on 2019/5/11.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDao.h"
#import "UserModel.h"
#import "FMDB.h"

@implementation UserDao

static UserDao *userFmdb = nil;
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (userFmdb == nil) {
            userFmdb = [[UserDao alloc] init];
            //创建数据库
            [userFmdb createDataBase];
            //创建表
            [userFmdb createTable];
        }
        
    });
    
    return userFmdb;
    
}

+(UserDao *)shareduserDao{
    
    return [[self alloc]init];
    
}

-(id)copyWithZone:(NSZone *)zone
{
    return userFmdb;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return userFmdb;
}
/Users/wang/Desktop/IOS-Feed/Feed/Feed/Model/UserModel.h
-(void)createDataBase{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"user.sqlite"];
    self.db = [FMDatabase databaseWithPath:filePath];
    
}

- (void)createTable{
    
    if ([self.db open]) {
        
        //AUTOINCREMENT 自增
        
        BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS user (name text PRIMARY KEY NOT NULL, password text NOT NULL, iconPath text NOT NULL, gender text NOT NULL, place text NOT NULL, age integer NOT NULL, postNum integer NOT NULL, praiseNum integer NOT NULL, attentionNum integer NOT NULL, fanNum integer NOT NULL);"];
        
        if (result) {
            NSLog(@"simpleChatCache 创建表成功");
            
        }else{
            NSLog(@"simpleChatCache 创建表失败");
            
        }
        [self.db close];
        
    }else{
        NSLog(@"simpleChatCache 打开数据库失败");
    }
}

@end

