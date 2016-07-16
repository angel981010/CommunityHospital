//
//  Detail4Food2ViewController.h
//  communityiOS
//
//  Created by tjufe on 16/1/6.
//  Copyright © 2016年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommodityInfo.h"

@interface Detail4Food2ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *IntoShopBt;
- (IBAction)IntoShopOnclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *CallSellerBt;
- (IBAction)CallSellerOnclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BuyNowBt;
- (IBAction)BuyNowOnclick:(id)sender;

- (IBAction)MorePicOnclick:(id)sender;

-(void)getCommodityInfo:(id)comm_info;

@property(nonatomic,strong)CommodityInfo *comm_info;//商品信息
@property(nonatomic,strong)NSString *shop_name;//商家名称
@property (nonatomic,strong)NSString *shop_phone;
@property (weak, nonatomic) IBOutlet UITableView *FoodDetailTableView;


@end
