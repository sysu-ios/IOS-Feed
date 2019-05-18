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

-(void)createDataBase{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"user.sqlite"];
    self.db = [FMDatabase databaseWithPath:filePath];
    
}

- (void)createTable{
    
    if ([self.db open]) {
        
        //AUTOINCREMENT 自增
        
        BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS user (UserName text PRIMARY KEY NOT NULL, Password text NOT NULL, UserIcon blob NOT NULL, PhoneNumber text NOT NULL, Email text NOT NULL, Introduction text NOT NULL, Sex text NOT NULL, Birthday text NOT NULL, Region text NOT NULL, PostNum integer NOT NULL, PraiseNum integer NOT NULL, AttentionNum integer NOT NULL, FanNum integer NOT NULL);"];
        
        if (result) {
            NSLog(@"创建表成功");
            
        }else{
            NSLog(@"创建表失败");
            
        }
        [self.db close];
        
    }else{
        NSLog(@"打开数据库失败");
    }
}

//插入数据
-(void)insertUser:(UserModel *)model{
    if ([self.db open]) {
        NSString *UserName = model.UserName;
        NSString *Password = model.Password;
        UIImage *UserIconImage = model.UserIcon;
        NSData *UserIcon = UIImageJPEGRepresentation(UserIconImage,1.0f);
        NSString *PhoneNumber = model.PhoneNumber;
        NSString *Email = model.Email;
        NSString *Introduction = model.Introduction;
        NSString *Sex = model.Sex;
        NSString *Birthday = model.Birthday;
        NSString *Region = model.Region;
        NSInteger PostNum = model.PostNum;
        NSInteger PraiseNum = model.PraiseNum;
        NSInteger AttentionNum = model.AttentionNum;
        NSInteger FanNum = model.FanNum;
        
        BOOL result = [self.db executeUpdate:@"INSERT INTO user (UserName, Password, UserIcon, PhoneNumber, Email, Introduction, Sex, Birthday, Region, PostNum, PraiseNum, AttentionNum, FanNum) value(?,?,?,?,?,?,?,?,?,?,?,?,?)",UserName, Password, UserIcon, PhoneNumber, Email, Introduction, Sex, Birthday, Region, PostNum, PraiseNum, AttentionNum, FanNum];
        if (result) {
            NSLog(@"插入表成功");
            
        }else{
            NSLog(@"插入表失败");
            
        }
        [self.db close];
        
    }else{
        NSLog(@"打开数据库失败");
    }
}
//删除数据
-(void)deleteUser:(UserModel *)model{
    
}
//修改数据
-(void)updateUser:(UserModel *)model{
    
}

