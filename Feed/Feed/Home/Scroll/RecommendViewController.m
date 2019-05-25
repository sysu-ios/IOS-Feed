//
//  RecommendViewController.m
//  Feed
//
//  Created by peiyu wang on 2019/5/7.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "RecommendViewController.h"
#import "../../OutlineModel/Outline.h" //by ljz
#import "../../OutlineModel/OutlineFrame.h"
#import "../../OutlineModel/OutlineCell.h"

@interface RecommendViewController ()<UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate>

//全局变量，对应着从文件中取得的数据
@property (nonatomic, strong) NSMutableArray *outlineFrames;
@property (nonatomic, strong) NSArray *article_feed;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self postArticleList:4822 setoffset:0 setcount:10];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
//Block方法post请求
-(void) postArticleList:(NSInteger)uid setoffset:(NSInteger)offset setcount:(NSInteger)count
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"https://i.snssdk.com/course/article_feed"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString * params =[NSString stringWithFormat:@"uid=%lu&offset=%lu&count=%lu", uid, offset, count];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithRequest:urlRequest];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.article_feed = dict[@"data"][@"article_feed"];
    NSLog(@"%@", _article_feed);
    
    //遍历添加到我们的概况模型中
    _outlineFrames = [NSMutableArray array];
    int chooseSytle = 0;
    for (NSDictionary *dict in self.article_feed) {
        int test;
        if(chooseSytle < 5)
            test = 1;
        else
            test = 2;
        Outline *outline  = [Outline outlineWithDict:dict];
        OutlineFrame *outlineframe = [[OutlineFrame alloc]initOutlineFrame:outline chooseStyle:test];
        [_outlineFrames addObject:outlineframe];
        chooseSytle++;
    }
    NSLog(@"cell 个数：%lu", (unsigned long)_outlineFrames.count);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

/*- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
 {
 if(error == nil)
 {
 if ([task isKindOfClass:[NSURLSessionDownloadTask class]]) {
 NSLog(@"Download is Succesfull");
 } else if ([task isKindOfClass:[NSURLSessionUploadTask class]]) {
 NSLog(@"Upload is Succesfull");
 }
 }
 else
 NSLog(@"Error %@",[error userInfo]);
 }*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _outlineFrames.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1、去缓存池取出cell
    OutlineCell *cell = [tableView dequeueReusableCellWithIdentifier:[OutlineCell getID]];
    
    //2、如果不存在缓存，则创建一个
    if (cell ==nil) {
        cell = [[OutlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[OutlineCell getID]];
    }
    
    //3、传递模型数据
    cell.outlineframe = _outlineFrames[indexPath.row];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_outlineFrames[indexPath.row] cellHeight];
}

@end
