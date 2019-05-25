//
//  OutlineCell.h
//  Feed
//
//  Created by student8 on 2019/5/11.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OutlineFrame;

@interface OutlineCell : UITableViewCell

@property (nonatomic,strong) UILabel *namelabel;
@property (nonatomic,strong) UIImageView *avatarImage;
@property (nonatomic,strong) UILabel *identitylabel;
@property (nonatomic ,strong) UILabel *timelabel;
@property (nonatomic,strong) UIImageView *picImage1;
@property (nonatomic,strong) UIImageView *picImage2;
@property (nonatomic,strong) UIImageView *picImage3;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UIImageView *commentImage;
@property (nonatomic,strong) UILabel *likeLabel;
@property (nonatomic,strong) UIImageView *likeImage;
@property (nonatomic,strong) UILabel *transmitLabel;
@property (nonatomic,strong) UIImageView *transmitImage;

@property (nonatomic,strong) OutlineFrame *outlineframe;

+(NSString *)getID;
@end
