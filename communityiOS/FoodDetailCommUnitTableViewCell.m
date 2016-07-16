//
//  FoodDetailCommUnitTableViewCell.m
//  communityiOS
//
//  Created by tjufe on 16/1/6.
//  Copyright © 2016年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "FoodDetailCommUnitTableViewCell.h"

@implementation FoodDetailCommUnitTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setComm_unit:(NSString *)comm_unit{
    [_CommUnit setText:comm_unit];
}

@end
