//
//  TabbarButton.m
//
//
//  Created by gyh on 15/9/21.
//  Copyright © 2015年 apple. All rights reserved.
//

// 定义图片占据得尺寸
#define tabbarButtonRatio 0.6
//默认文字得颜色，
#define tabbarButtonTitleColor [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1]
//按钮选中文字得颜色
#define tabbarButtonTitleSelectedColor [UIColor colorWithRed:153/255.0f green:215/255.0f blue:121/255.0f alpha:1]

#import "TabbarButton.h"
#import "BadgeButton.h"

@interface TabbarButton()
@property (nonatomic , weak) BadgeButton *badgeButton;
@end

@implementation TabbarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置图片 文字居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:tabbarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:tabbarButtonTitleSelectedColor forState:UIControlStateSelected];
        
        //设置一个提醒数字
        BadgeButton *badgeButton = [[BadgeButton alloc]init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

// 设置图片和文字在按钮中得位置。
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imagew = contentRect.size.width;
    CGFloat imageH = contentRect.size.height *tabbarButtonRatio;
    return CGRectMake(0, 0, imagew, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height *tabbarButtonRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}


//-(void)setItem:(UITabBarItem *)item
//{
//    _item = item;
//    [self setTitle:item.title forState:UIControlStateNormal];
//    [self setImage:item.image forState:UIControlStateNormal];
//    [self setImage:item.selectedImage forState:UIControlStateSelected];
//}

-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    //kvo监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

-(void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    self.badgeButton.badgeValue = self.item.badgeValue;
    CGFloat badgey = 4;
    CGFloat badgex = self.frame.size.width - self.badgeButton.frame.size.width -30;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgex;
    badgeF.origin.y = badgey;
    self.badgeButton.frame = badgeF;
}



@end
