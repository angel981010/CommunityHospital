//
//  orderViewController.m
//  hospitalAppointment
//
//  Created by 刘芮东 on 16/7/15.
//  Copyright © 2016年 刘芮东. All rights reserved.
//

#import "orderViewController.h"
#import "nurseBookTableViewCell.h"
#import "medicineDetailTableViewCell.h"
#import "bookContentViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIViewColor UIColorFromRGB(0xE6E6E6)

#define UIBottomViewColor UIColorFromRGB(0xF2F2F5)
#define screenW     [UIScreen mainScreen].bounds.size.width
#define screenH      [UIScreen mainScreen].bounds.size.height



@interface orderViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL doctorViewShow;
}

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *leftBtnView;
@property (nonatomic, strong) UIView *rightBtnView;
@property (nonatomic, strong) UIButton *leftDoctorViewBtn;
@property (nonatomic, strong) UIButton *rightMedicalViewBtn;
@property (nonatomic, strong) UITableView *doctorListTableView;
@property (nonatomic, strong) UITableView *medicalListTableView;
@property (nonatomic, strong) NSArray *doctorArr;
@property (nonatomic, strong) NSArray *medicalArr;
@property (nonatomic, strong) UIView  *sepView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation orderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"总医院";
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setData];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setControlFrame];
    [self addAllControl];
    
}

-(void)setControlFrame{

    self.topView.frame = CGRectMake(0, 20, screenW, 64);
    self.topLabel.frame = CGRectMake(80, 0, screenW-160, 64);
    self.returnBtn.frame = CGRectMake(20, 19, 29, 29);
    self.doctorListTableView.frame = CGRectMake(0, 0, screenW, screenH - 64);
    self.medicalListTableView.frame = CGRectMake(0, 64, screenW, screenH - 128);
    self.bottomView.frame = CGRectMake(0, screenH-64, screenW, 64);
    self.leftBtnView.frame = CGRectMake(0, 0, screenW/2, 64);
    
    self.rightBtnView.frame = CGRectMake(screenW/2, 0, screenW/2, 64);
    self.leftDoctorViewBtn.frame = CGRectMake(screenW/4-11, 10, 22, 22);
    self.leftLabel.frame = CGRectMake(screenW/4-25, 35, 100, 20);
    self.leftLabel.center = CGPointMake(self.leftDoctorViewBtn.center.x, self.leftLabel.center.y);
    self.rightMedicalViewBtn.frame = CGRectMake(screenW/4-15, 10, 22, 22);
    self.rightLabel.frame = CGRectMake(screenW/4-25, 35, 100, 20);
    self.rightLabel.center = CGPointMake(self.rightMedicalViewBtn.center.x, self.rightLabel.center.y);
}


