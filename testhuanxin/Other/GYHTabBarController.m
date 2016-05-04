//
//  GYHTabBarController.m
//  testhuanxin
//
//  Created by gyh on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GYHTabBarController.h"
#import "TabbarView.h"
#import "TabbarButton.h"
#import "GYHNavigationController.h"

#import "ConverseViewController.h"
#import "FriendsViewController.h"
#import "SettingViewController.h"


@interface GYHTabBarController ()<TabbarViewDelegate>
@property (nonatomic , strong) TabbarView *tabbar;
@end

@implementation GYHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTabbar];
    
    [self initControl];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)initTabbar
{
    TabbarView *tabBar = [[TabbarView alloc]init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
    self.tabbar = tabBar;
}

- (void)tabbar:(TabbarView *)tabbar didselectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

- (void)initControl
{
    ConverseViewController *main = [[ConverseViewController alloc]init];
    [self setupChildViewController:main title:@"会话" imageName:@"底操景点" selectedImage:@"底操景点选中"];
    FriendsViewController *search = [[FriendsViewController alloc]init];
    [self setupChildViewController:search title:@"联系人" imageName:@"导游" selectedImage:@"导游选中"];
    SettingViewController *guide = [[SettingViewController alloc]init];
    [self setupChildViewController:guide title:@"我" imageName:@"我的" selectedImage:@"我选中"];
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage
{
    childVc.view.backgroundColor = [UIColor whiteColor];
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //封装一个导航控制器
    GYHNavigationController *nav = [[GYHNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    [self.tabbar addTabBarButtonWithItem:childVc.tabBarItem];
}



@end
