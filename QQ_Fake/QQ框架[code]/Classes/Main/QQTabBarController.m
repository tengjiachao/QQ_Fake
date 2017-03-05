//
//  QQTabBarController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQTabBarController.h"

CGFloat slideWidth = 80;
CGFloat slideHeight;
CGRect slideRect;
CGPoint beganPoint;

@interface QQTabBarController ()<UIGestureRecognizerDelegate>
@property(nonatomic,weak)UITapGestureRecognizer * tap;
@property(nonatomic,strong)UIPanGestureRecognizer * pan;
///messageVC的聊天列表
@property(nonatomic,strong)UITableView * messageTableV;
@end


@implementation QQTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUIVcs];
    [self addPanGesture];
}

#pragma mark - 添加子控制器
- (void) setupUIVcs
{
    UIViewController * vc1 = [self navWithClassName:@"QQMassageController" andTitle:@"消息" andImageName:@"tab_recent_nor"];
    UIViewController * vc2 = [self navWithClassName:@"QQContactController" andTitle:@"联系人" andImageName:@"tab_buddy_nor"];
    UIViewController * vc3 = [self navWithClassName:@"QQQzoneController" andTitle:@"动态" andImageName:@"tab_qworld_nor"];
    UIViewController * vc4 = [self navWithClassName:@"QQSettingController" andTitle:@"设置" andImageName:@"tab_me_nor"];
    self.viewControllers = @[vc1,vc2,vc3,vc4];
    
    slideHeight = [UIScreen mainScreen].bounds.size.height;
    slideRect = CGRectMake(0, 0, slideWidth, slideHeight);
    
    if([self.selectedViewController.childViewControllers[0].view isKindOfClass:[UITableView class]])
    {
        _messageTableV = (UITableView *)self.selectedViewController.childViewControllers[0].view;
    }
}

#pragma mark - 负责创建vc
- (UIViewController *) navWithClassName:(NSString *)clsName andTitle:(NSString *)title andImageName:(NSString *)imageName
{
    UIViewController * vc = [[NSClassFromString(clsName) alloc] init];
    NSAssert([vc isKindOfClass:[UIViewController class]], @"%@控制器类型写错了",clsName);
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    return nav;
}

#pragma mark - 设置拖拽手势
- (void)addPanGesture
{
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionWithPanGesture:)];
    _pan.delegate = self;
    [self.view addGestureRecognizer:_pan];
}
#pragma mark - 拖拽手势响应事件
- (void)actionWithPanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    //rootViewController是第1个
    if (self.selectedViewController.childViewControllers.count > 1)
    {
        return;
    }
    CGPoint offset = [gestureRecognizer translationInView:self.view];
    [gestureRecognizer setTranslation:CGPointZero inView:self.view];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        beganPoint = [gestureRecognizer locationInView:self.view];
    }
    //只在左边区域生效
    if (!CGRectContainsPoint(slideRect, beganPoint))
    {
        return;
    }
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            //防止tabBar移动到屏幕左侧
            if (offset.x + self.view.frame.origin.x < 0)
            {
                return;
            }
            self.view.transform = CGAffineTransformTranslate(self.view.transform, offset.x, 0);
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            //超过屏幕一半，到右边定位
            if (self.view.frame.origin.x > [UIScreen mainScreen].bounds.size.width/2)
            {
                [UIView animateWithDuration:.5 animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation( [UIScreen mainScreen].bounds.size.width-69, 0);
                }completion:^(BOOL finished) {
                    [self addTapGesture];
                }];
                break;
            }
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            //没超过屏幕一半，恢复形变
            [UIView animateWithDuration:.5 animations:^{
                self.view.transform = CGAffineTransformIdentity;
            }completion:^(BOOL finished) {
                [self removeTapGesture];
                _messageTableV.scrollEnabled = YES;
            }];
        }
            break;
            
        default:
            break;
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //侧滑完成之后不支持多手势,不支持再去滑动聊天列表
    if (!CGAffineTransformIsIdentity(self.view.transform))
    {
        _messageTableV.scrollEnabled = NO;
        return NO;
    }
    return YES;
}

#pragma mark - 设置点按手势
- (void)addTapGesture
{
    //判断点按手势是否重复添加
    if (_tap != nil)
    {
        return;
    }
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionWithTapGesture:)];
    _tap = tap;
    [self.view addGestureRecognizer:tap];
}
#pragma  mark - 点按手势响应事件
- (void)actionWithTapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    [UIView animateWithDuration:.5 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeTapGesture];
        _messageTableV.scrollEnabled = YES;
    }];
}

#pragma mark - 移除点按手势方法
- (void)removeTapGesture
{
    [self.view removeGestureRecognizer:_tap];
}
@end
