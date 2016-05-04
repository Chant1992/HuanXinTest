//
//  ConverseViewController.m
//  testhuanxin
//
//  Created by gyh on 16/4/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ConverseViewController.h"

@interface ConverseViewController ()<EMClientDelegate,EMContactManagerDelegate,UIAlertViewDelegate>

/** 好友的名称 */
@property (nonatomic, copy) NSString *buddyUsername;

@end

@implementation ConverseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //登录接口相关的代理
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    //联系人模块代理
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}

#pragma mark - 监听网络状态
- (void)didConnectionStateChanged:(EMConnectionState)connectionState{

    if (connectionState == EMConnectionDisconnected) {
        self.title = @"未连接..";
    }else{
        self.title = @"会话";
    }
}


#pragma mark - 好友请求回调
/*!
 *  用户A发送加用户B为好友的申请，用户B会收到这个回调
 *
 *  @param aUsername   用户名
 *  @param aMessage    附属信息
 */
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage
{
    NSLog(@"%@,%@",aUsername,aMessage);
    self.buddyUsername = aUsername;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好友添加请求" message:aMessage delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"同意", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        //同意好友请求
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:self.buddyUsername];
        if (!error) {
            NSLog(@"同意加好友成功");
        }else{
             NSLog(@"同意加好友失败");
        }
    }else{
        //拒绝好友请求
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:self.buddyUsername];
        if (!error) {
            NSLog(@"拒绝加好友成功");
        }else{
            NSLog(@"拒绝加好友失败");
        }
    }
}

#pragma mark - 好友申请处理结果回调
/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername
{
    NSLog(@"%@",aUsername);
    NSString *message = [NSString stringWithFormat:@"%@ 同意了你的好友请求",aUsername];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好友添加消息" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername
{
    NSLog(@"%@",aUsername);
    NSString *message = [NSString stringWithFormat:@"%@ 拒绝了你的好友请求",aUsername];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好友添加消息" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}





- (void)dealloc
{
    [[EMClient sharedClient] removeDelegate:self];
    [[EMClient sharedClient].contactManager removeDelegate:self];
}

@end
