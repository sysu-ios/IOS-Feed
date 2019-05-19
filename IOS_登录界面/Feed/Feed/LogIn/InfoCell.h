//
//  InfoCell.h
//  Feed
//
//  Created by peiyu wang on 2019/5/15.
//  Copyright © 2019 peiyu wang. All rights reserved.
// 重定义的表格视图的每一个cell项

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoCell : UITableViewCell

@property (strong, nonatomic) UILabel *infoName;
@property (strong, nonatomic) UILabel *infoContent;

@end

NS_ASSUME_NONNULL_END
