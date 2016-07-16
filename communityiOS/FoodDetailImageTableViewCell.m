//
//  FoodDetailImageTableViewCell.m
//  communityiOS
//
//  Created by tjufe on 16/1/6.
//  Copyright © 2016年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "FoodDetailImageTableViewCell.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation FoodDetailImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setComm_sales:(NSString *)comm_sales{
    [_CommSales setText:comm_sales];
}

-(void)setComm_image_url:(NSString *)comm_image_url{
    NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,comm_image_url];
    
    [_CommImage sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
        if(image!=nil){
            self.CommImage.image = image;
        }
        else{
            self.CommImage.image = [UIImage imageNamed:@"loading"];
            
        }
        
    }];
}



@end
