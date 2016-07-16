//
//  Detail4Food2ViewController.m
//  communityiOS
//
//  Created by tjufe on 16/1/6.
//  Copyright © 2016年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "Detail4Food2ViewController.h"
#import "CollectionViewCell4Food.h"
#import "UIViewController+Create.h"
#import "ViewController4Food.h"
#import "OrderDetailViewController.h"
#import "UIAlertView+Blocks.h"

#import "CommodityInfo.h"
#import "CommSales.h"

#import "AppDelegate.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "StatusTool.h"

#import "ShoppingCartViewController.h"
#import "String.h"
#import "ShoppingCartCommodity.h"
#import "MoreCommPicViewController.h"

//wangyao0106
#import "FoodDetailImageTableViewCell.h"
#import "FoodDetailNameTableViewCell.h"
#import "FoodDetailCommDescribeTableViewCell.h"
#import "FoodDetailCommPriceTableViewCell.h"
#import "FoodDetailCommUnitTableViewCell.h"

//wangyao0107
#import "MJRefresh.h"
#import "MoreCommPicList.h"
#import "MoreCommPicTableViewCell.h"
#import "MBProgressHUD.h"
#import "OrderDetailChangeContentViewController.h"
#import "UIViewController+Create.h"


@interface Detail4Food2ViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(strong,nonatomic)FoodDetailImageTableViewCell *FDImageTVCell;
@property(strong,nonatomic)FoodDetailNameTableViewCell *FDNameTVCell;
@property(strong,nonatomic)FoodDetailCommDescribeTableViewCell *FDCommDescribeTVCell;
@property(strong,nonatomic)FoodDetailCommPriceTableViewCell *FDCommPriceTVCell;
@property(strong,nonatomic)FoodDetailCommUnitTableViewCell *FDCommUnitTVCell;

@property(strong,nonatomic)NSArray * pic_list;

@end

@implementation Detail4Food2ViewController

float FDImageTVCellheight = 310;
float FDNameTVCellHeight = 0;
float FDCommDescribeTVCellHeight = 0;
float FDCommPriceTVCellHeight = 32;
float FDCommUnitTVCellHeight = 17;
bool  hadLoadMorePic = false;

