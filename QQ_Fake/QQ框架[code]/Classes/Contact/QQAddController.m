//
//  QQAddController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQAddController.h"
#import "QQSelectFunctionController.h"


@interface QQAddController ()

@end

@implementation QQAddController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //加载界面图标
    [self loadDataWithPlistName:@"QQAddFunction"];
    
}
#pragma mark - 搭建界面
- (void)setupUI
{
    [super setupUI];
    self.navigationItem.title = @"添加";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController * detailVc = [UIViewController new];
    detailVc.view.backgroundColor = [UIColor randomColor];
    detailVc.navigationItem.title  = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    detailVc.hidesBottomBarWhenPushed = YES;
    UINavigationController * nav = self.tabBarController.selectedViewController;
    [nav pushViewController:detailVc animated:YES];
}


@end
