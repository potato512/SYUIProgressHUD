# SYUIProgressHUD
提示信息弹窗


使用介绍 
  * 自动导入：使用命令`pod 'SYUIProgressHUD'`导入到项目中
  * 手动导入：或下载源码后，将源码添加到项目中
  

使用示例

* SYUIProgressHUD 的使用示例

导入头文件
```
#import "SYUIProgressHUD.h"
```

```
// 属性设置
HUDUtil.hudColor = UIColorHexAndAlpha(#000000, 1.0);
HUDUtil.hudCornerRadius = 8.0;
HUDUtil.messageFont = UIFontAutoSize(16);
HUDUtil.messageColor = UIColorHex(#FFFFFF);
HUDUtil.minWidth = 158;
HUDUtil.maxWidth = 260;
HUDUtil.autoSize = YES;
```

```
// 隐藏
[HUDUtil hide:YES];
[HUDUtil hide:YES delay:5];
```

```
// 显示信息
self.textArray = @[@"出错了，赶紧找问题吧！", @"正确！", @"因为你的不努力，现在发现了很多存在的隐患，你必须在规定的时间点完成所有的工作。否则后果很严重！"];
NSString *message = self.textArray[arc4random() % self.textArray.count];
```

```
// 父视图
UIView *view = UIApplication.sharedApplication.delegate.window;
```

```
// 显示HUD不隐藏 仅信息"
[HUDUtil showWithView:view message:message];
```

```
// 显示HUD自动隐藏 仅信息
[HUDUtil showAutoHideWithView:view message:message];
```

```
// 显示HUD不隐藏 仅符号指示器
[HUDUtil showWithActivityView:view];
```

```
// 显示HUD自动隐藏 仅符号指示器
[HUDUtil showWithView:view type:SYUIProgressHUDModeDefault image:nil message:nil hide:YES delay:3 enabled:YES shadow:YES animation:YES];
```

```
显示HUD不隐藏 仅图标
UIImage *image = [UIImage imageNamed:@"withNetwork"];
[HUDUtil showWithView:view icon:image animation:YES];
```

```
// 显示HUD自动隐藏 仅图标
UIImage *image = [UIImage imageNamed:@"withoutNetwork"];
[HUDUtil showWithView:view type:SYUIProgressHUDModeCustomView image:image message:nil hide:NO delay:3 enabled:YES shadow:YES animation:YES];
```

```
// 显示HUD不隐藏 信息和符号指示器
[HUDUtil showWithActivityView:view message:message];
```

```
// 显示HUD自动隐藏 信息和符号指示器
[HUDUtil showWithView:view type:SYUIProgressHUDModeDefault image:nil message:message hide:YES delay:3 enabled:YES shadow:YES animation:YES];
```

```
// 显示HUD不隐藏 信息和图标
UIImage *image = [UIImage imageNamed:@"error"];
[HUDUtil showWithView:view type:SYUIProgressHUDModeCustomView image:image message:message hide:NO delay:3 enabled:YES shadow:YES animation:YES];
```

```
// 显示HUD自动隐藏 信息和图标
UIImage *image = [UIImage imageNamed:@"success"];
[HUDUtil showWithView:view type:SYUIProgressHUDModeCustomView image:image message:message hide:YES delay:3 enabled:YES shadow:YES animation:YES];
```

效果图

![SYToast](./images/SYToast.gif) 


#### 修改说明
* 20200623
  * 版本号：1.3.1
  * 修改完善
    * 新增属性：`@property (nonatomic, assign) CGSize hudSize;`
    * 新增方法：`- (void)hide:(BOOL)animation delay:(NSTimeInterval)delayTime;`

* 20200427
  * 版本号：1.3.0
  * 修改优化
    * 去掉类方法，改成单例
    * 新增
      * 显示样式HUDMode
      * 是否多行显示isSingleline

* 20200420
  * 版本号：1.2.5
  * 修改优化
    * 自适应改变大小（纯文本不适用）
    * 文本计算显示宽度异常修改
    * 增加属性和方法
      * 属性：类型（纯文本、纯活动指示器、纯图标、自定义视图、文本+图标、文本+活动批示器、文本+自定义视图）、点击空白处隐藏、最大最小值、文本单行显示
      * 方法：隐藏带回调、隐藏有无动画


* 20200419
  * 版本号：1.2.0 1.2.1 1.2.2 1.2.3 1.2.4
  * 修改成 SYUIProgressHUD
    * 使用类方法定义属性
    * 使用类方法调用
    * 自动识别类型
      * 文本信息
      * 活动指示器
      * 图标
      * 文本+活动指示器
      * 文本+图标

* 20181115
  * 版本号：1.1.7
  * 修改显示重影的异常
  
* 20181114
  * 版本号：1.1.6
  * 修改完善
    * 自定义父视图
    * 自定义显示类型：文本、菊花转、自定义视图

* 20181019
  * 版本号：1.1.4
  * 删除HUD
  
* 20180816
  * 版本号：1.1.2
  
  * 版本号：1.1.1
  * 功能完善：修改异常

* 20180815
  * 版本号：1.1.0
  * 功能完善
    * 添加属性设置
      * 延迟隐藏时间
      * 背景颜色设置
      * 字体颜色设置
      * 字体大小设置
    * 修改隐藏方法
    * 添加`MBProgressHUD`封装类库`SYHUDProgress`
    * 添加`SYNetworkStatusView`顶部弹窗提示封装类（常用于网络状态提示）

* 20180802
  * 版本号：1.0.0
  * 修改完善
  
* 20170607
  * 方法名称修改，避免其他库文件方法同名。

