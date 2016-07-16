//
//  FoodDetailImageTableViewCell.h
//  communityiOS
//
//  Created by tjufe on 16/1/6.
//  Copyright © 2016年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDetailImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CommSales;
@property (strong,nonatomic) NSString *comm_sales;
@property (weak, nonatomic) IBOutlet UIImageView *CommImage;
@property (strong,nonatomic) NSString *comm_image_url;

@end
