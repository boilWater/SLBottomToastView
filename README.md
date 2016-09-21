# SLBottomToastView
模仿IOS原生底部弹出框，进行相关信息展示

## SLBottomToastView使用说明

#### 功能说明：模仿IOS原生底部弹出框，进行相关信息展示

### cocoapods导入文件

```objc

   SLBottomToastView (0.0.1)
   show messgae
   pod 'SLBottomToastView', '~> 0.0.1'
   - Homepage: https://github.com/boilWater/SLBottomToastView
   - Source:   https://github.com/boilWater/SLBottomToastView.git
   
```

#### 使用实例：

```objc

//头文件引入
#import "SLBottomToastView.h"
#import "FactoryLeftCell.h"

实现相关协议SLBottomMessageBoxDataSource, SLBottomMessageBoxDelegate

```

在监听和相应事件中初始化 SLBottomToastView
```objc
SLBottomToastView *bottomToastView = [[SLBottomToastView alloc] init];
bottomToastView.dataSource = self;
bottomToastView.delegate = self;
[self.view addSubview:bottomToastView];

```


实现协议并在协议使用FactoryLeftCell初始化Cell

```objc
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

```

#### API接口说明

```objc

/**
 *  设置buttom的动画
 *
 *  @param slBottomMessageBoxAnimationStyle animationStyle类型
 */
+ (void)setAnimationStyle:(SLBottomMessageBoxAnimationStyle) slBottomMessageBoxAnimationStyle;

```
