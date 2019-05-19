//
//  FriendViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/7.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "FriendViewController.h"

@interface FriendViewController ()
-(void)save:(id)sender;
-(void)cancel:(id)sender;
@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"关注的人";
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                       UIBarButtonSystemItemSave target:self action:@selector(save:)];
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                         UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
}

-(void)save:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:^{
        NSLog(@"点击save按钮, 关闭模态视图");
        
    }];
}
-(void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:^{
        NSLog(@"点击Cancel按钮, 关闭模态视图");
    }];
}

@end
