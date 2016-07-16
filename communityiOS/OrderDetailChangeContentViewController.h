//
//  OrderDetailChangeContentViewController.h
//  communityiOS
//
//  Created by tjufe on 16/1/7.
//  Copyright © 2016年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailChangeContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *OrderDetailChangeContentTableView;
-(void)getTitle:(NSString *)title andRow:(NSInteger)row andContent:(NSString *)content;
@end
