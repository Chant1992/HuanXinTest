//
//  AppDelegate.m
//  testhuanxin
//
//  Created by gyh on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "EMSDK.h"


#import "LoginViewController.h"
#import "ChatViewController.h"
#import "ConverseViewController.h"
#import "SettingViewController.h"

#import "GYHTabBarController.h"

@interface AppDelegate ()<EMChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    EMOptions *options = [EMOptions optionsWithAppkey:@"gaoyuhang#daydaynews"];
    options.apnsCertName = @"gaoyuhangDevelop";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    // 监听自动登录的状态
    // 设置chatManager代理
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
    // 如果登录过，直接来到主界面
    if ([[EMClient sharedClient] isAutoLogin]) {

        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        GYHTabBarController *tabbarVC = [[GYHTabBarController alloc]init];
        self.window.rootViewController = tabbarVC;
        [self.window makeKeyAndVisible];
    }


    
    return YES;
}







// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// App将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}



@end
