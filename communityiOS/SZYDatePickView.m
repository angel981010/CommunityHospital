//
//  SZYDatePickView.m
//  iNote
//
//  Created by 孙中原 on 15/10/19.
//  Copyright (c) 2015年 sunzhongyuan. All rights reserved.
//

#import "SZYDatePickView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ThemeColor UIColorFromRGB(0xE53136)

@interface SZYDatePickView ()

@property (nonatomic, strong) UIView       *headerView;
@property (nonatomic, strong) UIButton     *cancelBtn;
@property (nonatomic, strong) UIButton     *sureBtn;
@property (nonatomic, strong) NSDate       *selectedDate;

@end

@implementation SZYDatePickView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8.5;
        self.layer.masksToBounds = YES;
        
        self.headerView = [[UIView alloc]init];
        self.headerView.backgroundColor = ThemeColor;
        [self addSubview:self.headerView];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:self.cancelBtn];
        
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:self.sureBtn];
        
        self.picker = [[UIDatePicker alloc]init];
//        self.picker.date = [NSDate date];
//        self.picker.datePickerMode = UIDatePickerModeDate;
        [self.picker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        self.picker.locale = locale;
        [self addSubview:self.picker];
        
        self.selectedDate = [NSDate date];
//        self.selectedDate = [nsdate string];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    self.headerView.frame = CGRectMake(0, 0, w, h * 0.2);
    self.cancelBtn.frame = CGRectMake(5, 0, 80, self.headerView.frame.size.height);
    self.sureBtn.frame = CGRectMake(self.headerView.frame.size.width-85, 0, 80, self.headerView.frame.size.height);
    
    self.picker.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), w, h * 0.8);
}

#pragma mark - 响应事件

-(void)chooseDate:(UIDatePicker *)sender{
    
    UIDatePicker *picker = (UIDatePicker *)sender;
//    self.selectedDate = [self translateDateToString:picker.date];
    self.selectedDate = picker.date;
    
}

-(void)cancelClick:(UIButton *)sender{
    [self.delegate cancelBtnDidClick];
}

-(void)sureClick:(UIButton *)sender{
    [self.delegate sureBtnDidClick:self.selectedDate];
}



#pragma mark - 私有方法

-(NSString *)translateDateToString:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}



@end
