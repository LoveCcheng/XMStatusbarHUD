//
//  XMStatusbarHUD.m
//  statusBar
//
//  Created by montnets on 16/9/22.
//  Copyright © 2016年 montnets. All rights reserved.
//

#import "XMStatusbarHUD.h"


static CGFloat const XMAnimationTime=0.25;

@implementation XMStatusbarHUD
/** 全局的窗口 */
static UIWindow *window_;
/** 创建定时器 */
static NSTimer *timer_;

+(void)showWindow{
    CGFloat windowH=20;
    CGRect frame=CGRectMake(0, -windowH, [UIScreen mainScreen].bounds.size.width,windowH);
    //隐藏上一个窗口
    window_.hidden=YES;
    //显示窗口
    window_=[[UIWindow alloc]init];
    window_.backgroundColor=[UIColor blackColor];
    window_.windowLevel=UIWindowLevelAlert;
    window_.frame=frame;
    window_.hidden=NO;
    
    frame.origin.y=0;
    [UIView animateWithDuration:XMAnimationTime animations:^{
        window_.frame=frame;
    }];
    
}
/**
 * 显示消息加图片
 *
 *  @param message 消息
 *  @param image   图片
 */
+(void)showMessage:(NSString *)message withImage:(UIImage *)image{
    //停止定时器，防止点击多个按钮的效果出错
    [timer_ invalidate];
    
    
    [self showWindow];
    //添加按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.textColor=[UIColor redColor];
    [button setTitle:message forState:UIControlStateNormal];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
    }
    button.titleLabel.font=[UIFont systemFontOfSize:13];
    button.frame=window_.bounds;
    [window_ addSubview:button];
    
    timer_=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hide) userInfo:nil repeats:NO];
}
/**
 *  显示普通信息
 *
 *  @param message message
 */
+(void)showMessage:(NSString *)message{
    [self showMessage:message withImage:nil];
}
/**
 *  成功显示
 *
 *  @param message message
 */
+(void)showSuccessString:(NSString *)message{
    [self showMessage:message withImage:[UIImage imageNamed:@"XMStatusbarHUD.bundle/success"]];
}
/**
 *  失败显示
 *
 *  @param message message
 */
+(void)showErrorString:(NSString *)message{
    [self showMessage:message withImage:[UIImage imageNamed:@"XMStatusbarHUD.bundle/error"]];

}
/**
 *  加载中显示
 *
 *  @param message message
 */
+(void)showLoadingString:(NSString *)message{
    //停止定时器
    [timer_ invalidate];
    //销毁定时器
    timer_=nil;
    
    
    //显示窗口
    [self showWindow];
    //添加文字
    UILabel *lab=[[UILabel alloc]init];
    lab.font=[UIFont systemFontOfSize:13];
    lab.textColor=[UIColor whiteColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.text=message;
    lab.frame=window_.bounds;
    [window_ addSubview:lab];
    
    
    //添加圈圈
    UIActivityIndicatorView *loadingView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView  startAnimating];
    
    //文字宽度
    CGFloat messageW=[message sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width;
    
    CGFloat cenetrX=(window_.bounds.size.width-messageW)*0.5-20;
    CGFloat centerY=window_.bounds.size.height*0.5;
    loadingView.center=CGPointMake(cenetrX, centerY);
    [window_ addSubview:loadingView];
    
}

/**
 *  隐藏
 */
+(void)hide{
    [UIView animateWithDuration:XMAnimationTime animations:^{
        CGRect frame=window_.frame;
        frame.origin.y=-frame.size.height;
        window_.frame=frame;
    } completion:^(BOOL finished) {
        window_=nil;
        //销毁定时器
        timer_=nil;
    }];
}















@end
