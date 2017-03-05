//
//  QQAboutController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQAboutController.h"
#import "Masonry.h"


@implementation QQAboutController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDataWithPlistName:@"QQAboutFunction"];
}


#pragma mark - 搭建界面
- (void)setupUI
{
    [super setupUI];
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 160)];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
    UIImageView * headerImageView = [[UIImageView  alloc] initWithImage:[UIImage imageNamed:@"setting_about_pic" ]];
    [headerView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(headerView).offset(10);
    }];
    
    UILabel * headerLabel = [UILabel new];
    headerLabel.text = @"v 1.12345";
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImageView.mas_bottom).offset(5);
        make.centerX.equalTo(headerView);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    UIViewController * detailVc = [UIViewController new];
    detailVc.view.backgroundColor = [UIColor randomColor];
    detailVc.navigationItem.title  = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    detailVc.hidesBottomBarWhenPushed = YES;
    UINavigationController * nav = self.tabBarController.selectedViewController;
    [nav pushViewController:detailVc animated:YES];
}
@end
