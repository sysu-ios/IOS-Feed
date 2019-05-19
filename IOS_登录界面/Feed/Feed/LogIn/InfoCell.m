//
//  InfoCell.m
//  Feed
//
//  Created by peiyu wang on 2019/5/15.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGRect screen = [[UIScreen mainScreen] bounds];
        CGFloat cellHeight = self.frame.size.height;
        CGFloat labelWidth = 200;
        CGFloat labelHeight = 28;
        CGFloat labelLeftView = 30;
        CGFloat labelRightView = 10;
        // 1. 添加infoName label
        self.infoName = [[UILabel alloc] initWithFrame:CGRectMake(labelLeftView, (cellHeight - labelHeight) / 2, labelWidth, labelHeight)];
        self.infoName.textAlignment = NSTextAlignmentLeft;
        [self.infoName setTextColor:[UIColor whiteColor]];
        [self.infoName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [self addSubview:self.infoName];
        
        // 2. 添加infoName Label
        self.infoContent = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width - labelRightView - labelWidth), (cellHeight - labelHeight) / 2, labelWidth, labelHeight)];
        self.infoContent.textAlignment = NSTextAlignmentRight;
        [self.infoContent setTintColor:[UIColor whiteColor]];
        [self.infoContent setTextColor:[UIColor whiteColor]];
        self.infoContent.text = @"";
        [self.infoContent setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        [self addSubview:self.infoContent];
    }
    return self;
}

@end
