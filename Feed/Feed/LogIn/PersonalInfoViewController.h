//
//  PersonalInfoViewController.h
//  Feed
//
//  Created by peiyu wang on 2019/5/14.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalInfoViewController : UIViewController
// 存储用户信息的数据模型
@property (nonatomic, strong) UserModel *infoList;
@end

NS_ASSUME_NONNULL_END