-(void)addAllControl{

//    [self.view addSubview:self.topView];
    doctorViewShow = YES;
    [self.view addSubview:self.doctorListTableView];
    [self.view addSubview:self.bottomView];
    
    self.sepView=[[UIView alloc]initWithFrame:CGRectMake(screenW/2, 5, 0.5,54)];
    self.sepView.backgroundColor = UIColorFromRGB(0xCECED0);
    [self.bottomView addSubview:self.sepView];
    [self.leftBtnView addSubview:self.leftLabel];
    [self.rightBtnView addSubview:self.rightLabel];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (doctorViewShow == YES) {
////        bookContentViewController *bookVC = [[bookContentViewController alloc]init];
////        [self.navigationController pushViewController:bookVC animated:YES];
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (doctorViewShow == YES) {
        return _doctorArr.count;
    }else{
        return _medicalArr.count;
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (doctorViewShow == YES) {
        int i = (int)indexPath.row;
        nurseBookTableViewCell *doctorCell = [[nurseBookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"doctorCell" andDictionary:_doctorArr[i]];
        return doctorCell.cellHeight;
    }else{
        int i = (int)indexPath.row;
        medicineDetailTableViewCell *medicalCell = [[medicineDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"medicalCell" andDictionary:_medicalArr[i]];
        return medicalCell.cellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (doctorViewShow == YES) {
        int i = (int)indexPath.row;
        nurseBookTableViewCell *doctorCell = [[nurseBookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"doctorCell" andDictionary:_doctorArr[i]];
        [doctorCell setCellClickBlock:^(UIButton *btn, NSString *str) {
            bookContentViewController *bookVC = [[bookContentViewController alloc]init];
            bookVC.selfTitle = str;
            [self.navigationController pushViewController:bookVC animated:YES];
        }];
        cell = doctorCell;
    }else{
        int i = (int)indexPath.row;
        medicineDetailTableViewCell *medicalCell = [[medicineDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"medicalCell" andDictionary:_medicalArr[i]];
        cell = medicalCell;
    }

    return cell;
}
#pragma mark -----click-----
-(void)backToRoot{

}

-(void)turnToDoctorList:(UIButton *)btn{
    btn.selected=!btn.selected;
    self.rightMedicalViewBtn.selected=NO;
    self.leftDoctorViewBtn.selected=YES;
    self.rightLabel.textColor=[UIColor blackColor];
    self.leftLabel.textColor=[UIColor redColor];
//    self.leftDoctorViewBtn.selected=!self.leftDoctorViewBtn.selected;
    if (doctorViewShow == NO) {
        [self.medicalListTableView removeFromSuperview];
        self.rightBtnView.layer.borderColor = [[UIColor clearColor] CGColor];
        
        [self.view addSubview:self.doctorListTableView];
        
        
        doctorViewShow = YES;
    }
}

-(void)turnToMedcialList:(UIButton *)btn{
//    btn.selected=!btn.selected;
    self.rightMedicalViewBtn.selected=YES;
    self.leftDoctorViewBtn.selected=NO;
//    self.rightMedicalViewBtn.selected=!self.rightMedicalViewBtn;
    self.leftLabel.textColor=[UIColor blackColor];
    self.rightLabel.textColor=[UIColor redColor];
    if (doctorViewShow == YES) {
        [self.doctorListTableView removeFromSuperview];
        self.leftBtnView.layer.borderColor = [[UIColor clearColor] CGColor];
        
        [self.view addSubview:self.medicalListTableView];
       
        
        doctorViewShow = NO;
    }
}

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
        _topLabel.text = @"总医院";
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.backgroundColor = [UIColor clearColor];
        _topLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    }
    return _topLabel;
}

-(UITableView *)doctorListTableView{

    if (!_doctorListTableView) {
        _doctorListTableView = [[UITableView alloc]init];
        [_doctorListTableView registerClass:[nurseBookTableViewCell class] forCellReuseIdentifier:@"doctorCell"];
        _doctorListTableView.backgroundColor = [UIColor clearColor];
//        _doctorListTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _medicalListTableView.allowsSelection = NO;
        _doctorListTableView.dataSource=self;
        _doctorListTableView.delegate=self;
        _doctorListTableView.showsVerticalScrollIndicator = NO;
    }
    return _doctorListTableView;
}

-(UIView *)bottomView{

    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = UIBottomViewColor;
        [_bottomView addSubview:self.leftBtnView];
        [_bottomView addSubview:self.rightBtnView];
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor=[UIColorFromRGB(0xCECED0) CGColor];
        
    }
    return _bottomView;
}

-(UIView *)leftBtnView{

    if (!_leftBtnView) {
        _leftBtnView = [[UIView alloc]init];
        _leftBtnView.backgroundColor = [UIColor clearColor];
        [_leftBtnView addSubview:self.leftDoctorViewBtn];
        
        UIButton *hubBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        hubBtn.backgroundColor = [UIColor clearColor];
        hubBtn.frame = CGRectMake(0, 0, screenW/2, 64);
        
        [hubBtn addTarget:self action:@selector(turnToDoctorList:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtnView addSubview:hubBtn];
    }
    return _leftBtnView;
}

-(UIView *)rightBtnView{
    
    if (!_rightBtnView) {
        _rightBtnView = [[UIView alloc]init];
        _rightBtnView.backgroundColor = [UIColor clearColor];
        [_rightBtnView addSubview:self.rightMedicalViewBtn];
        UIButton *hubBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        hubBtn.backgroundColor = [UIColor clearColor];
        hubBtn.frame = CGRectMake(0, 0, screenW/2, 64);
        [hubBtn addTarget:self action:@selector(turnToMedcialList:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtnView addSubview:hubBtn];
    }
    return _rightBtnView;
}

-(UIButton *)leftDoctorViewBtn{

    if (!_leftDoctorViewBtn) {
        _leftDoctorViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftDoctorViewBtn setImage:[UIImage imageNamed:@"人员"] forState:UIControlStateNormal];
        [_leftDoctorViewBtn setImage:[UIImage imageNamed:@"红人员"] forState:UIControlStateSelected];
        _leftDoctorViewBtn.selected=YES;
        [_leftDoctorViewBtn addTarget:self action:@selector(turnToDoctorList:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftDoctorViewBtn;
}

-(UIButton *)rightMedicalViewBtn{
    
    if (!_rightMedicalViewBtn) {
        _rightMedicalViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightMedicalViewBtn setImage:[UIImage imageNamed:@"药品"] forState:UIControlStateNormal];
        [_rightMedicalViewBtn setImage:[UIImage imageNamed:@"红药品"] forState:UIControlStateSelected];
        [_rightMedicalViewBtn addTarget:self action:@selector(turnToMedcialList:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightMedicalViewBtn;
}

-(UITableView *)medicalListTableView{
    
    if (!_medicalListTableView) {
        _medicalListTableView = [[UITableView alloc]init];
        [_medicalListTableView registerClass:[medicineDetailTableViewCell class] forCellReuseIdentifier:@"medicalCell"];
        _medicalListTableView.backgroundColor = [UIColor clearColor];
//        _medicalListTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _medicalListTableView.allowsSelection = NO;
        _medicalListTableView.dataSource=self;
        _medicalListTableView.delegate=self;
        _medicalListTableView.showsVerticalScrollIndicator = NO;
    }
    return _medicalListTableView;
}

-(UILabel *)leftLabel{
    if(!_leftLabel){
        _leftLabel=[[UILabel alloc]init];
        _leftLabel.text=@"预约挂号";
        _leftLabel.font=[UIFont systemFontOfSize:12];
        _leftLabel.textColor=[UIColor redColor];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    if(!_rightLabel){
        _rightLabel=[[UILabel alloc]init];
        _rightLabel.text=@"药品库存";
        _rightLabel.font=[UIFont systemFontOfSize:12];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightLabel;
}






-(void)setData{

    _doctorArr = @[
                   @{@"doctorName":@"陈军",
                     @"content":@"临床主要从事肺部及纵膈肿瘤的以外科治疗为主的全程管理，综合治疗工作；在肺癌的诊断、手术及综合治疗方面积累了丰富的临床经验，特别是一些高难度的手术，手术技巧高超，经验丰富,使一些中晚期患者获得了长期生存的机会。"},
                   @{@"doctorName":@"陈钢",@"content":@"在肺癌及纵隔肿瘤等胸部疾病的外科手术治疗、术后并发症处理方面积累了丰富的临床经验。多年潜心研究肺癌的早期诊断及以外科手术为主的肺癌综合治疗。"},
                   @{@"doctorName":@"韦森",@"content":@"擅长：擅长肺部肿瘤的早期诊断及治疗、肺癌及纵膈肿瘤以外科手术为主的规范化个体化综合治疗、肺癌侵犯支气管大血管的复杂手术治疗、肺大泡/气胸的诊疗、支气管扩张外科治疗及呼吸系统常见疾病的外科治疗。"},
                   @{@"doctorName":@"嵇希敏",@"content":@"擅长：擅长对难治性系统性红斑狼疮、类风湿关节炎、皮肌炎和血管炎的诊断和治疗。能够运用PET-CT技术诊断大动脉炎、血浆置换技术治疗成人斯蒂尔病，在免疫功能低下患者合并感染的防治方面具有国内领先的水平。"},
                   @{@"doctorName":@"孙跃民",@"content":@"擅长：冠心病和和临床心血管病诊疗。曾在北京医科大学第一医院心导管室进修冠心病介入治疗，多次参与有关“冠心病介入治疗”的培训。完成了总医院中青年科学基金项目和参加天津市自然科学基金项目课题。"},
                   @{@"doctorName":@"周惠芳",@"content":@"擅长：耳鼻喉科专家,擅长耳聋耳鸣眩晕面瘫的诊断治疗，耳鼻咽喉肿瘤的综合治疗。开展人工耳蜗植入术，人工听骨手术治疗耳聋，梅尼埃病手术治疗获得满意疗效。"}];
                  
    
    _medicalArr = @[
                    @{@"medicalName":@"藿香正气胶囊",@"stock":@"90"},
                    @{@"medicalName":@"阿莫西林",@"stock":@"105"},
                    @{@"medicalName":@"苄星青霉素",@"stock":@"70"},
                    @{@"medicalName":@"多西环素",@"stock":@"85"},
                    @{@"medicalName":@"左氧氟沙星",@"stock":@"66"},
                    @{@"medicalName":@"复方磺胺甲唑",@"stock":@"120"},
                    @{@"medicalName":@"地红霉素",@"stock":@"115"},
                    @{@"medicalName":@"牛黄上清丸",@"stock":@"67"},
                    @{@"medicalName":@"牛黄解毒丸",@"stock":@"94"},
                    @{@"medicalName":@"板蓝根颗粒",@"stock":@"147"},
                    @{@"medicalName":@"清热解毒颗粒",@"stock":@"49"},
                    @{@"medicalName":@"银黄口服液",@"stock":@"68"},
                    @{@"medicalName":@"藿香正气胶囊",@"stock":@"94"},
                    @{@"medicalName":@"茵栀黄口服液",@"stock":@"74"},
                    @{@"medicalName":@"复方黄连素片",@"stock":@"102"},
                    @{@"medicalName":@"理中丸",@"stock":@"98"},
                    @{@"medicalName":@"寒喘祖帕颗粒",@"stock":@"65"},
                    @{@"medicalName":@"强力枇杷露",@"stock":@"68"},
                    @{@"medicalName":@"小儿肺咳颗粒",@"stock":@"45"},
                    @{@"medicalName":@"参苓白术散",@"stock":@"112"},
                    @{@"medicalName":@"补中益气丸",@"stock":@"66"},
                    @{@"medicalName":@"安胃疡胶囊",@"stock":@"76"},
                    @{@"medicalName":@"贞芪扶正颗粒",@"stock":@"65"},
                    @{@"medicalName":@"柏子养心丸",@"stock":@"65"}
                    
                    ];
    
}


@end
