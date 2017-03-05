//
//  QQSideBarFunctionCell.h
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQFunctionModel;
@interface QQSideBarFunctionCell : UITableViewCell
///绑定数据模型
@property(nonatomic,strong)QQFunctionModel * sideBarFunction;
@end
