//
//  SLTopToastView.m
//  SLMessgaeToastView
//
//  Created by liangbai on 16/9/2.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "SLTopToastView.h"

#define UISCREEN_WITH ([UIScreen mainScreen].bounds.size.width)
#define TTVIEW_WIDTH  (self.contentView.frame.size.width)
#define TTVIEW_HEIGHT (self.contentView.frame.size.height)
#define SLMessageBoxDefaultTextColor [UIColor blackColor]
#define SLMessageBoxDefaultBackgroundColor [UIColor grayColor]
#define SLMessageBoxDefaultFontOfStatusLabel [UIFont systemFontOfSize:21]

static const CGFloat SLMessageBoxDefaultAnimationDuration = 0.35;
static const CGFloat SLMessageBoxDefaultDismissTimeINterval = 1.5;
static const CGFloat SLMessageBoxDefaultHeight = 60;
static const CGFloat SLMessageBoxDefaultHeightOfUIImageView = 30;
static const CGFloat SLMessageBoxDefaultWidthOfUIImageView = 30;
static const CGFloat SLMessageBoxDefaultMarginToStatusLabel = 5;

@interface SLTopToastView ()
{
    BOOL _isInitializing;
}

//获取窗口View设置
@property (nonatomic, strong) UIControl *overlayView;

//消息弹出框
@property (nonatomic, strong) UIView *contentView;

//消息信息状态展示
@property (nonatomic, strong) UILabel *statusLabel;

//左侧imageView
@property (nonatomic, strong, nullable) UIImageView *leftImageView;

//右侧imageView
@property (nonatomic, strong, nullable) UIImageView *rightImageView;

@property (nonatomic, assign) CGFloat widthOfUIImageView;

@property (nonatomic, assign) CGFloat heigtOfUIImageView;

@property (nonatomic, assign) CGFloat imageViewMarginRightToStatusLabel;

@end

@implementation SLTopToastView

//单例获取对象
static SLTopToastView *_shareInstance = nil;

+ (SLTopToastView *) shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _shareInstance = [[SLTopToastView alloc] initWithFrame:[[[UIApplication sharedApplication] delegate] window].bounds];
    });
    return _shareInstance;
}

+ (void)showWithStatus:(NSString *)status
{
    NSTimeInterval displayInterval = [self displayDurationForString:status];
    SLTopToastView *topMessageView = [SLTopToastView new];
    [topMessageView showWithStatusOfTargets:status duration:displayInterval];
}

+ (void)showWithLeftImage:(UIImage *)leftImage status:(NSString *)status{
    NSTimeInterval displayInterval = [self displayDurationForString:status];
    SLTopToastView *topMessageView = [SLTopToastView new];
    [topMessageView showWithLeftImage:leftImage];
    [topMessageView showWithStatusOfTargets:status duration:displayInterval];
}

+ (void)showWithRightImage:(UIImage *)rightImage status:(NSString *)status{
    NSTimeInterval displayInterval = [self displayDurationForString:status];
    SLTopToastView *topMessageView = [SLTopToastView new];
    [topMessageView showWithRightImage:rightImage];
    [topMessageView showWithStatusOfTargets:status duration:displayInterval];
}

+ (void)setFadeInAnimationDuration:(NSTimeInterval)duration
{
    [[self shareInstance] setFadeInAnimationDuration:duration];
}

+ (void)setFadeOutAnimationDuration:(NSTimeInterval)duration
{
    [[self shareInstance] setFadeOutAnimationDuration:duration];
}

+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)duration
{
    [[self shareInstance] setMinimumDismissTimeInterval:duration];
}

+ (void)setHeightOfTTView:(CGFloat)height{
    [[self shareInstance] setHeightOfTTView:height];
}

+ (void)setFontOfTTView:(UIFont *)font
{
    [[self shareInstance] setFont:font];
}

+ (void)setTextColorOfTTView:(UIColor *)textColor
{
    [[self shareInstance] setTextColor:textColor];
}

+ (void)setBackgroudColorOfTTView:(UIColor *)slMessageGroundColor
{
    [[self shareInstance] setBackgroundColorOfTTView:slMessageGroundColor];
}

+ (NSTimeInterval)displayDurationForString:(NSString *)string
{
    return MAX((float)string.length*0.06 + 0.5, [self shareInstance].minimumDismissTimeInterval);
}

#pragma mark -initUI 初始化

