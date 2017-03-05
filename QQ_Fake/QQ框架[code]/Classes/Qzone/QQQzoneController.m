//
//  QQQzoneController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQQzoneController.h"
#import "QQFunctionModel.h"

@interface QQQzoneController ()

@end

@implementation QQQzoneController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDataWithPlistName:@"QQQzoneFunction"];
    
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
