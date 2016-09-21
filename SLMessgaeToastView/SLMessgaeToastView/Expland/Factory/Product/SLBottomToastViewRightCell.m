//
//  SLBottomToastViewRightCell.m
//  SLMessgaeToastView
//
//  Created by liangbai on 16/9/12.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "SLBottomToastViewRightCell.h"

@interface SLBottomToastViewRightCell ()<SLBottomToastViewCellDelegate>

@property (nonatomic, assign) CGFloat heightOfToastViewCell;

@property (nonatomic, assign) CGFloat heightOfImageView;

@end

@implementation SLBottomToastViewRightCell

#pragma  mark -layout BottomMessageBoxCell的界面初始化

- (void)initUI{
    _heightOfImageView = [self getHeightOfUIImageView];
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_rightImageView];
    
    _describeLabel = [[UILabel alloc] init];
    _describeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_describeLabel];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    //rightImageView and descripeLabel 相对位置
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:_describeLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:20]];
    
    //rightImageView 的位置布局
    [_rightImageView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0f constant:_heightOfImageView]];
    [_rightImageView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0f constant:_heightOfImageView]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView attribute:NSLayoutAttributeCenterYWithinMargins relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.5 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:0.5 constant:5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.5 constant:5]];
    
    //describeLabel 的位置布局
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_describeLabel attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:0.5 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_describeLabel attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:0.5 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_describeLabel attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.5 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_describeLabel attribute:NSLayoutAttributeCenterXWithinMargins relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_describeLabel attribute:NSLayoutAttributeCenterYWithinMargins relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

#pragma mark -delegate slBottomToastViewCell

- (CGFloat)getHeightOfUIImageView{
    _heightOfToastViewCell = (BOXCELL_HEIGHT ? BOXCELL_HEIGHT : 40);
    return (_heightOfToastViewCell>30 ? 30 : (_heightOfToastViewCell - 4));
}

@end
