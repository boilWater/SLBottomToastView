//
//  SLTopMessageBox.m
//  SLMessageBox
//
//  Created by liangbai on 16/8/15.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "SLTopMessageBox.h"
#import <UIKit/UIKit.h>

#define  UISCREEN_WITH ([UIScreen mainScreen].bounds.size.width)
#define SLMessageBoxDefaultTextColor [UIColor blackColor]
#define SLMessageBoxDefaultBackgroundColor [UIColor grayColor]

static const CGFloat SLMessageBoxDefaultAnimationDuration = 0.35;
static const CGFloat SLMessageBoxDefaultDismissTimeINterval = 1.5;
static const CGFloat SLMessageBoxDefaultTextFont = 20;
static const CGFloat SLMessageBoxDefaultDefaultheight = 60;


@interface SLTopMessageBox ()
{
    BOOL _isInitializing;
    BOOL _isAppearing;
}

//获取窗口View设置
@property (nonatomic, strong) UIControl *overlayView;

//消息弹出框
@property (nonatomic, strong) UIView *messageBoxView;

//消息信息状态展示
@property (nonatomic, strong) UILabel *statusLabel;

//左侧imageView
@property (nonatomic, strong, nullable) UIImageView *leftImageView;

//右侧imageView
@property (nonatomic, strong, nullable) UIImageView *rightImageView;

@end


@implementation SLTopMessageBox

//单例获取对象
static SLTopMessageBox *_shareInstance = nil;

+ (SLTopMessageBox *) shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _shareInstance = [[self alloc] initWithFrame:[[[UIApplication sharedApplication] delegate] window].bounds];
    });
    return _shareInstance;
}

+ (void) showWithStatus:(NSString *)status
{
    NSTimeInterval displayInterval = [self displayDurationForString:status];
    [[self shareInstance] showWithStatus:status duration:displayInterval];
    [[self shareInstance] showWithStatusText:status];
}

+ (void) showWithLeftImage:(UIImage *)leftImage status:(NSString *)status{
    [self showWithStatus:status];
    [[self shareInstance] showWithLeftImage:leftImage];
    [[self shareInstance] showWithStatusText:status];
}

+ (void) showWithRightImage:(UIImage *)rightImage status:(NSString *)status{
    [self showWithStatus:status];
    [[self shareInstance] showWithRightImage:rightImage];
    [[self shareInstance] showWithStatusText:status];
}

+ (void) setFadeInAnimationDuration:(NSTimeInterval)duration
{
    [[self shareInstance] setFadeInAnimationDuration:duration];
}

+ (void) setFadeOutAnimationDuration:(NSTimeInterval)duration
{
    [[self shareInstance] setFadeOutAnimationDuration:duration];
}

+ (void) setMinimumDismissTimeInterval:(NSTimeInterval)duration
{
    [[self shareInstance] setMinimumDismissTimeInterval:duration];
}

+ (void) setMessageBoxStatusLabelFont:(NSInteger)font
{
    [[self shareInstance] setMessageBoxStatusLabelFont:font];
}

+ (void) setMessageBoxStatusLabelTextColor:(UIColor *)textColor
{
    [[self shareInstance] setMessageBoxStatusLabelTextColor:textColor];
}

+ (void) setMessageBoxBackgroudColor:(UIColor *)slMessageGroundColor
{
    [[self shareInstance] setMessageBoxBackgroudColor:slMessageGroundColor];
}

+ (void) setIsSupportedTargets:(BOOL)isSupportedTargets{
    [[self shareInstance] setIsSupportedTargets:isSupportedTargets];
}

+ (NSTimeInterval) displayDurationForString:(NSString *)string
{
    return MAX((float)string.length*0.06 + 0.5, [self shareInstance].minimumDismissTimeInterval);
}


#pragma mark -initFrame 初始化界面数据

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isInitializing = YES;
        _isAppearing = NO;
        _isSupportedTargets = NO;
        
        self.backgroundColor = [UIColor clearColor];
        
        _minimumDismissTimeInterval = SLMessageBoxDefaultDismissTimeINterval;
        _fadeInAnimationDuration = SLMessageBoxDefaultAnimationDuration;
        _fadeOutAnimationDuration = SLMessageBoxDefaultAnimationDuration;
        _SLMHeight = SLMessageBoxDefaultDefaultheight;
        _font = SLMessageBoxDefaultTextFont;
        _textColor = SLMessageBoxDefaultTextColor;
        _backgroundColor = SLMessageBoxDefaultBackgroundColor;
        
        _maxSupportedWindowLevel = UIWindowLevelNormal;
        _isInitializing = NO;
    }
    return self;
}

