//
//  ViewController.m
//  日历3
//
//  Created by 王俊钢 on 16/5/7.
//  Copyright © 2016年 王俊钢. All rights reserved.
//

#import "AppointmentViewController.h"
#import "SZYDatePickView.h"
#import "UIView+Corner.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIViewColor UIColorFromRGB(0xE6E6E6)

#define UIBottomViewColor UIColorFromRGB(0xF2F2F5)
#define screenW     [UIScreen mainScreen].bounds.size.width
#define screenH      [UIScreen mainScreen].bounds.size.height
#define ThemeColor UIColorFromRGB(0xE53136)

#define DatePickerViewType_Date 101
#define DatePickerViewType_Time 102

@interface  AppointmentViewController()<SZYDatePickViewDelegate>

@property (nonatomic ,strong) UIButton *cancelBtn;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,strong) UILabel *dateLabel;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UIButton *selectDateBtn;
@property (nonatomic ,strong) UIButton *selectTimeBtn;
@property (nonatomic ,strong) UITextView *resultTV;
@property (nonatomic ,strong) SZYDatePickView *datePickView;



@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"预约信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.cancelBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.sureBtn];

    [self.view addSubview:self.selectTimeBtn];
    [self.view addSubview:self.selectDateBtn];
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.timeLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDatePicker)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat kLeftMargin = (screenW - (100 + 230))/2;
    
    self.dateLabel.frame = CGRectMake(kLeftMargin, 140, 100, 50);
    self.timeLabel.frame = CGRectMake(kLeftMargin, CGRectGetMaxY(self.dateLabel.frame) + 20, 100, 50);
    CGFloat btnWidth = 230;
    self.selectDateBtn.frame = CGRectMake(CGRectGetMaxX(self.dateLabel.frame), 140, btnWidth, 50);
    self.selectTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame), CGRectGetMaxY(self.selectDateBtn.frame) + 20, btnWidth, 50);
    
    //设置局部圆角
    CGSize size = CGSizeMake(5, 5);
    [self.dateLabel cornerWithCornerRadio:size rectCorner:UIRectCornerTopLeft|UIRectCornerBottomLeft];
    [self.timeLabel cornerWithCornerRadio:size rectCorner:UIRectCornerTopLeft|UIRectCornerBottomLeft];
    [self.selectDateBtn cornerWithCornerRadio:size rectCorner:UIRectCornerTopRight|UIRectCornerBottomRight];
    [self.selectTimeBtn cornerWithCornerRadio:size rectCorner:UIRectCornerTopRight|UIRectCornerBottomRight];
}


-(void)hideDatePicker
{
    [self cancelBtnDidClick];
}

#pragma mark - 选择时间视图-协议方法
-(void)cancelBtnDidClick
{
    self.selectDateBtn.enabled = YES;
    self.selectTimeBtn.enabled = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.datePickView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.datePickView removeFromSuperview];
        self.datePickView = nil;
    }];
    
}
-(void)sureBtnDidClick:(NSDate *)selecteDdate
{
    
    if(self.datePickView.tag == DatePickerViewType_Date){
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [formatter stringFromDate:selecteDdate];
        [self.selectDateBtn setTitle:dateStr forState:UIControlStateNormal];
    }
    else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"HH:mm";
        NSString *dateStr = [formatter stringFromDate:selecteDdate];
        [self.selectTimeBtn setTitle:dateStr forState:UIControlStateNormal];
    }
    
    [self cancelBtnDidClick];
}

#pragma mark - 选择预约日期
-(void)selectDate:(UIButton *)btn
{
    self.selectDateBtn.enabled = NO;
    [self.view addSubview:self.datePickView];
    self.datePickView.tag = DatePickerViewType_Date;
    self.datePickView.picker.datePickerMode = UIDatePickerModeDate;
    self.datePickView.frame = CGRectMake(0, screenH, screenW, 180);
    [UIView animateWithDuration:0.2 animations:^{
        self.datePickView.transform = CGAffineTransformMakeTranslation(0, -180);
    }];
    
}
#pragma mark - 选择预约时间
-(void)selectTime:(UIButton *)btn
{
    self.selectTimeBtn.enabled = NO;
    [self.view addSubview:self.datePickView];
    self.datePickView.tag = DatePickerViewType_Time;
    self.datePickView.picker.datePickerMode = UIDatePickerModeTime;
    self.datePickView.frame = CGRectMake(0, screenH, screenW, 180);
    [UIView animateWithDuration:0.2 animations:^{
        self.datePickView.transform = CGAffineTransformMakeTranslation(0, -180);
    }];
}

#pragma mark - 取消按钮点击事件
-(void)cancelBtnClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 确定按钮点击事件
-(void)sureBtnClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getters

-(UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
-(UIButton *)sureBtn{
    if (_sureBtn == nil) {
        _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _sureBtn;
}

-(UILabel *)dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = [UIFont systemFontOfSize:16];
        _dateLabel.text = @"  预约日期 ：";
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.backgroundColor = ThemeColor;
    }
    return _dateLabel;
}

-(UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:16];
        _timeLabel.text = @"  预约时间 ：";
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.backgroundColor = ThemeColor;
    }
    return _timeLabel;
}

-(UIButton *)selectDateBtn{
    if (_selectDateBtn == nil) {
        _selectDateBtn = [[UIButton alloc]init];
        [_selectDateBtn setTitle:@"点击选择预约日期" forState:UIControlStateNormal];
        [_selectDateBtn setTitleColor:UIColorFromRGB(0x868686) forState:UIControlStateNormal];
        _selectDateBtn.backgroundColor = UIBottomViewColor;
        [_selectDateBtn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectDateBtn;
}

-(UIButton *)selectTimeBtn{
    if (_selectTimeBtn == nil) {
        _selectTimeBtn = [[UIButton alloc]init];
        [_selectTimeBtn setTitle:@"点击选择预约时间" forState:UIControlStateNormal];
        [_selectTimeBtn setTitleColor:UIColorFromRGB(0x868686) forState:UIControlStateNormal];
        _selectTimeBtn.backgroundColor = UIBottomViewColor;
        [_selectTimeBtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _selectTimeBtn;
}

-(SZYDatePickView *)datePickView{
    if (_datePickView == nil){
        _datePickView = [[SZYDatePickView alloc]init];
        _datePickView.delegate = self;
    }
    return _datePickView;
}


@end
