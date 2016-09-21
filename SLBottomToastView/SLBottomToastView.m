//
//  SLBottomToastView.m
//  SLMessgaeToastView
//
//  Created by liangbai on 16/8/31.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "SLBottomToastView.h"
#import "SLBottomToastViewCell.h"

#define SCREEN_WIDTH ([[UIApplication sharedApplication] keyWindow].bounds.size.width)
#define SCREEN_HEIGHT ([[UIApplication sharedApplication] keyWindow].bounds.size.height)
#define UISCREEN_WITH   ([UIScreen mainScreen].bounds.size.width)
#define UISCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SLBOTTOMTOASTVIE_BACKGROUNDCOLOR ([UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:0.7])
#define TOASTVIE_BACKGROUNDCOLOR ([UIColor colorWithRed:156/255.0 green:203/255.0 blue:226/255.0 alpha:1.0])
#define SLCANCELBUTTON_BACKGROUNDCOLOR ([UIColor grayColor])

static const CGFloat   SLMessageButtonCellsDefaultHeidht = 40;
static const CGFloat   SLMessageBoxDefaultAnimationDuration = 0.6;
static const CGFloat   SLMessageBoxDefaultMinIntervalAnimation = 0.13;
static const CGFloat   SLMessageMarginOfEachCell = 25;
static const CGFloat   SLMessageButtonMarginToButtom = 40;
static const NSInteger SLMessageButtonDefaultWidth = 180;
static const NSInteger SLMessageButtonDefaultHeight = 40;
static const NSInteger SLMessageButtonCellsMarginToBorders = 20;


@interface SLBottomToastView ()<UIGestureRecognizerDelegate>{
    BOOL _isInitializing;
}

@property (nonatomic, strong) UIView *bottomToastView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) SLBottomToastViewCell *cell;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) CGFloat numberOfCells;

@property (nonatomic, assign) CGFloat heightOfCells;

@property (nonatomic, assign) CGFloat heightOfButton;

@property (nonatomic, assign) CGFloat heightOfToastView;

@property (nonatomic, strong) UISwipeGestureRecognizer *gestureRecognizer;

@end

@implementation SLBottomToastView

@synthesize numberOfCells, heightOfCells;
@synthesize toastViewBackgroundColor, heightOfToastView;
@synthesize bottomToastView, cancelButton, heightOfButton;
@synthesize fadeInAnimationDuration, minIntervalAnimation;

static SLBottomToastView *shareInstance;

+(SLBottomToastView *)shareInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

+ (void)setAnimationStyle:(SLBottomMessageBoxAnimationStyle)slBottomMessageBoxAnimationStyle{
    [self shareInstance].slBottomMessageBoxAnimationStyle = slBottomMessageBoxAnimationStyle;
}

#pragma mark -view 初始化View

- (void)initUI{
    _isInitializing = YES;
    
    fadeInAnimationDuration = SLMessageBoxDefaultAnimationDuration;
    minIntervalAnimation = SLMessageBoxDefaultMinIntervalAnimation;
    self.backgroundColor = SLBOTTOMTOASTVIE_BACKGROUNDCOLOR;
    toastViewBackgroundColor = TOASTVIE_BACKGROUNDCOLOR;
    _slBottomMessageBoxAnimationStyle = SLBottomMessageBoxAnimationStyleNone;
    numberOfCells = 0;
    heightOfCells = SLMessageButtonCellsDefaultHeidht;
    heightOfButton = SLMessageButtonDefaultHeight;
    
    _isInitializing = NO;
    [self showBottomToastview];
}

#pragma mark -getureRecongizer

- (void)initGestureRecongizer{
   _gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToBottomWithGestureRecognizer:)];
    _gestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:_gestureRecognizer];
}

#pragma mark -showBottomToastview 展示Toastview

- (void)showBottomToastview{
    __weak SLBottomToastView *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        __strong SLBottomToastView *strongSelf = weakSelf;
        if (strongSelf)
        {
            [strongSelf updateViewHierarchy];
            [strongSelf setAnimationToBottomToastView];
        }
    }];
}

