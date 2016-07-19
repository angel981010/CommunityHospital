//
//  nurseBookTableViewCell.m
//  hospitalAppointment
//
//  Created by 刘芮东 on 16/7/15.
//  Copyright © 2016年 刘芮东. All rights reserved.
//

#import "nurseBookTableViewCell.h"
#define screenW     [UIScreen mainScreen].bounds.size.width
#define screenH      [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIViewColor UIColorFromRGB(0xE6E6E6)

@interface nurseBookTableViewCell()

@property (nonatomic,strong) UIImageView        *headImageView;
@property (nonatomic,strong) UILabel            *nameLabel;
@property (nonatomic,strong) UILabel            *contentLabel;
@property (nonatomic, strong) UIButton  *hubBtn;


@end

@implementation nurseBookTableViewCell


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

    [self addSubview:self.headImageView];
    self.nameLabel.text = dict[@"doctorName"];
    [self addSubview:self.nameLabel];
    self.contentLabel.text = dict[@"content"];
    CGSize size =[self.contentLabel.text  boundingRectWithSize:CGSizeMake(screenW-160, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.contentLabel.frame = CGRectMake(120, 50, screenW-160, size.height);
    [self addSubview:self.contentLabel];
    self.cellHeight = 60+size.height;
    if (CGRectGetMaxY(self.headImageView.frame) > CGRectGetMaxY(self.contentLabel.frame)) {
        self.cellHeight = CGRectGetMaxY(self.headImageView.frame) + 10;
    }
    
    self.hubBtn.frame = CGRectMake(0, 0, screenW, self.cellHeight);
    [self addSubview:self.hubBtn];
    
    self.headImageView.image = [UIImage imageNamed:dict[@"doctorName"]];

}

-(void)turnToPersonView:(UIButton*)sender{

    self.cellClickBlock((UIButton *)sender,[NSString stringWithString:self.nameLabel.text]);
}




#pragma mark -----getters-----
-(UIImageView *)headImageView{

    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.frame = CGRectMake(20, 20, 70 , 70);
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    }
    return _headImageView;
}

-(UILabel *)nameLabel{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.frame = CGRectMake(120, 0, screenW-120, 60);
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:18];
    }
    return _nameLabel;
}

-(UILabel *)contentLabel{

    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.lineBreakMode = UILineBreakModeWordWrap;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UIButton *)hubBtn{

    if (!_hubBtn) {
        _hubBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hubBtn.backgroundColor = [UIColor clearColor];
        [_hubBtn addTarget:self action:@selector(turnToPersonView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hubBtn;
}




@end