-(void)getCommodityInfo:(id)comm_info{
    self.comm_info = (CommodityInfo *)comm_info;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.pic_list count] + 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //商品主图
    if (indexPath.row == 0 ) {
        //        self.SIMainImageTVCell = [tableView dequeueReusableCellWithIdentifier:nil];
        self.FDImageTVCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!self.FDImageTVCell) {
            self.FDImageTVCell= [[[NSBundle mainBundle]loadNibNamed:@"FoodDetailImageTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.FDImageTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (![self.comm_info.comm_photo isEqualToString:@""]&&self.comm_info.comm_photo!=nil) {
            [self.FDImageTVCell setComm_image_url:self.comm_info.comm_photo];
        }else{
            self.FDImageTVCell.CommImage.image = [UIImage imageNamed:@"loading"];
        }
        //调用网络接口获取销量
        [StatusTool statusToolGetCommSalesWithComm_id:self.comm_info.commodity_id Success:^(id object) {
            CommSales *comm_sales = (CommSales *)object;
            [self.FDImageTVCell setComm_sales:[NSString stringWithFormat:@"%d",comm_sales.comm_sales]];
        } failurs:^(NSError *error) {
            NSLog(@"fail to get comm sales");
        }];


        return self.FDImageTVCell;
        //商品名称
    }else if(indexPath.row == 1){
        //        self.SISNameTVCell =[tableView dequeueReusableCellWithIdentifier:nil];
        self.FDNameTVCell =[tableView cellForRowAtIndexPath:indexPath];
        if (!self.FDNameTVCell) {
            self.FDNameTVCell= [[[NSBundle mainBundle]loadNibNamed:@"FoodDetailNameTableViewCell" owner:nil options:nil]objectAtIndex:0];
          
            self.FDNameTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self.FDNameTVCell setComm_name:self.comm_info.comm_name];
              //改变cell的高度需要reload该cell
        CGSize size = CGSizeMake(300, 1000);
        CGSize labelSize = [self.FDNameTVCell.CommName.text sizeWithFont:self.FDNameTVCell.CommName.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
        //            SISNameTVCellHeight = labelSize.height+10;
        CGRect rect = self.FDNameTVCell.frame;
        rect.size.height = labelSize.height;
        self.FDNameTVCell.frame = rect;
        NSLog(@"^^^^^^FDNameTVCellheight%f",labelSize.height);
        return self.FDNameTVCell;
        //商品描述
    }else if(indexPath.row == 2){
        //        self.SISIntroTVCell =[tableView dequeueReusableCellWithIdentifier:nil];
        self.FDCommDescribeTVCell =[tableView cellForRowAtIndexPath:indexPath];
        
        if (!self.FDCommDescribeTVCell) {
            self.FDCommDescribeTVCell= [[[NSBundle mainBundle]loadNibNamed:@"FoodDetailCommDescribeTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.FDCommDescribeTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [self.FDCommDescribeTVCell setComm_describe:self.comm_info.comm_desc];
        CGSize size = CGSizeMake(300, 1000);
        
        CGSize labelSize1 = [self.FDCommDescribeTVCell.CommDescribe.text sizeWithFont:self.FDCommDescribeTVCell.CommDescribe.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
        FDCommDescribeTVCellHeight = labelSize1.height+30;
        CGRect rect = self.FDCommDescribeTVCell.frame;
        rect.size.height = labelSize1.height;
        self.FDCommDescribeTVCell.frame = rect;
        NSLog(@"^^^^^^^^FDCommDescribeTVCell%f",labelSize1.height);
        return self.FDCommDescribeTVCell;
        //商品单位
    }else if (indexPath.row == 3){
        //        self.SISuggestImageTVCell =[tableView dequeueReusableCellWithIdentifier:nil];
        self.FDCommUnitTVCell =[tableView cellForRowAtIndexPath:indexPath];
        if (!self.FDCommUnitTVCell) {
            self.FDCommUnitTVCell= [[[NSBundle mainBundle]loadNibNamed:@"FoodDetailCommUnitTableViewCell" owner:nil options:nil]objectAtIndex:0];
        }
        [self.FDCommUnitTVCell setComm_unit:self.comm_info.comm_unit];
        return self.FDCommUnitTVCell;
        //商品价格
    }else if(indexPath.row == 4){
        self.FDCommPriceTVCell =[tableView cellForRowAtIndexPath:indexPath];
        if (!self.FDCommPriceTVCell) {
            self.FDCommPriceTVCell= [[[NSBundle mainBundle]loadNibNamed:@"FoodDetailCommPriceTableViewCell" owner:nil options:nil]objectAtIndex:0];
        }
        [self.FDCommPriceTVCell setComm_price:self.comm_info.comm_price];
        return self.FDCommPriceTVCell;
    }else{
        MoreCommPicTableViewCell *MCPCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!MCPCell) {
            MCPCell =[[[NSBundle mainBundle] loadNibNamed:@"MoreCommPicTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        [MCPCell setMore_comm_pic:[self.pic_list objectAtIndex:indexPath.row-5]];
        return MCPCell;
    
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        return FDImageTVCellheight;
    }else if (indexPath.row ==1){
        
        return self.FDNameTVCell.frame.size.height+10;
        //        return 30;
    }else if (indexPath.row == 2){
        if (![self.comm_info.comm_desc isEqualToString:@""]&&self.comm_info.comm_desc!=nil) {
            return self.FDCommDescribeTVCell.frame.size.height+10;
        }else{
            return 0;
        }
        
        //        return 30;
    }else if (indexPath.row ==3){
        return FDCommUnitTVCellHeight+10;
    }else if(indexPath.row ==4){
        return FDCommPriceTVCellHeight+30;
    }else{//更多图片
        
        return 150;
    }
    
}



#pragma mark----添加商品到购物车---- lx
- (IBAction)addShoppingCart:(id)sender {
    
    ShoppingCartCommodity *newfood = [[ShoppingCartCommodity alloc]init];
    newfood.commodity_id = _comm_info.commodity_id;
    newfood.comm_name = _comm_info.comm_name;
    newfood.comm_photo = _comm_info.comm_photo;
    newfood.comm_price = _comm_info.comm_price;
    newfood.comm_unit = _comm_info.comm_unit;
    newfood.shop_id = _comm_info.shop_id;
    newfood.shop_name = _shop_name;
    newfood.shop_phone = self.shop_phone;
    newfood.buy_amount=1;
    newfood.select_status = 0;
    
    //获取路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *file_path = [documentDirectory stringByAppendingPathComponent:
                           ShoppingCartFile];
    //接档，读取文件数据
    NSMutableArray *cart = [[NSMutableArray alloc]init];
    cart = [NSKeyedUnarchiver unarchiveObjectWithFile:file_path];
    
    bool flag_shop = false;
    bool flag_commodity = false;
    
    if(cart && [cart count]>0){//购物车不为空
        for(int i=0;i<[cart count];i++){
            NSMutableArray *comm_array = [cart objectAtIndex:i];
            
            ShoppingCartCommodity *s = [comm_array objectAtIndex:0];
            if([s.shop_id isEqualToString:newfood.shop_id ]){//同一商家
                flag_shop = true;
                for(int j=0;j<[comm_array count];j++){
                    ShoppingCartCommodity *s = [comm_array objectAtIndex:j];
                    if([s.commodity_id isEqualToString: newfood.commodity_id]){//找到同一商品
                        newfood.buy_amount=s.buy_amount+1;
                        [comm_array removeObject:s];
                        [comm_array addObject:newfood];
                        NSMutableArray *comm_array2 = [NSMutableArray arrayWithArray:comm_array];
                        [cart removeObject:comm_array];
                        [cart addObject:comm_array2];
                        flag_commodity = true;
                        break;
                    }else{
                        flag_commodity = false;
                    }
                }
                if(!flag_commodity){//同家不同商品
                    
                    [comm_array addObject:newfood];
                    NSMutableArray *comm_array2 = [NSMutableArray arrayWithArray:comm_array];
                    [cart removeObject:comm_array];
                    [cart addObject:comm_array2];
                    
                }
                
            }else{
                flag_shop = false;//不同家
            }
        }
        
        
        
        if(!flag_shop){//不同家
            NSMutableArray *comm_array2 = [[NSMutableArray alloc]init];
            [comm_array2 addObject:newfood];
            [cart addObject:comm_array2];
        }
        
        
        
    }else{//购物车cart为空
        cart = [[NSMutableArray alloc]init];
        NSMutableArray *comm_array = [[NSMutableArray alloc]init];
        [comm_array addObject:newfood];
        [cart addObject:comm_array];
        
        
    }
    
    //先删除归档
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager isDeletableFileAtPath:file_path]){
        [fileManager removeItemAtPath:file_path error:nil];
    }
    //再重新添加,保存归档
    bool flag =[NSKeyedArchiver archiveRootObject:cart toFile:file_path];
    if(flag){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已添加到购物车" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
}

#pragma mark----跳转到购物车页-----  lx
- (IBAction)go2ShoppingCart:(id)sender {
    
    ShoppingCartViewController *SCVC = [ShoppingCartViewController createFromStoryboardName:@"ShoppingCart" withIdentifier:@"ShoppingCart"];
    [self.navigationController pushViewController:SCVC animated:YES];
    
}

- (IBAction)IntoShopOnclick:(id)sender {
    //    ViewController4Food *vc4f = [ViewController4Food createFromStoryboardName:@"CollectionView4Food" withIdentifier:@"CollectionView4Food"];
    //    [self.navigationController pushViewController:vc4f animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)CallSellerOnclick:(id)sender {
    NSString *buildNameStr =@"买家电话:";
    buildNameStr = [buildNameStr stringByAppendingString:self.shop_phone];
    
    [UIAlertView showAlertViewWithTitle:@"卖家详情" message:buildNameStr cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
        
        ;
    } onCancel:^{
        
    }];
}

#pragma mark--跳到立即购买
- (IBAction)BuyNowOnclick:(id)sender {
    
    ShoppingCartCommodity *newfood = [[ShoppingCartCommodity alloc]init];
    newfood.commodity_id = _comm_info.commodity_id;
    newfood.comm_name = _comm_info.comm_name;
    newfood.comm_photo = _comm_info.comm_photo;
    newfood.comm_price = _comm_info.comm_price;
    newfood.comm_unit = _comm_info.comm_unit;
    newfood.shop_id = _comm_info.shop_id;
    newfood.shop_name = _shop_name;
    newfood.shop_phone = self.shop_phone;
    newfood.buy_amount=1;
    newfood.select_status = 0;
    
    NSMutableArray *se_array = [[NSMutableArray alloc]init];
    [se_array addObject:newfood];
    NSMutableArray *comm_array = [[NSMutableArray alloc]init];
    [comm_array addObject:se_array];
    
    
    OrderDetailViewController *ODVC = [OrderDetailViewController createFromStoryboardName:@"OrderDetail" withIdentifier:@"order_detail"]
    ;
    
    ODVC.order_comm = comm_array;
    
    [self.navigationController pushViewController:ODVC animated:YES];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏
    self.navigationItem.title = @"商品详情";
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    self.FoodDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消下划线
    //设置上拉加载更多图片
    [self setupMorePic];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    hadLoadMorePic = false;
}

-(void)setupMorePic{
    //waring自动刷新
    //   [self.pltable headerBeginRefreshing];
    //上拉加载更多
    [self.FoodDetailTableView addFooterWithTarget:self action:@selector(footerGetMorePic)];
}

-(void)footerGetMorePic{
    
//    page1++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //          [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if (hadLoadMorePic ==false) {
             [self loadMorePic];
        }
       
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.FoodDetailTableView footerEndRefreshing];
    });
    
}
-(void)loadMorePic{
    [MoreCommPicList LoadMoreCommPicWithCommID:self.comm_info.commodity_id Success:^(id object) {
        //        self.pic_list = (NSArray *)object;
        if (object==nil) {
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:hud];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"没有更多内容了！";
            [hud showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            }completionBlock:^{
                [hud removeFromSuperview];
//                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        }else{
            self.pic_list = (NSArray *)object;
            NSLog(@"^^^^^^^^^^^^^^PIC_LIST%@",self.pic_list);
            [self.FoodDetailTableView reloadData];
            hadLoadMorePic = true;
        }
        
        
    } failurs:^(NSError *error) {
        NSLog(@"^^^^^^%@",error);
    }];
    
    
    
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