//查询
-(NSMutableArray *)queryUser{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    
    if ([self.db open]) {
        
        // 查询数据
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM user"];
        
        // 遍历结果集
        while ([rs next]) {
            UserModel *User = [[UserModel alloc]init];
            User.UserName = [rs stringForColumn:@"UserName"];
            User.Password = [rs stringForColumn:@"Password"];
            NSData *ImageData = [rs dataForColumn:@"UserIcon"];
            User.UserIcon = [UIImage imageWithData: ImageData];
            User.PhoneNumber = [rs stringForColumn:@"PhoneNumber"];
            User.Email = [rs stringForColumn:@"Email"];
            User.Introduction = [rs stringForColumn:@"Introduction"];
            User.Sex = [rs stringForColumn:@"Sex"];
            User.Birthday = [rs stringForColumn:@"Birthday"];
            User.Region = [rs stringForColumn:@"Region"];
            User.PostNum = [rs intForColumn:@"PostNum"];
            User.PraiseNum = [rs intForColumn:@"PraiseNum"];
            User.AttentionNum = [rs intForColumn:@"AttentionNum"];
            User.FanNum = [rs intForColumn:@"FanNum"];
            [array addObject:User];
            
        }
        
        [self.db close];
        
    }else{
        NSLog(@"打开数据库失败");
    }
    return array;
}
//根据名字查询
-(NSMutableArray *)findByUserName:(NSString *)name{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    
    if ([self.db open]) {
        
        // 查询数据
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM user WHERE UserName = ?;", name];
        
        // 遍历结果集
        while ([rs next]) {
            UserModel *User = [[UserModel alloc]init];
            User.UserName = [rs stringForColumn:@"UserName"];
            User.Password = [rs stringForColumn:@"Password"];
            NSData *ImageData = [rs dataForColumn:@"UserIcon"];
            User.UserIcon = [UIImage imageWithData: ImageData];
            User.PhoneNumber = [rs stringForColumn:@"PhoneNumber"];
            User.Email = [rs stringForColumn:@"Email"];
            User.Introduction = [rs stringForColumn:@"Introduction"];
            User.Sex = [rs stringForColumn:@"Sex"];
            User.Birthday = [rs stringForColumn:@"Birthday"];
            User.Region = [rs stringForColumn:@"Region"];
            User.PostNum = [rs intForColumn:@"PostNum"];
            User.PraiseNum = [rs intForColumn:@"PraiseNum"];
            User.AttentionNum = [rs intForColumn:@"AttentionNum"];
            User.FanNum = [rs intForColumn:@"FanNum"];
            [array addObject:User];
            
        }
        
        [self.db close];
        
    }else{
        NSLog(@"打开数据库失败");
    }
    return array;
    
}
//根据邮箱查询
-(NSMutableArray *)findByEmail:(NSString *)email{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    
    if ([self.db open]) {
        
        // 查询数据
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM user WHERE Email = ?;", email];
        
        // 遍历结果集
        while ([rs next]) {
            UserModel *User = [[UserModel alloc]init];
            User.UserName = [rs stringForColumn:@"UserName"];
            User.Password = [rs stringForColumn:@"Password"];
            NSData *ImageData = [rs dataForColumn:@"UserIcon"];
            User.UserIcon = [UIImage imageWithData: ImageData];
            User.PhoneNumber = [rs stringForColumn:@"PhoneNumber"];
            User.Email = [rs stringForColumn:@"Email"];
            User.Introduction = [rs stringForColumn:@"Introduction"];
            User.Sex = [rs stringForColumn:@"Sex"];
            User.Birthday = [rs stringForColumn:@"Birthday"];
            User.Region = [rs stringForColumn:@"Region"];
            User.PostNum = [rs intForColumn:@"PostNum"];
            User.PraiseNum = [rs intForColumn:@"PraiseNum"];
            User.AttentionNum = [rs intForColumn:@"AttentionNum"];
            User.FanNum = [rs intForColumn:@"FanNum"];
            [array addObject:User];
            
        }
        
        [self.db close];
        
    }else{
        NSLog(@"打开数据库失败");
    }
    return array;
    
}
//根据手机号查询
-(NSMutableArray *)findByPhone:(NSString *)phone{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    
    if ([self.db open]) {
        
        // 查询数据
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM user WHERE PhoneNumber = ?;",phone];
        
        // 遍历结果集
        while ([rs next]) {
            UserModel *User = [[UserModel alloc]init];
            User.UserName = [rs stringForColumn:@"UserName"];
            User.Password = [rs stringForColumn:@"Password"];
            NSData *ImageData = [rs dataForColumn:@"UserIcon"];
            User.UserIcon = [UIImage imageWithData: ImageData];
            User.PhoneNumber = [rs stringForColumn:@"PhoneNumber"];
            User.Email = [rs stringForColumn:@"Email"];
            User.Introduction = [rs stringForColumn:@"Introduction"];
            User.Sex = [rs stringForColumn:@"Sex"];
            User.Birthday = [rs stringForColumn:@"Birthday"];
            User.Region = [rs stringForColumn:@"Region"];
            User.PostNum = [rs intForColumn:@"PostNum"];
            User.PraiseNum = [rs intForColumn:@"PraiseNum"];
            User.AttentionNum = [rs intForColumn:@"AttentionNum"];
            User.FanNum = [rs intForColumn:@"FanNum"];
            [array addObject:User];
            
        }
        
        [self.db close];
        
    }else{
        NSLog(@"打开数据库失败");
    }
    return array;
    
}

-(NSMutableArray *)findByLike:(NSString *)input{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    
    if ([self.db open]) {
        
        // 查询数据
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM user WHERE  UserName like '%%%@%%' AND Password like '%%%@%%' AND UserIcon like '%%%@%%' AND PhoneNumber like '%%%@%%' AND Email like '%%%@%%' AND Introduction like '%%%@%%' AND Sex like '%%%@%%' AND Birthday like '%%%@%%' AND Region like '%%%@%%' AND PostNum like '%%%@%%' AND PraiseNum like '%%%@%%' AND AttentionNum like '%%%@%%' AND FanNum like '%%%@%%';", input, input, input, input, input, input, input, input, input, input, input, input, input];
        
        // 遍历结果集
        while ([rs next]) {
            UserModel *User = [[UserModel alloc]init];
            User.UserName = [rs stringForColumn:@"UserName"];
            User.Password = [rs stringForColumn:@"Password"];
            NSData *ImageData = [rs dataForColumn:@"UserIcon"];
            User.UserIcon = [UIImage imageWithData: ImageData];
            User.PhoneNumber = [rs stringForColumn:@"PhoneNumber"];
            User.Email = [rs stringForColumn:@"Email"];
            User.Introduction = [rs stringForColumn:@"Introduction"];
            User.Sex = [rs stringForColumn:@"Sex"];
            User.Birthday = [rs stringForColumn:@"Birthday"];
            User.Region = [rs stringForColumn:@"Region"];
            User.PostNum = [rs intForColumn:@"PostNum"];
            User.PraiseNum = [rs intForColumn:@"PraiseNum"];
            User.AttentionNum = [rs intForColumn:@"AttentionNum"];
            User.FanNum = [rs intForColumn:@"FanNum"];
            [array addObject:User];
            
        }
        
        [self.db close];
        
    }else{
        NSLog(@"打开数据库失败");
    }
    return array;
}

@end

