//
//  PlaceModel.h
//  Feed
//
//  Created by peiyu wang on 2019/5/15.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaceModel : NSObject

@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSMutableArray *cityArrary;
@property (nonatomic, strong) NSMutableArray *districtArray;

@end

NS_ASSUME_NONNULL_END