#pragma mark -showanddisapper 弹出框的show 和 disapper

- (void) showWithStatus:(NSString *)status duration:(NSTimeInterval) displayInterval
{
    __weak SLTopMessageBox *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        __strong SLTopMessageBox *strongSelf = weakSelf;
        if (strongSelf)
        {
            //获取View层次，看是否可用
            [strongSelf updateViewHierarchy];
            //展示动画
            [strongSelf showStatus:status duration:displayInterval];
        }
    }];
}

#pragma mark -showstatus 弹出框的show

- (void) showStatus:(NSString *)status duration:(NSTimeInterval) displayInterval
{
    [self.layer removeAllAnimations];
    self.frame = CGRectMake(0, -_SLMHeight, UISCREEN_WITH, _SLMHeight);

    CFTimeInterval currentTime = CACurrentMediaTime();
    CABasicAnimation *appearAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    appearAnimation.beginTime = currentTime;
    appearAnimation.duration = _fadeInAnimationDuration;
    appearAnimation.fromValue = @(0);
    appearAnimation.toValue = @(_SLMHeight);
    appearAnimation.delegate = self;
    appearAnimation.removedOnCompletion = NO;
    [self.messageBoxView.layer addAnimation:appearAnimation forKey:@"appear"];
    
    CABasicAnimation *disappearAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    disappearAnimation.beginTime = currentTime + _fadeInAnimationDuration + displayInterval;
    disappearAnimation.duration = _fadeOutAnimationDuration;
    disappearAnimation.fromValue = @(0);
    disappearAnimation.toValue = @(-_SLMHeight);
    disappearAnimation.delegate = self;
    appearAnimation.removedOnCompletion = NO;
    [self.messageBoxView.layer addAnimation:disappearAnimation forKey:@"disappear"];
}

#pragma  mark -fadein 设置弹出框进入时间

- (void) setFadeInAnimationDuration:(NSTimeInterval)duration
{
    if (!_isInitializing) {
        _fadeInAnimationDuration = duration;
    }
}

#pragma  mark -fadeout 设置弹出框弹出时间

- (void) setFadeOutAnimationDuration:(NSTimeInterval)duration
{
    if (!_isInitializing) {
        _fadeOutAnimationDuration = duration;
    }
}

#pragma mark -mindismiss 设置弹出框显示的最长时间值

- (void) setMinimumDismissTimeInterval:(NSTimeInterval)duration
{
    if (!_isInitializing) {
        _minimumDismissTimeInterval = duration;
    }
}

#pragma mark -meassageFont

- (void) setMessageBoxStatusLabelFont:(NSInteger)font
{
    if (!_isInitializing) {
        _font = font;
    }
}

#pragma mark -supportedTargets

- (void) setIsSupportedTargets:(BOOL)isSupportedTargets{
    if (!_isInitializing) {
        _isSupportedTargets = isSupportedTargets;
    }
}

#pragma mark -messageTextColor

- (void) setMessageBoxStatusLabelTextColor:(UIColor *)textColor
{
    if (!_isInitializing) {
        _textColor = textColor;
    }
}

#pragma mark -messageBackground

- (void) setMessageBoxBackgroudColor:(UIColor *)slMessageGroundColor
{
    if (!_isInitializing) {
        _backgroundColor = slMessageGroundColor;
    }
}

#pragma  mark -showleftimage 弹出框设置左侧图片和文字

- (void) showWithStatusText:(NSString *)textOfStatus
{
    __weak SLTopMessageBox *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        __strong SLTopMessageBox *strongSelf = weakSelf;
        if (strongSelf) {
            _statusLabel = [strongSelf statusLabel];
            [strongSelf.messageBoxView addSubview:_statusLabel];
        }
    }];
}

#pragma  mark -showleftimage 弹出框设置左侧图片和文字

