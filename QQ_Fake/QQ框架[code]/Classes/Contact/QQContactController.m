//
//  QQContactController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQContactController.h"
#import "QQAddController.h"

static NSString * cellID = @"cellID";
static NSInteger rowNum = 10;
@interface QQContactController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)UITableView * tableView;
@property(nonatomic,weak)UISegmentedControl * segmentCotrol;
@end

@implementation QQContactController

#pragma mark - 搭载界面
- (void)setupUI
{
    UITableView * tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView = tv;
    [self.view addSubview:tv];
    tv.dataSource = self;
    tv.delegate = self;
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:@[@"分组",@"全部",@"收藏"]];
    _segmentCotrol = segment;
    //设置默认选中
    [segment setSelectedSegmentIndex:0];
    //设定宽度
    for (NSInteger i = 0; i < segment.numberOfSegments; i++)
    {
        [segment setWidth:80 forSegmentAtIndex:i];
    }
    [segment addTarget:self action:@selector(segmentControlClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    //navBar的添加联系人
    UIBarButtonItem * addContact =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_icon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(go2AddVc)];
    self.navigationItem.rightBarButtonItem = addContact;
    
}
// MARK:点击分段空间时调用
- (void)segmentControlClick:(UISegmentedControl *)segment
{
    [_tableView reloadData];
}
// MARK:跳转到添加联系人界面
 - (void)go2AddVc
{
    QQAddController * addController = [[QQAddController alloc] init];
    addController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addController animated:YES];
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (_segmentCotrol.selectedSegmentIndex+1) + rowNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).description;
    return cell;
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

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath){
        
        rowNum -= 1;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    deleteAction.backgroundColor = [UIColor orangeColor];
    
    UITableViewRowAction *collection = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"收藏");
    }];
    collection.backgroundColor = [UIColor grayColor];
    return @[deleteAction, collection];
}

@end
