//
//  SettingViewController.m
//  testhuanxin
//
//  Created by gyh on 16/4/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SettingViewController.h"
#import "ViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [EMError *error = [[EMClient sharedClient] logout:YES];
//     if (!error) {
//         NSLog(@"退出成功");
//     }];
    NSString *str = [[EMClient sharedClient] currentUsername];
    NSLog(@"---%@",str);
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH-60, 30)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:str forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
}

- (void)logout
{
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
       [MBProgressHUD showSuccess:@"注销成功"];
        self.view.window.rootViewController = [[ViewController alloc]init];
    }
}




@end
