//
//  FoodDetailCommDescribeTableViewCell.m
//  communityiOS
//
//  Created by tjufe on 16/1/6.
//  Copyright © 2016年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "FoodDetailCommDescribeTableViewCell.h"

@implementation FoodDetailCommDescribeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setComm_describe:(NSString *)comm_describe{
    [_CommDescribe setText:comm_describe];


}

@end
