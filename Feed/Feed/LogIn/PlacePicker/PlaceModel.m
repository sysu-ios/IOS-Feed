//
//  PlaceModel.m
//  Feed
//
//  Created by peiyu wang on 2019/5/15.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "PlaceModel.h"

@implementation PlaceModel
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.provinceName = @"";
        self.cityArrary = [NSMutableArray array];
        self.districtArray = [NSMutableArray array];
    }
    return self;
}
@end
