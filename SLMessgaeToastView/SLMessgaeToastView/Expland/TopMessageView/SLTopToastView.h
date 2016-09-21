//
//  SLTopMessageToastView.h
//  SLMessgaeToastView
//
//  Created by liangbai on 16/9/2.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLTopToastView : UIView

//默认是 0.15s
@property (nonatomic, assign) NSTimeInterval fadeInAnimationDuration;

//默认是 0.15s
@property (nonatomic, assign) NSTimeInterval fadeOutAnimationDuration;

//默认是 UIWindowLevelNormal
@property (nonatomic, assign) UIWindowLevel maxSupportedWindowLevel;

//显示的最短的时间  默认是4s
@property (assign, nonatomic) NSTimeInterval minimumDismissTimeInterval;

//字体的大小
@property (nonatomic, assign, nullable) UIFont *font;

//字体颜色
@property (nullable, nonatomic, strong) UIColor *textColor;

//背景色
@property (nullable, nonatomic, copy) UIColor *backgroundColorOfTTView;

//高度设置  默认是 40
@property (nonatomic, assign) CGFloat heightOfTTView;

/**
 *  设置弹出信息字体的大小
 *
 *  @param font 默认是20
 */
+ (void)setFontOfTTView:(UIFont * _Nullable)font;

/**
 *  设置弹出信息字体颜色
 *
 *  @param textColor 默认是blackColor
 */
+ (void)setTextColorOfTTView:(nullable UIColor *)textColor;

/**
 *  设置弹出背景的颜色
 *
 *  @param slMessageGroundColor 默认是grayColor
 */
+ (void)setBackgroudColorOfTTView:(nullable UIColor *)slMessageGroundColor;

/**
 *  设置信息弹出框弹出时间
 *
 *  @param duration 默认是0.15s
 */
+ (void)setFadeInAnimationDuration:(NSTimeInterval)duration;

/**
 *  设置弹出框的高度
 *
 *  @param height 高度
 */
+ (void)setHeightOfTTView:(CGFloat)height;

/**
 *  设置信息消失的时间
 *
 *  @param duration 默认是0.15s
 */
+ (void)setFadeOutAnimationDuration:(NSTimeInterval)duration;

/**
 *  消息框显示的时间
 *
 *  @param duration 默认是4s
 */
+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)duration;

/**
 *  显示弹出框文字
 *
 *  @param status 弹出框的文字说明
 */
+ (void)showWithStatus:(nullable NSString *)status;

/**
 *  展示弹窗框左侧图片和弹出框状态信息
 *
 *  @param leftImage 左侧图片信息
 *  @param status    弹出弹出框的文字信息
 */
+ (void)showWithLeftImage:(nullable UIImage *)leftImage status:(nullable NSString *)status;

/**
 *  展示弹窗框左侧图片和弹出框状态信息
 *
 *  @param rightImage 右侧图片信息
 *  @param status     弹出弹出框的文字信息
 */
+ (void)showWithRightImage:(nullable UIImage *)rightImage status:(nullable NSString *)status;

/**
 *  设置信息弹出框弹出时间
 *
 *  @param string duration 默认是0.15s
 *
 *  @return 返回展示的时间长度
 */
+ (NSTimeInterval)displayDurationForString:(nullable NSString *)string;

@end
