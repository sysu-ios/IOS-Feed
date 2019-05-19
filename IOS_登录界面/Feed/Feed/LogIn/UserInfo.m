//
//  UserInfo.m
//  Feed
//
//  Created by peiyu wang on 2019/5/14.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.UserName = @"";
        self.PassWord = @"";
        // 加载头像
        NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"头像" ofType:@"png"];
        self.UserIcon = [UIImage imageWithContentsOfFile:imagePath];// NSBundle加载
        self.phoneNumber = @"待完善(必填)";
        self.Email = @"待完善(必填)";
        self.Introduction = @"待完善";
        self.Sex = @"待完善";
        self.Birthday = @"待完善";
        self.Region = @"待完善";
    }
    return self;
}
@end
