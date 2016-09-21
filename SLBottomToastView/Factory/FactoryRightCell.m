//
//  FactoryRightCell.m
//  SLMessgaeToastView
//
//  Created by liangbai on 16/9/12.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "FactoryRightCell.h"

@implementation FactoryRightCell

+ (SLBottomToastViewCell *)CreateBottomToastViewCell{
    return [SLBottomToastViewRightCell new];
}

@end
