//
//  SLBottomToastViewLeftCell.h
//  SLMessgaeToastView
//
//  Created by liangbai on 16/9/12.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "SLBottomToastViewCell.h"


@interface SLBottomToastViewLeftCell : SLBottomToastViewCell

//图片 View
@property (nonatomic, readonly, strong, nullable) UIImageView *imageView;

//展示 文字
@property (nonatomic, readonly, strong, nullable) UILabel *statusLabel;

@end
