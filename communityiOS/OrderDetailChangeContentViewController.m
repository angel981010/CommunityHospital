//
//  OrderDetailChangeContentViewController.m
//  communityiOS
//
//  Created by tjufe on 16/1/7.
//  Copyright © 2016年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderDetailChangeContentViewController.h"
#import "OrderDetailChangeContentTableViewCell.h"

@interface OrderDetailChangeContentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)NSString *titlel;
@property (assign,nonatomic)NSInteger row;
@property (strong,nonatomic)NSString *content;
@property (strong,nonatomic)OrderDetailChangeContentTableViewCell *ODCContentCell;
@end

@implementation OrderDetailChangeContentViewController

-(void)getTitle:(NSString *)title andRow:(NSInteger )row andContent:(NSString *)content{
    
    self.titlel = title;
    self.row = row;
    self.content = content;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   self.ODCContentCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!_ODCContentCell) {
        _ODCContentCell= [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailChangeContentTableViewCell" owner:nil options:nil]objectAtIndex:0];
        _ODCContentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _ODCContentCell.OrderDetailChangeContent.text = self.content;
    return _ODCContentCell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 160;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.OrderDetailChangeContentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消下划线

    self.navigationItem.title = self.titlel;

//    temporaryBarButtonItem.target = self;
//    temporaryBarButtonItem.action = @selector(saveChange);
//    [self.navigationItem.backBarButtonItem setTarget:self];
//    [self.navigationItem.backBarButtonItem setAction:@selector(saveChange)];
    // Do any additional setup after loading the view.
    
    
    //设置导航右侧按钮
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *image = [UIImage imageNamed:@"icon_main_add"];
    
    button.frame = CGRectMake(self.view.frame.size.width-40, 20, 40, 20);
    
    // 这里需要注意：由于是想让图片右移，所以left需要设置为正，right需要设置为负。正在是相反的。
    // 让按钮图片右移15
    //    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    
    [button setTitle:@"完成"  forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveChange) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
     self.navigationItem.rightBarButtonItem = rightItem;

}

-(void)saveChange{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.row forKey:@"indexRow"];
    [defaults setObject:_ODCContentCell.OrderDetailChangeContent.text forKey:@"ChangeContent"];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
