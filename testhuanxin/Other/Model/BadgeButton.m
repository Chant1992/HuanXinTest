//
//  BadgeButton.m
//  testhuanxin
//
//  Created by gyh on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BadgeButton.h"
#import "UIImage+Extension.h"

@implementation BadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.hidden = YES;
        self.userInteractionEnabled = NO;   //按钮不可点击
        [self setBackgroundImage:[UIImage resizableImage:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        
        if ([badgeValue isEqualToString:@"0"]) {
            self.hidden = YES;
            return;
        }
        
        self.hidden = NO;
        //设置文字
        [self setTitle: badgeValue forState:UIControlStateNormal];
        
        //设置frame
        CGRect frame = self.frame;
        
        CGFloat badgeh =  self.currentBackgroundImage.size.height;
        CGFloat badgew =  self.currentBackgroundImage.size.width;
        if(badgeValue.length >1)
        {
            CGSize badgeSize = [ badgeValue sizeWithFont:self.titleLabel.font];
            badgew =  badgeSize.width + 10 ;
        }
        
        
        frame.size.width = badgew;
        frame.size.height = badgeh;
        self.frame = frame;
        
    }else{
        self.hidden = YES;
    }
    
    
}


@end
