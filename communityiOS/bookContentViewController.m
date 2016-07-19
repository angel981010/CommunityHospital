//
//  bookContentViewController.m
//  hospitalAppointment
//
//  Created by 刘芮东 on 16/7/15.
//  Copyright © 2016年 刘芮东. All rights reserved.
//

#import "bookContentViewController.h"
#import "MBProgressHUD.h"
#import "AppointmentViewController.h"
#define screenW     [UIScreen mainScreen].bounds.size.width
#define screenH      [UIScreen mainScreen].bounds.size.height
@interface bookContentViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSArray *doctorArr;
@property (nonatomic, strong) NSArray *medicalArr;
@property (nonatomic, strong) UIButton *appointmentBtn;
@property (nonatomic,strong) MBProgressHUD *hud;
@end

@implementation bookContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self setData];
    self.title = self.selfTitle;
    [self setControlFrame];
    [self addAllControl];
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:self.hud];
    self.hud.dimBackground = NO;
    self.hud.labelText = @"预约成功";
    self.hud.mode = MBProgressHUDModeText;
    self.hud.square = YES;
    self.hud.labelFont = [UIFont systemFontOfSize:16];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getContentLabelText{

    for (int i=0; i<_doctorArr.count; i++) {
        if ([self.selfTitle isEqualToString:_doctorArr[i][@"doctorName"]]) {
            self.contentLabel.text = _doctorArr[i][@"content"];
            self.positionLabel.text = _doctorArr[i][@"position"];
        }
    }
}


-(void)setControlFrame{
    
    self.topView.frame = CGRectMake(0, 20, screenW, 64);
    self.topLabel.frame = CGRectMake(80, 0, screenW-160, 64);
    self.returnBtn.frame = CGRectMake(20, 19, 29, 29);
    self.positionLabel.frame = CGRectMake(0, 254, screenW, 50);
    [self getContentLabelText];
    CGSize size =[self.contentLabel.text  boundingRectWithSize:CGSizeMake(screenW-160, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    self.contentLabel.frame = CGRectMake(40, 310, screenW-80, size.height);
    self.appointmentBtn.frame = CGRectMake(screenW/2-90, 620, 180, 40);
}

-(void)addAllControl{
    
//    [self.view addSubview:self.topView];
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.positionLabel];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.appointmentBtn];
}

-(void)backToRoot{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)appointmentDoctor:(UIButton *)btn{
    
    AppointmentViewController *appointVC = [[AppointmentViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:appointVC];
    [self presentViewController:nav animated:YES completion:nil];
    
    

//    btn.selected = !btn.selected;
//    if (btn.selected) {
//        self.hud.labelText = @"预约成功";
//        [self.appointmentBtn setTitle:@"已预约" forState:UIControlStateNormal];
//        [self.hud show:YES];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            // 移除HUD
//            [self.hud hide:YES];
//            
//        });
//    }
//    else{
//        self.hud.labelText = @"取消成功";
//        [self.appointmentBtn setTitle:@"预约" forState:UIControlStateNormal];
//        [self.hud show:YES];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            // 移除HUD
//            [self.hud hide:YES];
//            
//        });
//    }
    
    
    
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您已经预约成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//    [alert show];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex) {
//        case 0:
//            
//            
//            break;
//            
//        default:
//            break;
//    }
//}




#pragma mark -----getters-----
-(UIView *)topView{
    
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor grayColor];
        [_topView addSubview:self.returnBtn];
        [_topView addSubview:self.topLabel];
    }
    return _topView;
}

-(UIButton *)returnBtn{
    
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_returnBtn addTarget:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnBtn;
}

-(UILabel *)topLabel{
    
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.text = self.selfTitle;
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.backgroundColor = [UIColor clearColor];
        _topLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    }
    return _topLabel;
}

-(UIImageView *)headImageView{
    
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.selfTitle]];
        _headImageView.frame = CGRectMake((screenW-150)/2, 94, 150 , 150);
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    }
    return _headImageView;
}

-(UILabel *)positionLabel{

    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc]init];
        _positionLabel.textAlignment = NSTextAlignmentCenter;
        _positionLabel.backgroundColor = [UIColor clearColor];
        _positionLabel.font = [UIFont systemFontOfSize:18];
    }
    return _positionLabel;
}

