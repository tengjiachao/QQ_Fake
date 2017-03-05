//
//  QQLoginViewController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQLoginViewController.h"
#import "QQRegisterUserViewController.h"
#import "UIButton+Addition.h"
#import "UIImageView+Addition.h"
#import "Masonry.h"
#import "QQUserAccountTools.h"

@interface QQLoginViewController ()

@property(nonatomic,strong)UIImageView * portraitImageView;
@property(nonatomic,strong)UITextField *nameText;
@property(nonatomic,strong)UITextField *passwordText;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UIButton * forgotPwdButton;
@property(nonatomic,strong)UIButton * registerButton;

@end


@implementation QQLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.jpg"]];
    [self setupUI];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark - 搭建界面
- (void)setupUI
{
    _portraitImageView = [UIImageView imageName:@"login_avatar_default"];
    _nameText = [UITextField new];
    _nameText.placeholder = @"请输入用户名";
    _nameText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordText = [UITextField new];
    _passwordText.placeholder = @"输入密码";
    _passwordText.borderStyle = UITextBorderStyleRoundedRect;
    _loginButton = [UIButton buttonText:@"登录" fontSize:14 fontColor:[UIColor whiteColor] backgroundImgName:@"login_btn_blue_nor" target:self action:@selector(login)];
    _forgotPwdButton = [UIButton buttonText:@"无法登录？" fontSize:15 normalColor:[UIColor colorWithRed:19/255.0 green:154/255.0 blue:232/255.0 alpha:1] target:self action:@selector(forgotPassword)];
    _registerButton = [UIButton buttonText:@"新用户" fontSize:15 normalColor:[UIColor colorWithRed:19/255.0 green:154/255.0 blue:232/255.0 alpha:1] target:self action:@selector(registerAcount)];
   
    [self.view addSubview:_portraitImageView];
    [self.view addSubview:_nameText];
    [self.view addSubview:_passwordText];
    [self.view addSubview:_loginButton];
    [self.view addSubview:_forgotPwdButton];
    [self.view addSubview:_registerButton];

    [_portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.centerX.equalTo(self.view);
    }];
    [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_portraitImageView.mas_bottom).offset(28);
        make.left.offset(16);
        make.right.offset(-16);
    }];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameText.mas_bottom).offset(8);
        make.left.right.equalTo(_nameText);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordText.mas_bottom).offset(8);
        make.height.equalTo(@30);
        make.left.right.equalTo(_nameText);
    }];
    [_forgotPwdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.bottom.offset(-20);
    }];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.bottom.offset(-20);
    }];
    
}

// 用户登录
- (void)login
{
    [QQUserAccountTools sharedUserAccountTools].isLogin = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:switchRootViewControllerNotification object:nil];
}
                        
- (void)forgotPassword
{
    
}

- (void)registerAcount
{
    QQRegisterUserViewController * registerVC = [QQRegisterUserViewController new];
    [self.navigationController showViewController:registerVC sender:nil];
}

@end
