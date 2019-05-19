//
//  PlacePicker.m
//  Feed
//
//  Created by peiyu wang on 2019/5/15.
//  Copyright © 2019 peiyu wang. All rights reserved.
//

#import "PlacePicker.h"
#define TabBarHeight 60

@interface PlacePicker()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *toolView;
// 存储索引数据
@property (nonatomic, strong) NSArray *selectedProvinceArray;
@property (nonatomic, strong) NSMutableArray *selectedCityArray;
@property (nonatomic, strong) NSMutableArray *selectedDistrictArray;
@property (nonatomic, strong) NSArray *saveArray;                       // 存储选中地区索引数组
@property (nonatomic, strong) NSArray *selectArray;                     // 存储选中地区数组
@property (nonatomic, strong) NSString *selectedProvince;
@property (nonatomic, strong) NSString *selectedCity;
@property (nonatomic, strong) NSString *selectedDistrict;

@property (nonatomic, strong) NSMutableDictionary *placeDict;

@end

@implementation PlacePicker

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screen = [[UIScreen mainScreen] bounds];
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, screen.size.height - 230 - TabBarHeight, screen.size.width, 230)];
    self.placeDict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSDictionary *dic = @{@"province":@"", @"city":@"", @"district":@""};
    [self.placeDict addEntriesFromDictionary:dic];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
    
    self.toolView = [[UIView alloc] initWithFrame:CGRectMake(0, screen.size.height - 250 - TabBarHeight, self.view.frame.size.width, 34)];
    self.toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.toolView];
    
    UIView *belowLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 33, self.view.frame.size.width, 1)];
    belowLineView.backgroundColor = [UIColor grayColor];
    [self.toolView addSubview:belowLineView];
    
    UIView *aboveLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    aboveLineView.backgroundColor = [UIColor grayColor];
    [self.toolView addSubview:aboveLineView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(10, 2, 40, 28);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:cancelButton];
    
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(self.view.bounds.size.width - 50, 2, 40, 28);
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:sureButton];
}

- (void)loadData
{
    self.dataArray = [NSMutableArray arrayWithCapacity:34];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"place" ofType:@"plist"]];
    NSArray *provinceArray = [dict allKeys];
    self.selectedProvinceArray = provinceArray;
    for (int i = 0; i < provinceArray.count; i++)
    {
        PlaceModel *placeModel = [[PlaceModel alloc] init];
        placeModel.provinceName = provinceArray[i];
        NSDictionary *cityDict = [[dict objectForKey:provinceArray[i]] firstObject];
        [cityDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [placeModel.cityArrary addObject:key];
            [placeModel.districtArray addObject:obj];
        }];
        [self.dataArray addObject:placeModel];
    }
    // 获取第一组数据
    PlaceModel *placeModel = self.dataArray[0];
    self.selectedProvince = placeModel.provinceName;
    self.selectedCity = placeModel.cityArrary[0];
    self.selectedDistrict = placeModel.districtArray[0][0];
    [self getSelectedArray];
}

#pragma mark -- 获取被挑选的数组
- (void) getSelectedArray {
    NSInteger provinceIndex = [self.selectedProvinceArray indexOfObject:self.selectedProvince];
    self.selectedCityArray = [self.dataArray[provinceIndex] cityArrary];
    NSInteger cityIndex = [self.selectedCityArray indexOfObject:self.selectedCity];
    self.selectedDistrictArray = [self.dataArray[provinceIndex] districtArray][cityIndex];
}

#pragma mark -- 实现DataSource协议
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    [self getSelectedArray];
    switch (component) {
        case 0:
            return self.dataArray.count;
            break;
        case 1:
            return self.selectedCityArray.count;
            break;
        case 2:
            return self.selectedDistrictArray.count;
            break;
        default:
            return 0;
            break;
    }
}

#pragma mark -- PickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    [self getSelectedArray];
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // pickerLabel.adjustsFontSizeToFitWidth = YES;  // 是否根据宽度适应文字大小
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor whiteColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
    
    NSString *text;
    
    switch (component) {
        case 0:
            text = self.selectedProvinceArray[row];
            break;
        case 1:
            text = self.selectedCityArray[row];
            break;
        case 2:
            text = self.selectedDistrictArray[row];
            break;
        default:
            text = @"";
            break;
    }
    pickerLabel.text = text;
    
    return pickerLabel;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:{
            self.selectedProvince = self.selectedProvinceArray[row];
            self.selectedCity = [self.dataArray[row] cityArrary][0];
            self.selectedDistrict = [self.dataArray[row] districtArray][0][0];
            [self getSelectedArray];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
        }
            break;
        case 1:{
            NSInteger provinceIndex = [self.selectedProvinceArray indexOfObject:self.selectedProvince];
            self.selectedCity = [self.dataArray[provinceIndex] cityArrary][row];
            self.selectedDistrict = [self.dataArray[provinceIndex] districtArray][row][0];
            [self getSelectedArray];
            [pickerView reloadComponent:2];
        }
            break;
        case 2:{
            self.selectedDistrict = self.selectedDistrictArray[row];
        }
            break;
        default:
            break;
        
    }
}
#pragma mark - PlacePicker的ToolViewAction
- (void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sureAction{
    if (self.selectedProvince && self.selectedCity &&self.selectedDistrict)
    {
        self.placeDict[@"province"] = self.selectedProvince;
        self.placeDict[@"city"] = self.selectedCity;
        self.placeDict[@"district"] = self.selectedDistrict;
    }
    NSLog(@"%@", self.placeDict);
    self.sendValueBlock(self.placeDict);
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
