//
//  AddPhoto.h
//  testProject
//
//  Created by 王睿泽 on 2019/5/20.
//  Copyright © 2019 王睿泽. All rights reserved.
//

#ifndef AddPhoto_h
#define AddPhoto_h

#import <UIKit/UIKit.h>

@protocol PhotoChangedDelegate <NSObject>

- (void)DidPhotoChanged;

@end

@interface AddPhoto : UIView

@property (nonatomic, assign) id <PhotoChangedDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *photos;

@end

#endif /* AddPhoto_h */
