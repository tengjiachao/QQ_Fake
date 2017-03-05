//
//  QQSelectFunctionController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQSelectFunctionController.h"
#import "QQFunctionModel.h"
#import "QQDetailCell.h"


//默认样式cell
static NSString * defaultID = @"DEFAULT_ID";
//detail样式cell
static NSString * detailID = @"DETAIL_ID";

@interface QQSelectFunctionController ()

@end

@implementation QQSelectFunctionController
{
    //保存界面数据
    NSArray * _interfaceFunctionData;
}


#pragma mark - 搭建界面
- (void)setupUI
{
    UITableView * tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView = tv;
    [self.view addSubview:tv];
    tv.dataSource = self;
    tv.delegate = self;
    //cell-默认样式
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:defaultID];
    //cell-detail样式
    [tv registerClass:[QQDetailCell class] forCellReuseIdentifier:detailID];
    //设置边框紧贴屏幕
    tv.separatorInset = UIEdgeInsetsZero;
    tv.layoutMargins = UIEdgeInsetsZero;
    //设置tableView为view
    self.view = _tableView;
    
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _interfaceFunctionData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_interfaceFunctionData[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQFunctionModel * model = _interfaceFunctionData[indexPath.section][indexPath.row];
    //判断样式
    NSString * cellID = model.detail.length > 0 ? detailID : defaultID;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = model.name;

    //有图片才设置图片数据
    if (model.icon.length > 0)
    {
        cell.imageView.image = [UIImage imageNamed:model.icon];
    }
    //有detail才设置数据
    if (model.detail.length > 0)
    {
        cell.detailTextLabel.text = model.detail;
    }
    return cell;
}
#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQFunctionModel * model = _interfaceFunctionData[indexPath.section][indexPath.row];
    _selModle = model;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
//设置分割线紧贴屏幕
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
}
#pragma mark - 加载数据
- (void)loadDataWithPlistName:(NSString *)plistName
{
    NSArray * plistDataArr = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:plistName withExtension:@"plist"]];
    NSMutableArray * bigMarr = [NSMutableArray array];
    for (NSArray * arr in plistDataArr)
    {
        NSMutableArray * smallMarr = [NSMutableArray array];
        for (NSDictionary * dict in arr)
        {
            QQFunctionModel * model = [QQFunctionModel new];
            [model setValuesForKeysWithDictionary:dict];
            [smallMarr addObject:model];
        }
        [bigMarr addObject:smallMarr];
    }
    _interfaceFunctionData = bigMarr.copy;
}

@end
