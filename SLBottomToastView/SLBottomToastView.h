//
//  SLBottomToastView.h
//  SLMessgaeToastView
//
//  Created by liangbai on 16/8/31.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SLBottomMessageBoxAnimationStyle) {
    SLBottomMessageBoxAnimationStyleNone,
    SLBottomMessageBoxAnimationStyleSharke
};

@class SLBottomToastView;
@class SLBottomToastViewCell;

#pragma mark -delegate bottomMessageBox

@protocol SLBottomMessageBoxDelegate <NSObject>

@optional

/**
 *  返回bottomMessageBox的cell的高度
 *
 *  @param bottomMessageBox self
 *
 *  @return cell的高度
 */
- (CGFloat)bottomToastView:(SLBottomToastView * _Nonnull)bottomToastView heightForRowAtIndex:(NSInteger)index;

@end

#pragma mark -datasource bottomMessageBox

@protocol SLBottomMessageBoxDataSource <NSObject>

@required

/**
 *  返回bottomMessage 行数
 *
 *  @param bottomMessageBox self
 *
 *  @return 行数
 */
- (NSInteger)numberOfRowsInBottomToastView:(SLBottomToastView * _Nonnull)bottomToastView;

/**
 *  根据具体的位置返回自定义的cell
 *
 *  @param bottomMessageBox
 *  @param indexPath        位置
 *
 *  @return 自定义的Cell
 */
- (SLBottomToastViewCell * _Nonnull)bottomToastView:(SLBottomToastView * _Nonnull)bottomToastView cellForRowAtIndex:(NSInteger)index;

@end

@interface SLBottomToastView : UIView

//默认是 0.15s
@property (nonatomic, assign) NSTimeInterval fadeInAnimationDuration;

@property (nonatomic, assign) CGFloat minIntervalAnimation;

@property (nonatomic, strong, nullable) UIColor *toastViewBackgroundColor;

@property (nonatomic, weak) id<SLBottomMessageBoxDataSource> dataSource;

@property (nonatomic, weak) id<SLBottomMessageBoxDelegate> delegate;

@property (nonatomic) SLBottomMessageBoxAnimationStyle slBottomMessageBoxAnimationStyle;

/**
 *  设置buttom的动画
 *
 *  @param slBottomMessageBoxAnimationStyle animationStyle类型
 */
+ (void)setAnimationStyle:(SLBottomMessageBoxAnimationStyle) slBottomMessageBoxAnimationStyle;

@end
