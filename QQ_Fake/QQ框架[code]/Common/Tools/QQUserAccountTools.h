//
//  QQUserAccountTools.h
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * switchRootViewControllerNotification = @"switchRootViewControllerNotification";

@interface QQUserAccountTools : NSObject
@property(nonatomic,assign)BOOL isLogin;

+ (instancetype)sharedUserAccountTools;
@end