-(UILabel *)contentLabel{

    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.lineBreakMode = UILineBreakModeWordWrap;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UIButton *)appointmentBtn{

    if (!_appointmentBtn) {
        _appointmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_appointmentBtn setImage:[UIImage imageNamed:@"预约"] forState:UIControlStateNormal];
        [_appointmentBtn addTarget:self action:@selector(appointmentDoctor:) forControlEvents:UIControlEventTouchUpInside];
        [_appointmentBtn setTitle:@"预    约" forState:UIControlStateNormal];
        [_appointmentBtn setBackgroundColor:[UIColor redColor]];
        _appointmentBtn.layer.masksToBounds = YES;
        _appointmentBtn.layer.cornerRadius = 8.0f;
    }
    return _appointmentBtn;
}













-(void)setData{
    
    _doctorArr = @[
                   @{@"doctorName":@"陈军",@"content":@"简介：博士，教授，博士生导师。现任天津医科大学总医院肺部肿瘤外科主任、天津市肺癌研究所副所长。天津市“131”第一层次人选，教育新世纪优秀人才。 1995年毕业于南京铁道医学院临床医学系，2000年获华西医科大学外科学博士学位。2000年12月至2007年3月先后在加拿大纽芬兰大学医学院,美国密西根州 Van Andel 研究所和美国迈阿密大学Sylvester 肿瘤中心作博士后，从事肿瘤耐药和凋亡研究工作，遗传发育和肿瘤遗传学以及肿瘤免疫学研究工作。",@"position":@"皮肤科  主任医师"},
                   @{@"doctorName":@"陈钢",@"content":@"简介：主任医师，1966年生，1989年毕业于西安医科大学，在胸外科及肺部肿瘤外科专门从事肺部及纵隔肿瘤的诊断、外科手术及综合治疗工作25年。多年来坚持从事合并糖尿病、高血压、冠心病、脑血管病等合并症肺部外科手术研究，积累了丰富的临床经验。并率先开展胸部微创手术，临床疗效优良。",@"position":@"肺外科门诊  主任医师"},
                   @{@"doctorName":@"韦森",@"content":@"简介：学历：博士职称：副主任医师 毕业于中国协和医科大学，获肿瘤外科学硕士学位，后师从于著名肺部肿瘤专家周清华教授，获胸外科博士学位。 参加工作近20年，主要从事肺癌及纵膈肿瘤以外科手术为主的个体化综合治疗，取得良好临床效果；近年开展早期肺癌的胸腔镜微创外科临床研究，积累了丰富的临床经验。",@"position":@"肺外科门诊  副主任医师"},
                   @{@"doctorName":@"嵇希敏",@"content":@"简介：1995年毕业于天津医科大学临床医学专业，先后攻读内科学研究生并获医学硕士和博士学位，现为天津医科大学总医院风湿免疫科副主任医师，中国医院协会医院感染管理专业委员会青年委员。多年从事系统性红斑狼疮、类风湿关节炎等各种风湿性疾病的临床诊断和治疗。尤其对危重症和难治性风湿病，包括皮肌炎、血管炎等疾病的临床诊疗有深入的研究。能够积极应用新技术提高临床诊疗水平，在天津市较早开展了PET-CT诊断大动脉炎、血浆置换治疗巨噬细胞活化综合征以及生物制剂治疗银屑病关节炎等新技术手段。",@"position":@"风湿-关节病  副主任医师"},
                   @{@"doctorName":@"孙跃民",@"content":@"简介：副主任医师，医学博士。中国医师协会心血管分会青年委员，天津心脏学会冠心病学会常委。获卫生部颁发全国卫生工作援藏先进个人一次。参与国家十一五支撑计划科研一项，主持市级课题一项。国内外发表论文6篇，参编论著2部。韩国大学九老医院心脏中心进修冠心病介入治疗1年。",@"position":@"心脏内科门诊  副主任医师"},
                   @{@"doctorName":@"周惠芳",@"content":@"简介：天津医科大学总医院耳鼻咽喉科主任，教授，硕士生导师.担任中国康复医学会听力康复专业委员会 副主任委员，中国中西医结合学会耳鼻咽喉科专业委员会 全国常委，天津康复医学会听力语言康复专业委员会 主任委员，中华医学会天津耳鼻喉头颈外科分会 副主任委员。出色完成耳鼻喉科中、大型手术。以高尚的医德医风，精湛的医术受到患者及家属的信赖和好评。",@"position":@"耳鼻喉科门诊  特需"},
          ];
    
}

@end
