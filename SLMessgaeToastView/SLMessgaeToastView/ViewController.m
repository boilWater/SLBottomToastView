//
//  ViewController.m
//  SLMessgaeToastView
//
//  Created by liangbai on 16/8/31.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "ViewController.h"
#import "SLTopToastView.h"
#import "SLBottomToastView.h"
#import "FactoryLeftCell.h"

@interface ViewController ()<SLBottomMessageBoxDataSource, SLBottomMessageBoxDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)click1:(id)sender {
    SLBottomToastView *bottomToastView = [[SLBottomToastView alloc] init];
    bottomToastView.dataSource = self;
    bottomToastView.delegate = self;
    [self.view addSubview:bottomToastView];
}

- (IBAction)click2:(id)sender {
    [SLTopToastView showWithLeftImage:[UIImage imageNamed:@"education.png"] status:@"hello world!"];
}

- (IBAction)click3:(id)sender {
//    [SLTopMessageToastView setIsSupportedTargets:YES];
    [SLTopToastView showWithStatus:@" world!"];
}

#pragma mark -delegate and datesource

- (CGFloat)bottomToastView:(SLBottomToastView *)bottomToastView heightForRowAtIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            return 60;
            break;
        }
        case 1:{
            return 40;
            break;
        }
        case 2:{
            return 70;
            break;
        }
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfRowsInBottomToastView:(SLBottomToastView *)bottomToastView{
    return 4;
}

- (SLBottomToastViewCell *)bottomToastView:(SLBottomToastView *)bottomToastView cellForRowAtIndex:(NSInteger)index{
    SLBottomToastViewLeftCell *cell = (SLBottomToastViewLeftCell *)[FactoryLeftCell CreateBottomToastViewCell];
    cell.backgroundColor = [UIColor blueColor];
    cell.statusLabel.text = @"hello world!";
    cell.imageView.image = [UIImage imageNamed:@"education.png"];
    return cell;
}
@end
