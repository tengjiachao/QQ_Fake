//
//  QQSettingSecurityController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQSettingSecurityController.h"
#import "QQUserAccountTools.h"

@interface QQSettingSecurityController ()

@end

@implementation QQSettingSecurityController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self loadDataWithPlistName:@"QQSettingSecurityFunction"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"退出账号"])
    {
        [QQUserAccountTools sharedUserAccountTools].isLogin = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:switchRootViewControllerNotification object:nil];
    }
    
}

@end
