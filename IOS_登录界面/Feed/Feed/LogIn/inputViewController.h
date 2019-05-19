//
//  inputViewController.h
//  Feed
//
//  Created by peiyu wang on 2019/5/16.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface inputViewController : UIViewController
// target-action传值
@property (assign, readwrite, nonatomic)id target;
@property (assign, readwrite, nonatomic)SEL action;
@end

NS_ASSUME_NONNULL_END
