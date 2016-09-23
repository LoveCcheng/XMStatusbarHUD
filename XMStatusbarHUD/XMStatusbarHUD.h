//
//  XMStatusbarHUD.h
//  statusBar
//
//  Created by montnets on 16/9/22.
//  Copyright © 2016年 montnets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMStatusbarHUD : NSObject
/**
 * 显示消息加图片
 *
 *  @param message 消息
 *  @param image   图片
 */
+(void)showMessage:(NSString *)message withImage:(UIImage *)image;

/**
 *  显示普通信息
 *
 *  @param message message
 */
+(void)showMessage:(NSString *)message;
/**
 *  成功显示
 *
 *  @param message message
 */
+(void)showSuccessString:(NSString *)message;
/**
 *  失败显示
 *
 *  @param message message
 */
+(void)showErrorString:(NSString *)message;
/**
 *  加载中显示
 *
 *  @param message message
 */
+(void)showLoadingString:(NSString *)message;

/**
 *  隐藏
 */
+(void)hide;








@end
