//
//  medicineDetailTableViewCell.m
//  hospitalAppointment
//
//  Created by 刘芮东 on 16/7/15.
//  Copyright © 2016年 刘芮东. All rights reserved.
//

#import "medicineDetailTableViewCell.h"
#define screenW     [UIScreen mainScreen].bounds.size.width
#define screenH      [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIViewColor UIColorFromRGB(0xE6E6E6)

@interface medicineDetailTableViewCell ()

@property (nonatomic,strong)UILabel     *nameLabel;
@property (nonatomic,strong)UILabel     *stockLabel;

@end

@implementation medicineDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self addAllControlWithModel:dict];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)addAllControlWithModel:(NSDictionary *)dict{

    self.nameLabel.text = [@"药品名称：" stringByAppendingString:dict[@"medicalName"]];
    [self addSubview:self.nameLabel];
    self.stockLabel.text = [@"库存：" stringByAppendingString:dict[@"stock"]];
    [self addSubview:self.stockLabel];
    self.cellHeight = self.nameLabel.bounds.size.height;
}



#pragma mark -----getters-----

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.frame = CGRectMake(20 , 0, screenW/4*3, 50);
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

-(UILabel *)stockLabel{

    if (!_stockLabel) {
        _stockLabel = [[UILabel alloc]init];
        _stockLabel.frame = CGRectMake(screenW/4*3 , 0, screenW/4, 50);
        _stockLabel.backgroundColor = [UIColor clearColor];
        _stockLabel.font = [UIFont systemFontOfSize:15];
        _stockLabel.textAlignment = NSTextAlignmentLeft;
    
    }
    return _stockLabel;
}



@end
