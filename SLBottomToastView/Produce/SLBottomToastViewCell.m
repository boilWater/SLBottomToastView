//
//  SLBottomToastViewCell.m
//  SLMessgaeToastView
//
//  Created by liangbai on 16/8/31.
//  Copyright © 2016年 liangbai. All rights reserved.
//
#define TEXTLABEL_SIZE                        (CGSizeMake(120, 40))
#define SLBottomMessageBoxCellDefaultTextFont [UIFont systemFontOfSize:20]
#define BOXCELL_TEXTCOLOR                     ([UIColor blackColor])

#import "SLBottomToastViewCell.h"

@interface SLBottomToastViewCell (){
    BOOL _isInitializing;
}
@end

@implementation SLBottomToastViewCell

- (void)initView{
    UIView *contentView = [[UIView alloc] init];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentView = contentView;
    [self addSubview:_contentView];
    
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    _textLabel = label;
    [self addSubview:_textLabel];
    
    _isInitializing = YES;
    
    _font = SLBottomMessageBoxCellDefaultTextFont;
    _lineBreakMode = NSLineBreakByWordWrapping;
    _textColor = BOXCELL_TEXTCOLOR;
    _textAlignment = SLBottomToastViewCellTextAlignmentCenter;
    
    _isInitializing = NO;
}

#pragma mark -frame 初始化界面

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setTextAlignmentOfTextLabel:(SLBottomToastViewCellTextAlignment)textAlignment{
    [self setTextAlignment:textAlignment];
}

- (void)setTextOfTextLabel:(nullable NSString *)text
{
    [self setText:text];
}

- (void)setFontOfTextLabel:(nullable UIFont *)font
{
    [self setFont:font];
}

- (void)setLineBreakModeOfTextLabel:(NSLineBreakMode)lineBreakMode
{
    [self setLineBreakMode:lineBreakMode];
}

- (void)setTextColorOfTextLabel:(nullable UIColor *)textColor;
{
    [self setTextColor:textColor];
}

- (void)setImageOfUIViewImage:(nullable UIImage *)image
{
    [self setImage:image];
}

- (void)updateConstraints{
    [super updateConstraints];
    
    //contentView 的布局
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    //label 的布局
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterYWithinMargins relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

#pragma mark -text label的text

- (void)setText:(NSString *)text{
    if (!_isInitializing) {
        _textLabel.text = text;
    }
}

#pragma mark -alignment label的alignment

- (void)setTextAlignment:(SLBottomToastViewCellTextAlignment)textAlignment{
    if (!_isInitializing) {
        _textAlignment = textAlignment;
    }
}

#pragma mark -font text的font

- (void)setFont:(UIFont *)font{
    if (!_isInitializing) {
        _font = font;
    }
}

#pragma mark -lineBreakMode text的省略位置设置

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode{
    if (!_isInitializing) {
        _lineBreakMode = lineBreakMode;
    }
}

#pragma  mark -colorText text的color

- (void)setTextColor:(UIColor *)textColor{
    if (!_isInitializing) {
        _textColor = textColor;
    }
}

#pragma mark -image UIViewimage的image

- (void)setImage:(UIImage *)image{
    if (!_isInitializing) {
        _image = image;
    }
}

@end
