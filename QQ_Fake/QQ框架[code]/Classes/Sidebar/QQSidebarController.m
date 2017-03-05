//
//  QQSidebarController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQSidebarController.h"
#import "QQTabBarController.h"
#import "QQSideBarFunctionCell.h"
#import "QQFunctionModel.h"
#import "NSArray+Addition.h"
#import "UIColor+Addition.h"
#import "Masonry.h"

#define KFunctionCount _SideBarFunctionData.count
static NSString * cellID = @"CELL_ID";

@interface QQSidebarController ()<UITableViewDelegate,UITableViewDataSource>
///接收tabBarVC
@property(nonatomic,weak)QQTabBarController * tabBarVC;
@end

@implementation QQSidebarController
{
    //保存cell的function数据
    NSArray * _SideBarFunctionData;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSideBarFunctionDataWithPlistName:@"functionSidebar"];
}
#pragma mark - 搭建界面
- (void)setupUI
{
    [self setupSideBarUI];
    [self addContainerView];
}
#pragma mark - 添加容器视图
- (void)addContainerView
{
    QQTabBarController * tabBarVC = [QQTabBarController new];
    _tabBarVC = tabBarVC;
    [self addChildViewController:tabBarVC];
    [self.view addSubview:tabBarVC.view];
    [tabBarVC didMoveToParentViewController:self];
}
#pragma mark - 配置侧边栏界面
- (void)setupSideBarUI
{
    CGFloat blueViewH = 60;    
    //顶部冰洋图片
    UIImage * img = [UIImage imageNamed:@"sidebar_bg"];
    UIImageView * imgV = [[UIImageView alloc] initWithImage:img];
    [self.view addSubview:imgV];
    CGFloat imgViewH = img.size.height / img.size.width * self.view.bounds.size.width;
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(imgViewH);
    }];
    
    //中部tableView
    UITableView * tv = [UITableView new];
    //背景色
    tv.backgroundColor = [UIColor colorWithHex:0x12B7f5];
    [self.view addSubview:tv];
    tv.dataSource = self;
    tv.delegate = self;
    [tv registerClass:[QQSideBarFunctionCell class] forCellReuseIdentifier:cellID];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(imgV);
        make.top.equalTo(imgV.mas_bottom);
        make.bottom.equalTo(self.view).offset(-blueViewH);
    }];
    //清空分割线
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //底部蓝色视图
    UIView * blueV = [UIView new];
    blueV.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueV];
    [blueV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tv.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(blueViewH));
    }];
}
#pragma mark - tv代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * detailVc = [UIViewController new];
    detailVc.view.backgroundColor = [UIColor randomColor];
    detailVc.navigationItem.title  = [_SideBarFunctionData[indexPath.row] name];
    detailVc.hidesBottomBarWhenPushed = YES;
    UINavigationController * nav = _tabBarVC.selectedViewController;
    [nav pushViewController:detailVc animated:NO];

    [_tabBarVC actionWithTapGesture:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - tv数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return KFunctionCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQSideBarFunctionCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    QQFunctionModel * function = _SideBarFunctionData[indexPath.row];
    cell.sideBarFunction = function;
    return cell;
}
#pragma mark - 加载数据
- (void)loadSideBarFunctionDataWithPlistName:(NSString *)plistName
{
    _SideBarFunctionData = [NSArray objectListWithPlistName:plistName clsName:@"QQFunctionModel"];
}

@end
