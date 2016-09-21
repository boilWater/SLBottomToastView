//
//  Factory.h
//  SLMessgaeToastView
//
//  Created by liangbai on 16/9/12.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLBottomToastViewCell.h"

@interface Factory : NSObject

+ (SLBottomToastViewCell *)CreateBottomToastViewCell;

@end