- (void)initUI{
    _isInitializing = YES;
    _leftImageView.hidden = YES;
    _rightImageView.hidden = YES;
    
    self.backgroundColor = [UIColor clearColor];
    
    _minimumDismissTimeInterval = SLMessageBoxDefaultDismissTimeINterval;
    _fadeInAnimationDuration = SLMessageBoxDefaultAnimationDuration;
    _fadeOutAnimationDuration = SLMessageBoxDefaultAnimationDuration;
    _font = SLMessageBoxDefaultFontOfStatusLabel;
    _heightOfTTView = SLMessageBoxDefaultHeight;
    _heigtOfUIImageView = SLMessageBoxDefaultHeightOfUIImageView;
    _widthOfUIImageView = SLMessageBoxDefaultWidthOfUIImageView;
    _imageViewMarginRightToStatusLabel = SLMessageBoxDefaultMarginToStatusLabel;
    _textColor = SLMessageBoxDefaultTextColor;
    _backgroundColorOfTTView = SLMessageBoxDefaultBackgroundColor;
    
    _maxSupportedWindowLevel = UIWindowLevelNormal;
    _isInitializing = NO;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark -statusOfTargets showStatusTexts展示多对象文字

- (void)showWithStatusOfTargets:(NSString *)statusText duration:(NSTimeInterval)duration{
    self.statusLabel.text = statusText;
    [self updateViewHierarchy];
    [self showStatusOfTargets:statusText duration:duration];
}

#pragma mark -leftImage 展示左侧图片

- (void)showWithLeftImage:(UIImage *)leftImage{
    self.leftImageView.hidden = NO;
    self.leftImageView.image = leftImage;
}

#pragma mark -rightImage 展示右侧图片

- (void)showWithRightImage:(UIImage *)rightImage{
    self.rightImageView.image = rightImage;
    self.rightImageView.hidden = NO;
}

#pragma mark -showAnimation 多个对象动画展示

- (void)showStatusOfTargets:(NSString *)status duration:(NSTimeInterval)displayInterval{
    __weak SLTopToastView *weakSelf = self;
    __block void(^animationBlock)(void) = ^{
        __strong SLTopToastView *strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.contentView.transform = CGAffineTransformMakeTranslation(0, _heightOfTTView);
        }
    };
    __block void(^apperanceBlock)(void) = ^{
        __strong SLTopToastView *strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.contentView.frame = CGRectMake(0, 0, UISCREEN_WITH, 60);
        }
    };
    __block void(^disapperBlock)(void) = ^{
        __strong SLTopToastView *strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.contentView.transform = CGAffineTransformMakeTranslation(0, -60);
        }
    };
    __block void(^removeBlock)(void) = ^{
        __strong SLTopToastView *strongSelf = weakSelf;
        if (strongSelf) {
            [self.overlayView removeFromSuperview];
            [_contentView removeFromSuperview];
            _contentView = nil;
            self.overlayView = nil;
            [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:0];
            [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelNormal];
        }
    };
    [UIView animateKeyframesWithDuration:_fadeInAnimationDuration delay:0 options:0.0f animations:^{
                animationBlock();
            }completion:^(BOOL finished){
                [UIView animateKeyframesWithDuration:displayInterval delay:_fadeInAnimationDuration options:0.0f
                    animations:^{
                        apperanceBlock();
                }completion:^(BOOL finished) {
                    [UIView animateKeyframesWithDuration:_fadeOutAnimationDuration delay:(displayInterval + _fadeInAnimationDuration) options:0.0f animations:^{
                        disapperBlock();
                    } completion:^(BOOL finished) {
                        removeBlock();
                    }];
                }];
    }];
}

#pragma mark -updateView 更新View来加载界面UIKit

- (void)updateViewHierarchy{
    [self updateTTViewFrame];
    if (!self.overlayView.superview) {
#if !defined(SV_APP_EXTENSIONS)
        NSEnumerator *frontBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontBackWindows) {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= self.maxSupportedWindowLevel);
            
            if (windowOnMainScreen && windowIsVisible && windowLevelSupported) {
                [window addSubview:self.overlayView];
                break;
            }
        }
#else
        if (self.viewForExtension) {
            [self.viewForExtension addSubview:self.overlayView];
        }
#endif
        [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:0];
        [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelStatusBar + 1];
    }else{
        [self.overlayView.superview bringSubviewToFront:self.overlayView];
    }
    if (!self.superview) {
        [self.overlayView addSubview:self];
    }
    if (!self.contentView.superview) {
        [self.overlayView addSubview:self.contentView];
    }
    if (!self.statusLabel.superview) {
        [self.contentView addSubview:self.statusLabel];
    }
    if (!_leftImageView.hidden) {
        if (self.leftImageView.superview) {
            [self.contentView addSubview:self.leftImageView];
        }
    }
    if (!_rightImageView.hidden) {
        if (self.rightImageView.superview) {
            [self.contentView addSubview:self.rightImageView];
        }
    }
}

#pragma mark -updateFrameOfTTView 更新TTView的布局

