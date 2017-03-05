//  QQFunctionModel.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年  滕佳超. All rights reserved.
//

#import "QQFunctionModel.h"

@implementation QQFunctionModel

+ (instancetype) functionModelWithDict:(NSDictionary *)dict
{
    QQFunctionModel * functionModel = [QQFunctionModel new];
    [functionModel setValuesForKeysWithDictionary:dict];
    return functionModel;
}
@end
