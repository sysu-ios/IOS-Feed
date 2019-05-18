//
//  UserModel.m
//  Feed
//
//  Created by 王广浩 on 2019/5/18.
//  Copyright © 2019年 peiyu wang. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.UserName = @"";
        self.Password = @"";
        // 加载头像
        NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"头像" ofType:@"png"];
        self.UserIcon = [UIImage imageWithContentsOfFile:imagePath];// NSBundle加载
        self.PhoneNumber = @"待完善(必填)";
        self.Email = @"待完善(必填)";
        self.Introduction = @"待完善";
        self.Sex = @"待完善";
        self.Birthday = @"待完善";
        self.Region = @"待完善";
    }
    return self;
}

@end