- (void)updateTTViewFrame{
    CGFloat widthOfStatus = 100.0f;
    CGFloat heightOfStatus = 80.f;
    BOOL leftImageUsed = (self.leftImageView.image) && !(self.leftImageView.hidden);
    BOOL rightImageUsed = self.rightImageView.image && !(self.rightImageView.hidden);
    
    NSString *string = self.statusLabel.text;
    if (string) {
        CGSize sizeOfStatusLabel = CGSizeMake(300.0f, 240.0f);
        CGRect rectOfStatusLabel;
        if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
            rectOfStatusLabel = [string boundingRectWithSize:sizeOfStatusLabel options:(NSStringDrawingOptions)(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.statusLabel.font} context:NULL];
        }else{
            CGSize sizeOfStatusLabel;
            if ([string respondsToSelector:@selector(sizeWithAttributes:)]) {
                sizeOfStatusLabel = [string sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:self.font.fontName size:self.statusLabel.font.pointSize]}];
            }
            rectOfStatusLabel = CGRectMake(0.0f, 0.0f, sizeOfStatusLabel.width, sizeOfStatusLabel.height);
        }
        //在Label存在是进行布局调整
        widthOfStatus = rectOfStatusLabel.size.width;
        heightOfStatus = rectOfStatusLabel.size.height;
        if (! rightImageUsed && !leftImageUsed) {
            self.statusLabel.frame = CGRectMake((UISCREEN_WITH - widthOfStatus)/2, (TTVIEW_HEIGHT - heightOfStatus)/2, widthOfStatus, heightOfStatus);
        }
        //左侧图片 used
        CGFloat positionX = (UISCREEN_WITH - _widthOfUIImageView - _imageViewMarginRightToStatusLabel - widthOfStatus)/2;
        CGFloat posItionY = (TTVIEW_HEIGHT - _heigtOfUIImageView)/2;
        if (leftImageUsed) {
            self.leftImageView.frame = CGRectMake(positionX, posItionY, _widthOfUIImageView, _heigtOfUIImageView);
            self.statusLabel.frame = CGRectMake(positionX+_widthOfUIImageView+_imageViewMarginRightToStatusLabel, (TTVIEW_HEIGHT - heightOfStatus)/2, widthOfStatus, heightOfStatus);
        }
        //右侧图片 used
        if (rightImageUsed) {
            self.statusLabel.frame = CGRectMake(positionX, (TTVIEW_HEIGHT - heightOfStatus)/2, widthOfStatus, heightOfStatus);
            self.rightImageView.frame = CGRectMake(self.statusLabel.frame.size.width+positionX+_imageViewMarginRightToStatusLabel, posItionY,_widthOfUIImageView, _heigtOfUIImageView);
        }
    }
}

#pragma mark -overlayView 添加图层

- (UIControl *)overlayView{
    if (!_overlayView) {
        _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WITH, _heightOfTTView)];
    }
#if !defined(SV_APP_EXTENSIONS)
        _overlayView.frame = CGRectMake(0, 0, UISCREEN_WITH, _heightOfTTView);
#else
        _overlayView.frame = [UIScreen mainScreen].bounds;
#endif
    return _overlayView;
}

#pragma mark -contentView 内容View

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, -_heightOfTTView, UISCREEN_WITH, _heightOfTTView)];
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    _contentView.backgroundColor = _backgroundColorOfTTView;
#else
    _contentView.backgroundColor = self.backgroundColorForStyle;
#endif
    return _contentView;
}

#pragma mark -statusLabel 显示信息

- (UILabel *)statusLabel{
    if (!_statusLabel) {
        CGFloat widthOfStatusLabel = 150;
        CGFloat heightOfStatusLabel = 35;
        
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake((UISCREEN_WITH - widthOfStatusLabel)/2, (TTVIEW_HEIGHT - heightOfStatusLabel)/2, widthOfStatusLabel, heightOfStatusLabel)];
        _statusLabel.textColor = _textColor;
        _statusLabel.font = _font;
    }
    if (!_statusLabel.superview) {
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

#pragma mark -imageviewLeft 显示左侧图片

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    if (!_leftImageView.superview) {
        [self.contentView addSubview:_leftImageView];
    }
    return _leftImageView;
}

#pragma mark -imageviewRight 显示右侧图片

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
    }
    if (!_rightImageView.superview) {
        [self.contentView addSubview:_rightImageView];
    }
    return _rightImageView;
}

#pragma  mark -fadein 设置弹出框进入时间

- (void)setFadeInAnimationDuration:(NSTimeInterval)duration
{
    if (!_isInitializing) {
        _fadeInAnimationDuration = duration;
    }
}

#pragma  mark -fadeout 设置弹出框弹出时间

- (void)setFadeOutAnimationDuration:(NSTimeInterval)duration
{
    if (!_isInitializing) {
        _fadeOutAnimationDuration = duration;
    }
}

#pragma mark -mindismiss 设置弹出框显示的最长时间值

- (void)setMinimumDismissTimeInterval:(NSTimeInterval)duration
{
    if (!_isInitializing) {
        _minimumDismissTimeInterval = duration;
    }
}

#pragma mark -meassageFont

- (void)setFont:(UIFont *)font
{
    if (!_isInitializing) {
        _font = font;
    }
}

- (void)setHeightOfTTView:(CGFloat)height{
    if (!_isInitializing) {
        _heightOfTTView = height;
    }
}

#pragma mark -messageTextColor

- (void)setTextColor:(UIColor *)textColor
{
    if (!_isInitializing) {
        _textColor = textColor;
    }
}

#pragma mark -messageBackground

- (void)setBackgroundColorOfTTView:(UIColor *)slMessageGroundColor
{
    if (!_isInitializing) {
        _backgroundColorOfTTView = slMessageGroundColor;
    }
}

@end