#pragma mark -updateView 添加显示内容

- (void)updateViewHierarchy{
    [self updateLayoutViews];
    if (!self.bottomToastView.superview) {
        [self addSubview:self.bottomToastView];
    }
    if (!cancelButton.superview) {
        [self.bottomToastView addSubview:self.cancelButton];
    }
    CGFloat postionY = heightOfToastView - SLMessageButtonDefaultHeight - SLMessageButtonMarginToButtom;
    
    for (NSInteger i = 0; i < numberOfCells; i++) {
        self.cell = [self bottomToastView:self cellForRowAtIndex:i];
        CGFloat heightOfCell = [self bottomToastView:self heightForRowAtIndex:i];
        heightOfCells = (heightOfCell ? heightOfCell : SLMessageButtonCellsDefaultHeidht);
        NSLog(@"%f, %f", heightOfCell, heightOfCells);
        postionY = postionY - heightOfCells - SLMessageMarginOfEachCell;
        if (!self.cell.superview) {
            self.cell.frame = CGRectMake(SLMessageButtonCellsMarginToBorders, postionY, UISCREEN_WITH-SLMessageButtonCellsMarginToBorders*2, heightOfCells);
            [self.bottomToastView addSubview:self.cell];
        }
    }
}

#pragma mark -animation 添加动画

- (void)setAnimationToBottomToastView{
    _gestureRecognizer.enabled = NO;
    __weak SLBottomToastView *weakSelf = self;
    __block void(^animation)(void) = ^{
        __strong SLBottomToastView *strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.bottomToastView.transform = CGAffineTransformMakeTranslation(0, -heightOfToastView);
        }
    };
    __block void(^shake1)(void) = ^{
        __strong SLBottomToastView *strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.bottomToastView.transform = CGAffineTransformMakeTranslation(0, -heightOfToastView);
        }
    };
    if (_slBottomMessageBoxAnimationStyle == SLBottomMessageBoxAnimationStyleNone) {
        [UIView animateWithDuration:fadeInAnimationDuration delay:0 options:0.0f animations:^{
            animation();
        } completion:^(BOOL finished) {
            self.bottomToastView.frame = CGRectMake(0, UISCREEN_HEIGHT-heightOfToastView, UISCREEN_WITH, heightOfToastView);
            _gestureRecognizer.enabled = YES;
        }];
    }else{
        [UIView animateKeyframesWithDuration:fadeInAnimationDuration delay:0 options:0.0f animations:^{
            animation();
        } completion:^(BOOL finished) {
            [UIView animateKeyframesWithDuration:minIntervalAnimation delay:0 options:0.0f animations:^{
                shake1();
            } completion:^(BOOL finished) {
                [UIView animateKeyframesWithDuration:minIntervalAnimation delay:0 options:0.0f animations:^{
                    bottomToastView.transform = CGAffineTransformMakeTranslation(0, -heightOfToastView - 10);
                } completion:^(BOOL finished) {
                    [UIView animateKeyframesWithDuration:minIntervalAnimation delay:0 options:0.0f animations:^{
                        bottomToastView.transform = CGAffineTransformMakeTranslation(0, -heightOfToastView +5);
                    } completion:^(BOOL finished) {
                        self.bottomToastView.frame = CGRectMake(0, UISCREEN_HEIGHT-heightOfToastView, UISCREEN_WITH, heightOfToastView);
                        _gestureRecognizer.enabled = YES;
                    }];
                }];
            }];
        }];
    }
}

#pragma mark -layout 更新布局

