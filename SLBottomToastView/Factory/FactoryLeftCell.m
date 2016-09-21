//
//  FactoryLeftCell.m
//  SLMessgaeToastView
//
//  Created by liangbai on 16/9/12.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "FactoryLeftCell.h"

@implementation FactoryLeftCell

+ (SLBottomToastViewCell *)CreateBottomToastViewCell{
    return [SLBottomToastViewLeftCell new];
}

@end
