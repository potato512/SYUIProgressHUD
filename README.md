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
SYUIProgressHUD.share.backgroundColor = UIColor.clearColor;
SYUIProgressHUD.share.activityColor = UIColor.blueColor;
SYUIProgressHUD.share.hudSize = CGSizeMake(80, 80);
SYUIProgressHUD.share.hudColor = UIColor.brownColor;
SYUIProgressHUD.share.hudCorner = 10;
SYUIProgressHUD.share.isAutoSize = NO;
SYUIProgressHUD.share.textAlign = NSTextAlignmentCenter;
SYUIProgressHUD.share.isSingleline = YES;
// 
SYHUDUtil.isFollowKeyboard = YES;
```

```
// 隐藏
[SYHUDUtil hide];
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
[SYHUDUtil showMessage:message view:view];
```

```
// 显示HUD自动隐藏 仅信息
[SYHUDUtil showMessage:message customView:nil view:view mode:HUDModeText autoHide:YES duration:3 enable:YES];
```

```
// 显示HUD不隐藏 仅符号指示器
[SYHUDUtil showActivity:view];
```

```
// 显示HUD自动隐藏 仅符号指示器
[SYHUDUtil showMessage:nil customView:nil view:view mode:HUDModeActivity autoHide:YES duration:3 enable:YES];
```

```
显示HUD不隐藏 仅图标
UIImage *image = [UIImage imageNamed:@"withNetwork"];
UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
[SYUIProgressHUD.share showMessage:nil customView:imageview view:view mode:HUDModeCustomView autoHide:NO duration:3 enable:YES];
```

```
// 显示HUD自动隐藏 仅图标
UIImage *image = [UIImage imageNamed:@"withoutNetwork"];
UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
[SYUIProgressHUD.share showMessage:nil customView:imageview view:view mode:HUDModeCustomView autoHide:YES duration:3 enable:YES];
```

```
// 显示HUD不隐藏 信息和符号指示器
[SYHUDUtil showMessage:message customView:nil view:view mode:HUDModeActivityWithText autoHide:NO duration:0 enable:YES];
```

```
// 显示HUD自动隐藏 信息和符号指示器
[SYHUDUtil showMessage:message customView:nil view:view mode:HUDModeActivityWithText autoHide:YES duration:3 enable:NO];
```

```
// 显示HUD不隐藏 信息和图标
UIImage *image = [UIImage imageNamed:@"error"];
UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
[SYUIProgressHUD.share showMessage:message customView:imageview view:view mode:HUDModeCustomViewWithText autoHide:NO duration:3 enable:YES];
```

```
// 显示HUD自动隐藏 信息和图标
UIImage *image = [UIImage imageNamed:@"success"];
UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
[SYUIProgressHUD.share showMessage:message customView:imageview view:view mode:HUDModeCustomViewWithText autoHide:YES duration:3 enable:NO];
```

效果图

![SYToast](./images/SYToast.gif) 


#### 修改说明
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

