//
//  AppDelegate.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "AppDelegate.h"
#import "QQUserAccountTools.h"
#import "QQLoginViewController.h"
#import "QQSidebarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self setupRootVc];
    [_window makeKeyAndVisible];
    _window.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchRootVc) name:switchRootViewControllerNotification object:nil];
    return YES;
}
//设置根控制器
- (void)setupRootVc
{
    if (![QQUserAccountTools sharedUserAccountTools].isLogin)
    {
        UIViewController * vc  = [QQLoginViewController new];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController: vc];
        _window.rootViewController = nav;
    }else
    {
        UIViewController * vc  = [QQSidebarController new];
        _window.rootViewController = vc;
    }
}
//切换根控制器
- (void)switchRootVc
{
    if ([QQUserAccountTools sharedUserAccountTools].isLogin == NO)
    {
        UIViewController * vc  = [QQLoginViewController new];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController: vc];
        _window.rootViewController = nav;
    }else
    {
        UIViewController * vc  = [QQSidebarController new];
        _window.rootViewController = vc;
    }
}

@end
