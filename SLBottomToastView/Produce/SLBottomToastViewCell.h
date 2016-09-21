//
//  SLBottomToastViewCell.h
//  SLMessgaeToastView
//
//  Created by liangbai on 16/8/31.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SLBottomToastViewCellTextAlignment) {
    SLBottomToastViewCellTextAlignmentLeft,
#if TARGET_OS_IPHONE
    SLBottomToastViewCellTextAlignmentCenter,
    SLBottomToastViewCellTextAlignmentRight,
#else /* !TARGET_OS_IPHONE */
    SLBottomToastViewCellTextAlignmentCenter,
    SLBottomToastViewCellTextAlignmentRight,
#endif
    SLBottomToastViewCellTextAlignmentJustified,
    SLBottomToastViewCellTextAlignmentNatural,

};

#define BOXCELL_HEIGHT                        (self.bounds.size.height)
#define BOXCELL_WIDTH                         (self.bounds.size.width)
#define SLBottomMessageBoxCellDefaultTextFont [UIFont systemFontOfSize:20]
#define BOXCELL_TEXTCOLOR                     ([UIColor blackColor])
#define BOXCELL_CONTENTVIEWBACKGROUND         ([UIColor blueColor])
#define TEXTLABEL_SIZE                        (CGSizeMake(120, 40))

#define UISSCREEN_WIDTH ([[UIApplication sharedApplication] keyWindow].bounds.size.width)

@protocol SLBottomToastViewCellDelegate <NSObject>

@required

/**
 *  获取imageView的 height
 *
 *  @return height
 */
- (CGFloat)getHeightOfUIImageView;

@end

@interface SLBottomToastViewCell : UIView

@property (nonatomic, weak) id<SLBottomToastViewCellDelegate> delegate;

//显示 Label文字展示
@property (nonatomic, strong, nullable) UILabel *textLabel;

//内容 View
@property (nonatomic, strong, nullable) UIView *contentView;

//展示的字体
@property (nonatomic, copy, nullable) NSString *text;

//展示字体大小
@property (nonatomic, strong, nullable) UIFont *font;

//字体省略的方式
@property (nonatomic) NSLineBreakMode lineBreakMode;

//字体的颜色
@property (nonatomic, strong, nullable) UIColor *textColor;

//图片
@property (nonatomic, strong, nullable) UIImage *image;

//字体排布位置
@property (nonatomic) SLBottomToastViewCellTextAlignment textAlignment;

/**
 *  设置字体的Alignment（对其方式）
 *
 *  @param textAlignment 默认是SLBottomMessageBoxCellTextAlignmentCenter
 */
- (void)setTextAlignmentOfTextLabel:(SLBottomToastViewCellTextAlignment)textAlignment;

/**
 *  设置字体的text
 *
 *  @param text 默认是nil
 */
- (void)setTextOfTextLabel:(nullable NSString *)text;

/**
 *  设置字体的font
 *
 *  @param font 默认是[UIFont systemFontOfSize:20]
 */
- (void)setFontOfTextLabel:(nullable UIFont *)font;

/**
 *  设置字体的LineBreakMode（省略方式）
 *
 *  @param lineBreakMode 默认是NSLineBreakByWordWrapping
 */
- (void)setLineBreakModeOfTextLabel:(NSLineBreakMode)lineBreakMode;

/**
 *  设置字体的color
 *
 *  @param textColor 默认是blackcolor
 */
- (void)setTextColorOfTextLabel:(nullable UIColor *)textColor;

/**
 *  设置UIImageView的Image
 *
 *  @param image 默认是nil
 */
- (void)setImageOfUIViewImage:(nullable UIImage *)image;

@end
