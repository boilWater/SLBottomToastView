//
//  SLBottomToastViewLeftCell.m
//  SLMessgaeToastView
//
//  Created by liangbai on 16/9/12.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "SLBottomToastViewLeftCell.h"

@interface SLBottomToastViewLeftCell ()<SLBottomToastViewCellDelegate>

@property (nonatomic) CGRect automaticAdjustRectOfTextLabel;

@property (nonatomic) CGSize sizeOfTextLabel;

@property (nonatomic, assign) CGFloat heightOfToastViewCell;

@property (nonatomic, assign) CGFloat widthOfToastViewCell;

@property (nonatomic, assign) CGFloat heightOfImageView;

@end

@implementation SLBottomToastViewLeftCell

@synthesize automaticAdjustRectOfTextLabel;
@synthesize heightOfToastViewCell, widthOfToastViewCell;
@synthesize heightOfImageView;

#pragma  mark -layout BottomMessageBoxCell的界面初始化

- (void)initUI
{
    heightOfImageView = [self getHeightOfUIImageView];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageView = imageView;
    [self.contentView addSubview:_imageView];
    
    //自动调节UILabel的宽度，这个需要在布局中实现
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _statusLabel = textLabel;
    [self.contentView addSubview:_statusLabel];
    
    self.layer.cornerRadius = 3;    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    //imageView and textLabel 之间布局
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationEqual toItem:self.statusLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-30]];
    
    //imageView and self
    [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0f constant:heightOfImageView]];
    [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0f constant:heightOfImageView]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterYWithinMargins relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.5 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:0.5 constant:5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.5 constant:5]];
    
    //textLabel and self
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:0.5 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:0.5 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.5 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeCenterXWithinMargins relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeCenterYWithinMargins relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

#pragma mark -delegate slBottomToastViewCell

- (CGFloat)getHeightOfUIImageView
{
    heightOfToastViewCell = (BOXCELL_HEIGHT ? BOXCELL_HEIGHT : 40);
    return (heightOfToastViewCell>30 ? 30 : (heightOfToastViewCell - 4));
}

@end
