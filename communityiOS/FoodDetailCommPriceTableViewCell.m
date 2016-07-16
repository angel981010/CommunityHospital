//
//  FoodDetailCommPriceTableViewCell.m
//  communityiOS
//
//  Created by tjufe on 16/1/6.
//  Copyright © 2016年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "FoodDetailCommPriceTableViewCell.h"

@implementation FoodDetailCommPriceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setComm_price:(double )comm_price{
    [_CommPrice setText:[NSString stringWithFormat:@"%.2f",comm_price]];
}
@end
