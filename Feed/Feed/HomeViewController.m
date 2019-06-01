//
//  HomeViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/6.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "HomeViewController.h"
#import "Home/ScrollViewController.h"
#import "Home/Scroll/AttentionViewController.h"
#import "Home/Scroll/RecommendViewController.h"
#import "Home/Scroll/PEViewController.h"
#import "Home/Scroll/TechViewController.h"
#import "Home/Scroll/MilitaryViewController.h"
#import "Home/Scroll/EnterViewController.h"

#import "PublishViewController.h"
#import <CMPopTipView.h>

#define NavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

@interface HomeViewController () <CMPopTipViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) CMPopTipView *roundRectButtonPopTipView;
@property (nonatomic,strong) NSMutableArray       *dataSource; //!< collectionView的数据源
@property (nonatomic,strong) NSMutableArray          *visiblePopTipViews; //!< 可见的PopView
@property (nonatomic,strong) id                      currentPopTipViewTarget;  //!< 当前的按钮
@property (nonatomic,strong) UITableView          *tableView;
@property (nonatomic,strong) NSMutableArray       *tableDataSource;
@property (nonatomic,strong)UIBarButtonItem          *rightButton;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // CGRect screen = [[UIScreen mainScreen] bounds];
    ScrollViewController *scrollViewController = [[ScrollViewController alloc] init];
    scrollViewController.cbs_titleArray = @[@"关注", @"推荐", @"娱乐", @"军事", @"科技", @"体育"];
    //设置各个标签对应的ViewController，如果数量不对会崩溃
    scrollViewController.cbs_viewArray = @[@"AttentionViewController", @"RecommendViewController", @"PEViewController", @"TechViewController", @"MilitaryViewController", @"EnterViewController"];
    scrollViewController.cbs_Type = CBSSegmentHeaderTypeScroll;
    scrollViewController.cbs_buttonHeight = 40;
    scrollViewController.cbs_NavTopHeight = 0;
    scrollViewController.cbs_topHeight = NavAndStatusHight + scrollViewController.cbs_NavTopHeight;
    [scrollViewController initSegment];
    [self addChildViewController:scrollViewController];
    [self.view addSubview:scrollViewController.view];
    
    //右上角发布按钮
    [self initTableView];
    [self setup];
    
}

#pragma mark - 右上角发布按钮
- (void) setup {
    self.view.backgroundColor = UIColor.whiteColor;
    
    //右侧发布按钮设置
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, -5, 50, 50);
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:9];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"cameraIcon.jpeg"] forState:UIControlStateNormal];
    [button setAdjustsImageWhenHighlighted:NO];
    //使图片文字上下居中排列
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width, -button.imageView.frame.size.height, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.frame.size.height - 5,  0, 0, -button.titleLabel.frame.size.width);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(gotoCart:) forControlEvents:UIControlEventTouchUpInside];
    //设置发布按钮位置
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];
    [view addSubview:button];
    self.rightButton =  [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItems = @[self.rightButton];
}

- (void)gotoCart:(UIButton *)sender
{
    [self dismissAllPopTipViews];
    if (nil == self.roundRectButtonPopTipView) {
        [self.tableView reloadData];
        //self.tableView.frame = CGRectMake(0, 0, 120, 240);
        self.tableView.frame = CGRectMake(0, 0, 120, 40);
        self.tableView.backgroundColor = [UIColor blackColor];
        self.tableView.alwaysBounceVertical = YES;
        self.tableView.scrollEnabled = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorInset = UIEdgeInsetsZero;
        self.roundRectButtonPopTipView = [[CMPopTipView alloc] initWithCustomView:self.tableView];
        
        self.roundRectButtonPopTipView.delegate = self;
        self.roundRectButtonPopTipView.cornerRadius = 5;
        self.roundRectButtonPopTipView.backgroundColor = [UIColor blackColor];
        self.roundRectButtonPopTipView.textColor = [UIColor whiteColor];
        self.roundRectButtonPopTipView.animation = arc4random() % 1;
        self.roundRectButtonPopTipView.has3DStyle = arc4random() % 1;
        [self.roundRectButtonPopTipView  presentPointingAtView:sender inView:self.view animated:YES];
        [self.visiblePopTipViews addObject:self.roundRectButtonPopTipView ];
        
        self.currentPopTipViewTarget = sender;
    }
    else {
        [self.roundRectButtonPopTipView dismissAnimated:YES];
        self.roundRectButtonPopTipView = nil;
    }
    
}

// 初始化tableView
- (void)initTableView
{
    //self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120,240) style:UITableViewStylePlain];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120,40) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
}

#pragma mark - uitableViewDeleagete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"cameraIcon.jpeg"];
    CGSize itemSize = CGSizeMake(20, 20);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.textLabel.text = self.tableDataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor blackColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
    cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PublishViewController *vc = [[PublishViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        [self.roundRectButtonPopTipView dismissAnimated:YES];
        self.roundRectButtonPopTipView = nil;
    } else {
        
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.tableDataSource.count - 1) {
        cell.preservesSuperviewLayoutMargins = NO;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.tableView.frame.size.width);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)dismissAllPopTipViews
{
    while ([self.visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(CMPopTipView *)popTipView {
    [self.roundRectButtonPopTipView dismissAnimated:YES];
    self.roundRectButtonPopTipView = nil;
}

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.roundRectButtonPopTipView dismissAnimated:YES];
    self.roundRectButtonPopTipView = nil;
}


- (NSMutableArray *)tableDataSource
{
    if (_tableDataSource == nil) {
        _tableDataSource = [[NSMutableArray alloc] //initWithArray:@[@"发图文",@"尚未完成",@"尚未完成",@"尚未完成",@"尚未完成",@"尚未完成"]];
            initWithArray:@[@"发图文"]];
    }
    return _tableDataSource;
}

@end
