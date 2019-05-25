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
@property (nonatomic,strong) UILabel *avatarlabel;
@property (nonatomic,strong) UILabel *identitylabel;
@property (nonatomic ,strong) UILabel *timelabel;
@property (nonatomic,strong) UIImageView *picImage1;
@property (nonatomic,strong) UIImageView *picImage2;
@property (nonatomic,strong) UIImageView *picImage3;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UILabel *likeLabel;

@property (nonatomic,strong) OutlineFrame *outlineframe;

+(NSString *)getID;
@end
