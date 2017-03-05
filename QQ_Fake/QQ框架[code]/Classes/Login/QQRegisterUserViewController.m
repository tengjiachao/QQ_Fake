//
//  QQRegisterUserViewController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQRegisterUserViewController.h"
#import "UIButton+Addition.h"
#import "Masonry.h"

@interface QQRegisterUserViewController ()

@property(nonatomic,strong)UITextField * nameText;
@property(nonatomic,strong)UITextField * passwordText;
@property(nonatomic,strong)UIButton * registerButton;
@property(nonatomic,strong)UIButton * agreementButton;
@property(nonatomic,strong)UIButton * strategyButton;

@end

@implementation QQRegisterUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    self.title = @"注册新用户";

}

#pragma mark - 搭建界面
- (void)setupUI
{
    _nameText = [UITextField new];
    _nameText.placeholder = @"用户名";
    _nameText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordText = [UITextField new];
    _passwordText.placeholder = @"用户密码";
    _passwordText.borderStyle = UITextBorderStyleRoundedRect;
    _registerButton = [UIButton buttonText:@"注册" fontSize:14 fontColor:[UIColor whiteColor] backgroundImgName:@"login_btn_blue_nor" target:self action:@selector(regisgerUser)];
    _agreementButton = [UIButton buttonText:@"我已阅读并同意" fontSize:13 normalColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1] target:self action:@selector(agreementButtonClick)];
    [_agreementButton setTitleShadowColor:[UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1] forState:UIControlStateNormal];
    _strategyButton = [UIButton buttonText:@"使用条款和隐私策略" fontSize:13 normalColor:[UIColor colorWithRed:19/255.0 green:154/255.0 blue:232/255.0 alpha:1] target:self action:@selector(strategyButtonClick)];

    [self.view addSubview:_nameText];
    [self.view addSubview:_passwordText];
    [self.view addSubview:_registerButton];
    [self.view addSubview:_agreementButton];
    [self.view addSubview:_strategyButton];

    [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20+44+30);
        make.left.offset(16);
        make.right.offset(-16);
    }];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameText.mas_bottom).offset(8);
        make.left.right.equalTo(_nameText);
    }];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordText.mas_bottom).offset(8);
        make.height.equalTo(@30);
        make.left.right.equalTo(_nameText);
    }];

    [_agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_registerButton.mas_bottom).offset(8);
        make.left.offset(16);
    }];
    [_strategyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_agreementButton.mas_top);
        make.right.offset(-16);
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)regisgerUser
{
    
}

- (void)agreementButtonClick
{
    
}

- (void)strategyButtonClick
{
    
}

@end
