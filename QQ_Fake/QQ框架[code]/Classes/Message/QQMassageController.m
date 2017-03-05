//
//  QQMassageController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQMassageController.h"
#import "QQMessage.h"
#import "QQChatController.h"
#import "UIColor+Addition.h"


static NSString * cellID = @"cellID";
@interface QQMassageController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)NSMutableArray * messageList;
@end

@implementation QQMassageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self setupUI];
}

#pragma mark - 搭载界面
- (void)setupUI
{
    [super setupUI];
    CGRect frame = self.view.bounds;
    frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(64, 0, 49, 0));
    _tableV = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    self.view = _tableV;
    _tableV.dataSource = self;
    _tableV.delegate = self;
    [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];

    //右上角灯泡按钮
    UIBarButtonItem * bubleItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu_icon_bulb"] style:UIBarButtonItemStylePlain target:self action:@selector(bubleItemClick)];
    self.navigationItem.rightBarButtonItem = bubleItem;
}
- (void)bubleItemClick
{
    UIViewController * detailVc = [UIViewController new];
    detailVc.view.backgroundColor = [UIColor randomColor];
    detailVc.navigationItem.title  = @"提示";
    detailVc.hidesBottomBarWhenPushed = YES;
    UINavigationController * nav = self.tabBarController.selectedViewController;
    [nav pushViewController:detailVc animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    QQMessage * msg = _messageList[indexPath.row];
    cell.textLabel.text = msg.message;
    cell.imageView.image = msg.icon;
    return cell;
}


#pragma mark - 取消cell选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQChatController * cha_tableVC = [QQChatController new];
    cha_tableVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cha_tableVC animated:YES];
    cha_tableVC.title = [NSString stringWithFormat:@"朋友%zd%zd",indexPath.section,indexPath.row+1];
    ;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath){
        
        [_messageList removeObjectAtIndex:indexPath.row];
        [_tableV deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    deleteAction.backgroundColor = [UIColor orangeColor];
    
    UITableViewRowAction *didRead = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"标记已读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"标记已读");
    }];
    didRead.backgroundColor = [UIColor grayColor];
    return @[deleteAction, didRead];
}

#pragma mark - 加载数据
- (void)loadData
{
    UIImage *img = [UIImage imageNamed:@"other"];
    _messageList = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i++)
    {
        QQMessage * msg = [QQMessage new];
        msg.icon = img;
        msg.message = [NSString stringWithFormat:@"看到请回复我消息！%zd",i+1];
        [_messageList addObject:msg];
    }
    
}


@end
