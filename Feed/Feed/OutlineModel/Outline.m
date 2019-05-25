//
//  Outline.m
//  Feed
//
//  Created by student8 on 2019/5/11.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "Outline.h"

@implementation Outline

-(id) initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        self.name = @"中国日报网";//dict[@"name"];
        //self.avatar = dict[@"avatar"];
        self.identity = @"中国日报网官方账号";//dict[@"identity"];
        self.time = @"1小时前";//dict[@"time"];
        self.title = dict[@"title"];
        NSArray *image_infos = dict[@"image_infos"];
        self.imageList = [NSArray array];
        for(int i = 0; i < image_infos.count;i++) {
            self.imageList = [self.imageList arrayByAddingObject:[image_infos[i][@"url_prefix"] stringByAppendingString:image_infos[i][@"web_uri"]]];
        }
        
        self.avatar = _imageList[0];
        self.comment = @"11";// dict[@"comment"];
        self.like = @"12";//dict[@"like"];
        self.share = @"13";//dict[@"transmit"];
    }
    return self;
}

// alloc self
+(id) outlineWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