- (void) showWithLeftImage:(UIImage *)leftImage
{
    __weak SLTopMessageBox *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        __strong SLTopMessageBox *strongSelf = weakSelf;
        if (strongSelf) {
            _leftImageView = [strongSelf leftImageView];
            _leftImageView.image = leftImage;
            [strongSelf.messageBoxView addSubview:_leftImageView];
        }
    }];
}

#pragma  mark -showrightimage 弹出框设置右侧图片和文字

- (void) showWithRightImage:(UIImage *)rightImage
{
    __weak SLTopMessageBox *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        __strong SLTopMessageBox *strongSelf = weakSelf;
        if (strongSelf) {
            _rightImageView = [strongSelf rightImageView];
            _rightImageView.image = rightImage;
            [strongSelf.messageBoxView addSubview:_rightImageView];
        }
    }];
}

#pragma mark -updataview 获取view的图层查看是否可以使用

- (void) updateViewHierarchy
{
    if(!self.overlayView.superview) {
        
#if !defined(SV_APP_EXTENSIONS)
        // 默认情况 ： 在 UIApplication Windows的上方
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows) {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= self.maxSupportedWindowLevel);
            
            if(windowOnMainScreen && windowIsVisible && windowLevelSupported) {
                [window addSubview:self.overlayView];
                break;
            }
        }
#else
        // SVProgressHUD 如果被用在app extension 中的就添加到给到的view
        if(self.viewForExtension) {
            [self.viewForExtension addSubview:self.overlayView];
        }
#endif
        [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:0];
        [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelStatusBar + 1];
    } else {
        //确定overlayView是在rootViewController 最上层的
        [self.overlayView.superview bringSubviewToFront:self.overlayView];
    }
    //添加self 到 overlay 的 View上面
    if(!self.superview){
        [self.overlayView addSubview:self];
    }
    if(!self.messageBoxView.superview) {
        [self addSubview:self.messageBoxView];
    }
}

#pragma mark -view 设置view在最上层

- (UIControl *) overlayView {
    if(!_overlayView) {
        _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WITH, 60)];
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _overlayView.backgroundColor = [UIColor clearColor];
    }
    // 更新 frame
    if (!_isSupportedTargets) {
#if !defined(SV_APP_EXTENSIONS)
        
        _overlayView.frame = CGRectMake(0, 0, UISCREEN_WITH, _SLMHeight);
#else
        _overlayView.frame = [UIScreen mainScreen].bounds;
#endif
    }
    return _overlayView;
}

#pragma mark -messageview 信息弹出框view

- (UIView*)messageBoxView {
    if(!_messageBoxView) {
        _messageBoxView = [[UIView alloc] initWithFrame:CGRectMake(0, -_SLMHeight, UISCREEN_WITH, _SLMHeight)];
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    _messageBoxView.backgroundColor = _backgroundColor;
#else
    _messageBoxView.backgroundColor = self.backgroundColorForStyle;
#endif
    return _messageBoxView;
}

#pragma mark -label 初始化显示数据label

- (UILabel*)statusLabel {
    if(!_statusLabel)
    {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 180, 50)];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textColor = _textColor;
        _statusLabel.font = [UIFont systemFontOfSize:_font];
        _statusLabel.adjustsFontSizeToFitWidth = YES;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _statusLabel.numberOfLines = 1;
        _statusLabel.center = _messageBoxView.center;
    }
    return _statusLabel;
}

#pragma mark -imageview 初始化imageview

- (UIImageView *) leftImageView{
    UIImageView *imageView;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 15, 35, 35)];
    
    return imageView;
}

#pragma mark -imageview 初始化imageview

- (UIImageView *) rightImageView{
    UIImageView *imageView;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(295, 15, 35,35)];
    
    return imageView;
}

- (void)animationDidStart:(CAAnimation *)anim
{

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%@", self.messageBoxView);
    if (flag) {
        if (!_isAppearing) {
            _isAppearing = YES;
            [self setFrame: CGRectMake(0, _SLMHeight, UISCREEN_WITH, _SLMHeight)];
        }else{
            _isAppearing = NO;
            [self setFrame: CGRectMake(0, -_SLMHeight, UISCREEN_WITH, _SLMHeight)];
        }
    }
}

@end
