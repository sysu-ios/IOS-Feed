//
//  PlacePicker.h
//  Feed
//
//  Created by peiyu wang on 2019/5/15.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"
typedef void(^sendValue)(NSMutableDictionary *value);
NS_ASSUME_NONNULL_BEGIN

@interface PlacePicker : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, copy)sendValue sendValueBlock;
@end

NS_ASSUME_NONNULL_END
