## SLTopToastView的使用说明
---
文件使用 Cmd markdown 打开

文档讲解步骤
> * 功能说明：
> * 使用实例：
> * API功能：

---
#### 功能说明：对于返回信息从屏幕的上方进行显示，返回是多信息对象的。

#### 使用实例

```objc
//头文件引入 SLTopMessageToastView.h 
[SLTopMessageToastView showWithStatus:@" world!"];
```

#### API的具体接口功能：
```objc
/**
*  设置弹出信息字体的大小
*
*  @param font 默认是20
*/

+ (void)setFontOfTTView:(UIFont * _Nullable)font;

/**
 *  设置弹出信息字体颜色
 *
 *  @param textColor 默认是blackColor
 */
 
+ (void)setTextColorOfTTView:(nullable UIColor *)textColor;

/**
 *  设置弹出背景的颜色
 *
 *  @param slMessageGroundColor 默认是grayColor
 */
 
+ (void)setBackgroudColorOfTTView:(nullable UIColor *)slMessageGroundColor;

/**
 *  设置信息弹出框弹出时间
 *
 *  @param duration 默认是0.15s
 */
 
+ (void)setFadeInAnimationDuration:(NSTimeInterval)duration;

/**
 *  设置弹出框的高度
 *
 *  @param height 高度
 */
 
+ (void)setHeightOfTTView:(CGFloat)height;

/**
 *  设置信息消失的时间
 *
 *  @param duration 默认是0.15s
 */
 
+ (void)setFadeOutAnimationDuration:(NSTimeInterval)duration;

/**
 *  消息框显示的时间
 *
 *  @param duration 默认是4s
 */
 
+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)duration;

/**
 *  显示弹出框文字
 *
 *  @param status 弹出框的文字说明
 */
 
+ (void)showWithStatus:(nullable NSString *)status;

/**
 *  展示弹窗框左侧图片和弹出框状态信息
 *
 *  @param leftImage 左侧图片信息
 *  @param status    弹出弹出框的文字信息
 */
 
+ (void)showWithLeftImage:(nullable UIImage *)leftImage status:(nullable NSString *)status;

/**
 *  展示弹窗框左侧图片和弹出框状态信息
 *
 *  @param rightImage 右侧图片信息
 *  @param status     弹出弹出框的文字信息
 */
 
+ (void)showWithRightImage:(nullable UIImage *)rightImage status:(nullable NSString *)status;

/**
 *  设置信息弹出框弹出时间
 *
 *  @param string duration 默认是0.15s
 *
 *  @return 返回展示的时间长度
 */
 
+ (NSTimeInterval)displayDurationForString:(nullable NSString *)string;
```

## SLBottomToastView使用说明

#### 功能说明：模仿IOS原生底部弹出框，进行相关信息展示

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
```
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

```

/**
 *  设置buttom的动画
 *
 *  @param slBottomMessageBoxAnimationStyle animationStyle类型
 */
+ (void)setAnimationStyle:(SLBottomMessageBoxAnimationStyle) slBottomMessageBoxAnimationStyle;

```