- (void)updateLayoutViews{
    numberOfCells = [self numberOfRowsInBottomToastView:self];
//TODO
    CGFloat heightOfCell = 0.0;
    for (int i = 0; i < numberOfCells; i++) {
        heightOfCell = [self bottomToastView:self heightForRowAtIndex:i];
        heightOfCells = (heightOfCell ? heightOfCell : SLMessageButtonCellsDefaultHeidht);
        heightOfToastView += heightOfCells + SLMessageMarginOfEachCell;
    }
    heightOfToastView += SLMessageButtonMarginToButtom + SLMessageButtonDefaultHeight + SLMessageMarginOfEachCell;
}

#pragma mark -toastView 展示界面

- (UIView *)bottomToastView{
    if (!bottomToastView) {
        bottomToastView = [[UIView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WITH, heightOfToastView + 15)];
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    bottomToastView.backgroundColor = toastViewBackgroundColor;
#else
    bottomToastView.backgroundColor = self.backgroundColorForStyle;
#endif
    return bottomToastView;
}

#pragma mark -cancelButton 展示按钮

- (UIButton *)cancelButton{
    if (!cancelButton) {
        cancelButton = [[UIButton alloc] initWithFrame:CGRectMake((UISCREEN_WITH - SLMessageButtonDefaultWidth)/2, heightOfToastView - (heightOfButton + SLMessageButtonMarginToButtom), SLMessageButtonDefaultWidth, heightOfButton)];
    }
    [cancelButton addTarget:self action:@selector(slideToBottomWithGestureRecognizer:) forControlEvents:UIControlEventTouchDown];
    [cancelButton setTitle:@"隐藏" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 4;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    cancelButton.backgroundColor = SLCANCELBUTTON_BACKGROUNDCOLOR;
#else
    cancelButton.backgroundColor = self.backgroundColorForStyle;
#endif
    return cancelButton;
}

#pragma mark -disapper gestureRecoginerAnimation 下滑消失

- (void)slideToBottomWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    __weak SLBottomToastView *weakSelf = self;
    __block void(^dismissAnimation)(void) = ^{
        __strong SLBottomToastView *strongSelf = weakSelf;
        if (strongSelf)
        {
            strongSelf.bottomToastView.transform = CGAffineTransformMakeTranslation(0,UISCREEN_HEIGHT - 210);
        }
    };
    [UIView animateKeyframesWithDuration:fadeInAnimationDuration delay:0 options:0.0f animations:^{
        dismissAnimation();
    } completion:^(BOOL finished) {
        [self.bottomToastView removeFromSuperview];
        [self removeFromSuperview];
        self.bottomToastView = nil;
    }];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.duration = fadeInAnimationDuration;
    [self.layer addAnimation:animation forKey:@"opacityAnimation"];
}

- (void)setSlBottomMessageBoxAnimationStyle:(SLBottomMessageBoxAnimationStyle)slBottomMessageBoxAnimationStyle{
    if (!_isInitializing) {
        _slBottomMessageBoxAnimationStyle = slBottomMessageBoxAnimationStyle;
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        [self initUI];
        [self initGestureRecongizer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
        [self initGestureRecongizer];
    }
    return self;
}

#pragma mark -delegate bottomToastView的协议

- (CGFloat)bottomToastView:(SLBottomToastView * _Nonnull)bottomToastView heightForRowAtIndex:(NSInteger)index{
    if (_delegate && [_delegate respondsToSelector:@selector(bottomToastView:heightForRowAtIndex:)]) {
        return [_delegate bottomToastView:self heightForRowAtIndex:index];
    }
    return 0;
}

- (NSInteger)numberOfRowsInBottomToastView:(SLBottomToastView *)bottomToastView{
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfRowsInBottomToastView:)]) {
        return [_dataSource numberOfRowsInBottomToastView:self];
    }
    return 0;
}

- (SLBottomToastViewCell *)bottomToastView:(SLBottomToastView *)bottomToastView cellForRowAtIndex:(NSInteger)index{
    if (_dataSource && [_dataSource respondsToSelector:@selector(bottomToastView:cellForRowAtIndex:)]) {
        return [_dataSource bottomToastView:self cellForRowAtIndex:index];
    }
    return nil;
}
@end
