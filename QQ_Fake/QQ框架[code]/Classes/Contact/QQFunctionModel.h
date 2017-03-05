//  QQFunctionModel.h
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQFunctionModel : NSObject
///标题
@property(nonatomic,copy)NSString * name;
///图标
@property(nonatomic,copy)NSString * icon;
//子标题
@property(nonatomic,copy)NSString * detail;
///跳转界面对应的目标控制器的类名
@property(nonatomic,copy)NSString * targetVc;

///快速创建模型
+ (instancetype) functionModelWithDict:(NSDictionary *)dict;
@end
