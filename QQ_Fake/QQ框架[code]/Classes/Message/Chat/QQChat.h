//
//  QQChat.h
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    QQChatTypeOther,
    QQChatTypeMe
} QQChatType;

@interface QQChat : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) QQChatType type;

@end
