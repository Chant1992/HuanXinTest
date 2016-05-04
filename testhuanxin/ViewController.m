//
//  ViewController.m
//  testhuanxin
//
//  Created by gyh on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "EMSDK.h"
#import "GYHTabBarController.h"


@interface ViewController ()
@property (nonatomic , weak) UITextField *usernamefield;
@property (nonatomic , weak) UITextField *passwordfield;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *usernamefield = [[UITextField alloc]init];
    usernamefield.frame = CGRectMake(20, 150, SCREEN_WIDTH-40, 30);
    usernamefield.placeholder = @"请输入用户名";
    [self.view addSubview:usernamefield];
    [usernamefield.layer setBorderWidth:1];
    [usernamefield.layer setBorderColor:[UIColor grayColor].CGColor];
    [usernamefield.layer setCornerRadius:15];
    usernamefield.clipsToBounds = YES;
    usernamefield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 0)];
    usernamefield.leftViewMode = UITextFieldViewModeAlways;
    self.usernamefield = usernamefield;
    
    UITextField *passwordfield = [[UITextField alloc]init];
    passwordfield.frame = CGRectMake(20, 190, SCREEN_WIDTH-40, 30);
    passwordfield.placeholder = @"请输入密码";
    [self.view addSubview:passwordfield];
    [passwordfield.layer setBorderWidth:1];
    [passwordfield.layer setBorderColor:[UIColor grayColor].CGColor];
    [passwordfield.layer setCornerRadius:15];
    passwordfield.clipsToBounds = YES;
    passwordfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 0)];
    passwordfield.leftViewMode = UITextFieldViewModeAlways;
    passwordfield.secureTextEntry = YES;
    self.passwordfield = passwordfield;
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(10, 230, SCREEN_WIDTH-20, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(registe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *loginbtn = [[UIButton alloc]init];
    loginbtn.frame = CGRectMake(10, 270, SCREEN_WIDTH-20, 30);
    loginbtn.backgroundColor = [UIColor redColor];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
}


- (void)registe
{
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.usernamefield.text password:self.passwordfield.text];
    if (error==nil) {
        NSLog(@"注册成功");
        [MBProgressHUD showSuccess:@"注册成功"];
    }else{
        NSLog(@"注册失败,%@",error.errorDescription);
        [MBProgressHUD showError:[NSString stringWithFormat:@"注册失败,%@",error.errorDescription]];
    }
}


- (void)login
{
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.usernamefield.text password:self.passwordfield.text];
    if (error==nil) {
        NSLog(@"登录成功");
        [MBProgressHUD showSuccess:@"登录成功"];
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        
        self.view.window.rootViewController = [[GYHTabBarController alloc]init];
        
    }else{
        NSLog(@"登录失败,%@",error.errorDescription);
        [MBProgressHUD showError:[NSString stringWithFormat:@"登录失败,%@",error.errorDescription]];
    }
}


@end
