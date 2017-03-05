//
//  QQChatController.m
//  QQ框架
//
//  Created by thomasTY on 14/12/1.
//  Copyright © 2014年 滕佳超. All rights reserved.
//

#import "QQChatController.h"
#import "QQChat.h"
#import "QQChatMeCell.h"
#import "QQChatOtherCell.h"
#import "NSArray+Addition.h"
#import "Masonry.h"

static NSString *chatMeCellID = @"chatMe_cell";
static NSString *chatOtherCellID = @"chatOther_cell";
static CGFloat offsetY;

@interface QQChatController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray * chatData;
@property(nonatomic,strong)NSDictionary * autoreply;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSString * lastTime;
@property(nonatomic,strong)UITextField * textFiled;
@property(nonatomic,strong)UIVisualEffectView * barView;
@property(nonatomic,strong)UIButton * sendButton;
@property(nonatomic,strong)UITextField * messageTextField;

@end

@implementation QQChatController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.chatData = [self loadChatData];
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
    [tableView registerClass:[QQChatMeCell class] forCellReuseIdentifier:chatMeCellID];
    
    [tableView registerClass:[QQChatOtherCell class] forCellReuseIdentifier:chatOtherCellID];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    _barView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.view addSubview:_barView];
    
    
    _messageTextField = [[UITextField alloc] init];
    _messageTextField.borderStyle = UITextBorderStyleRoundedRect;
    [_barView.contentView addSubview:_messageTextField];
    _messageTextField.delegate = self;
    _messageTextField.returnKeyType = UIReturnKeySend;
    _messageTextField.enablesReturnKeyAutomatically = YES;
    
    _textFiled = _messageTextField;
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _sendButton.enabled = NO;
    
    [_barView.contentView addSubview:_sendButton];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
    
    [_messageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_barView.contentView);
        make.left.offset(8);
    }];
    
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_messageTextField.mas_right).offset(8);
        make.centerY.equalTo(_barView.contentView);
        make.right.offset(-8);
        make.width.equalTo(@(50));
        
    }];
    
    [_barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.offset(44);
    }];
    
    
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:nil];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    
    [self.tableView addGestureRecognizer:tap];
    
}
- (void)keyboardHide
{
    [_textFiled resignFirstResponder];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
}
- (void)textChanged
{
    _sendButton.enabled = self.messageTextField.text.length > 0 ? YES : NO;
}

- (void)sendBtnClick
{
    [self textFieldShouldReturn:self.textFiled];
}
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    offsetY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    [_barView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(offsetY);
    }];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, keyboardFrame.size.height+44, 0));
    }];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.chatData.count - 1) inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];
    
}

// 传入消息内容和消息类型,自己发送一条消息
- (void)sendMessageWithText:(NSString *)text messageType:(QQChatType)type {
    // 创建数据模型
    QQChat *chat = [[QQChat alloc] init];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSString *time = [dateFormatter stringFromDate:date];
    chat.time = time;
    chat.type = type;
    chat.text = text;
    
    
    if ([self.lastTime isEqualToString:chat.time])
    {
        chat.time = @"";
    } else {
        self.lastTime = chat.time;
        
    }
    
    [self.chatData addObject:chat];
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.chatData.count - 1) inSection:0];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)loadChatData
{
    NSArray *data = [NSArray objectListWithPlistName:@"messages" clsName:@"QQChat"];
    
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:data];
    
    NSString *tempTime = [data[0] time];
    for (NSInteger i = 1; i < data.count; i++)
    {
        if ([[arrM[i] time] isEqualToString:tempTime])
        {
            [arrM[i] setTime:@""];
        } else {
            tempTime = [arrM[i] time];
        }
    }
    return arrM;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQChat *chat = self.chatData[indexPath.row];
    
    
    if (chat.type == QQChatTypeMe)
    {
        QQChatMeCell *cell = [tableView dequeueReusableCellWithIdentifier:chatMeCellID forIndexPath:indexPath];
        cell.chat = chat;
        return cell;
    } else
    {
        QQChatOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:chatOtherCellID forIndexPath:indexPath];
        cell.chat = chat;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4;
}


#pragma mark - textField的代理方法,当点击键盘上的return键时调用此方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 自己发送一条消息
    [self sendMessageWithText:textField.text messageType:QQChatTypeMe];
    
    // 对方回复一条消息
    NSString *replayText = [self replyWithText:textField.text];
    [self sendMessageWithText:replayText messageType:QQChatTypeOther];
    
    textField.text = nil;
    _sendButton.enabled = self.messageTextField.text.length > 0 ? YES : NO;
    
    return YES;
}


// 传入自己发送的文字来获取自动回复内容
- (NSString *)replyWithText:(NSString *)text
{
    for (int i = 0; i < text.length; ++i)
    {
        NSString *word = [text substringWithRange:NSMakeRange(i, 1)];
        if (self.autoreply[word])
        {
            return self.autoreply[word];
        }
    }
    return @"88";
}

// 加载自动回复数据
- (NSDictionary *)autoreply
{
    if (_autoreply == nil)
    {
        _autoreply = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoreply.plist" ofType:nil]];
    }
    return _autoreply;
}


@end
