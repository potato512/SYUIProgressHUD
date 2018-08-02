# SYToast
提示信息弹窗


* 使用介绍 
  * 自动导入：使用命令`pod 'SYIToast'`导入到项目中
  * 手动导入：或下载源码后，将源码添加到项目中
  

* 使用示例

导入头文件
```
#import "SYIToast"
// 或
#import "SYIToast+SYCategory.h"
```

```
NSArray *messages = @[@"出错了，赶紧找问题吧！", @"正确！", @"因为你的不努力，现在发现了很多存在的隐患，你必须在规定的时间点完成所有的工作。否则后果很严重！"];
NSArray *positons = @[[NSNumber numberWithInteger:iToastPositionBottom], [NSNumber numberWithInteger:iToastPositionCenter], [NSNumber numberWithInteger:iToastPositionTop]];
NSString *message = messages[arc4random() % messages.count];
NSNumber *position = positons[arc4random() % positons.count];
```

方法1
```
[[SYIToast shareIToast] showText:message postion:position.integerValue];
```

方法2 扩展类方法
```
if (iToastPositionTop == position.integerValue)
{
    [SYIToast alertWithTitle:message];
}
else if (iToastPositionCenter == position.integerValue)
{
    [SYIToast alertWithTitleCenter:message];
}
else if (iToastPositionBottom == position.integerValue)
{
    [SYIToast alertWithTitleBottom:message];
}
```


效果图

* 随机位置显示：顶端提示效果，或中间提示效果，或底端提示效果

![SYToast](./images/SYToast.gif) 


#### 修改说明
* 20180802
  * 版本号：1.0.0
  * 修改完善
  
* 20170607
  * 方法名称修改，避免其他库文件方法同名。

