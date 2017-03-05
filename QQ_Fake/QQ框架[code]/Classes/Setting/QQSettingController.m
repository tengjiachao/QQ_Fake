//
//  QQSettingController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQSettingController.h"
#import "UIColor+Addition.h"
#import "QQSettingSecurityController.h"

@interface QQSettingController ()

@end

@implementation QQSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDataWithPlistName:@"QQSettingFunction"];
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    //判断模型中是否需要跳转
    NSString * className = self.selModle.targetVc;
    if (className.length == 0)
    {
        UIViewController * detailVc = [UIViewController new];
        detailVc.view.backgroundColor = [UIColor randomColor];
        //退出账户VC
        if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"安全与隐私"])
        {
            detailVc = [QQSettingSecurityController new];
        }
        detailVc.navigationItem.title  = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        detailVc.hidesBottomBarWhenPushed = YES;
        UINavigationController * nav = self.tabBarController.selectedViewController;
        [nav pushViewController:detailVc animated:YES];

        return;
    }
    Class cls = NSClassFromString(className);
    UIViewController * vc = [cls new];
    vc.hidesBottomBarWhenPushed =YES;
    vc.navigationItem.title = @"关于";
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
