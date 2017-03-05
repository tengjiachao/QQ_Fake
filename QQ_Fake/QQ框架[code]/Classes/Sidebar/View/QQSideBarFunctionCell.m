//
//  QQSideBarFunctionCell.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQSideBarFunctionCell.h"
#import "QQFunctionModel.h"
#import "UIColor+Addition.h"

@implementation QQSideBarFunctionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        UIView * sideBarColorView = [UIView new];
        sideBarColorView.backgroundColor = [UIColor colorWithHex:0x29BEF6];
        self.selectedBackgroundView  = sideBarColorView;
    }
    return self;
}
- (void)setSideBarFunction:(QQFunctionModel *)sideBarFunction
{
    self.imageView.image = [UIImage imageNamed:sideBarFunction.icon];
    self.textLabel.text = sideBarFunction.name;
}
@end
