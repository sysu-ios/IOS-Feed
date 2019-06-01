//
//  PublishViewController.h
//  testProject
//
//  Created by 王睿泽 on 2019/5/18.
//  Copyright © 2019 王睿泽. All rights reserved.
//

#ifndef PublishViewController_h
#define PublishViewController_h

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PublishViewController : UIViewController

@property (nonatomic, strong) NSString *text;       //用户所发文章的文字
@property (nonatomic, strong) NSMutableArray *pictures;    //用户所发文章的图片  数组内部存储类型为UIImage
@property (nonatomic, strong) CLLocation *location; //用户所在地
@property (nonatomic, strong) NSMutableArray *topic;       //用户选择的话题     数组内部存储类型为NSString
@property (nonatomic, strong) NSMutableArray *mentioned;    //用户提到的其他用户 数组内部存储类型为NSString


@end


#endif /* PublishViewController_h */
