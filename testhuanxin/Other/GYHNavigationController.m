//
//  NavgationController.m
//
//  Created by gyh on 15/11/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GYHNavigationController.h"
#import "UIBarButtonItem+gyh.h"


@interface GYHNavigationController ()

@end

@implementation GYHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:153/255.0f green:215/255.0f blue:121/255.0f alpha:1]];
    
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

#pragma mark  拦截push，一旦进入下个视图，隐藏tabbar，自定义返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithIcon:@"返回按钮" highIcon:@"返回按钮" target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
