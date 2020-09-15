//
//  SYHUDVC.m
//  DemoItoast
//
//  Created by Herman on 2020/9/15.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SYHUDVC.h"
#import "SYUIProgressHUD.h"

@interface SYHUDVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *textArray;

@end

@implementation SYHUDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"SYUIHUD";
    //
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
        
    // 初始化
    SYUIHUD.share.isAmination = YES;
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hudHideAction) name:kNotificationHUDDidHide object:nil];
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

- (void)dealloc
{

}

- (void)hudHideAction
{
    NSLog(@"hudHideAction");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    NSString *text = self.array[indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
    UIView *view = UIApplication.sharedApplication.delegate.window;
    UIView *viewSelf = self.view;
    NSString *message = self.textArray[arc4random() % self.textArray.count];
    //
    NSString *text = self.array[indexPath.row];
    //
    SYUIHUD.share.autoSize = NO;
    SYUIHUD.share.touchHide = NO;
    SYUIHUD.share.hudColor = [UIColor.blackColor colorWithAlphaComponent:0.8];
    SYUIHUD.share.messageColor = UIColor.whiteColor;
    SYUIHUD.share.messageFont = [UIFont systemFontOfSize:13];
    SYUIHUD.share.shadowColor = UIColor.clearColor;
    SYUIHUD.share.mode = SYUIHUDModeDefault;
    //
    if ([text isEqualToString:@"隐藏hud"]) {
        [SYUIHUD.share hideDelay:0 finishHandle:^{
            NSLog(@"延迟0秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud不隐藏 window enble"]) {
        [SYUIHUD.share showInView:view enable:YES message:message autoHide:0 finishHandle:^{
            NSLog(@"延迟0秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud自动隐藏 window enble"]) {
        [SYUIHUD.share showInView:view enable:YES message:message autoHide:3 finishHandle:^{
            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud自动隐藏 window unenble"]) {
        [SYUIHUD.share showInView:view enable:NO message:message autoHide:3 finishHandle:^{
            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud不隐藏 view enable"]) {
        [SYUIHUD.share showInView:viewSelf enable:YES message:message autoHide:0 finishHandle:^{
            NSLog(@"延迟0秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud自动隐藏 view enble"]) {
        [SYUIHUD.share showInView:viewSelf enable:YES message:message autoHide:3 finishHandle:^{
            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud不隐藏 view unenble"]) {
        [SYUIHUD.share showInView:viewSelf enable:NO message:message autoHide:0 finishHandle:^{
            NSLog(@"延迟0秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud自动隐藏 view unenble"]) {
        [SYUIHUD.share showInView:viewSelf enable:NO message:message autoHide:3 finishHandle:^{
            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud不隐藏 window autosize"]) {
        SYUIHUD.share.autoSize = YES;
        SYUIHUD.share.touchHide = YES;
        SYUIHUD.share.hudColor = UIColor.greenColor;
        SYUIHUD.share.messageFont = [UIFont systemFontOfSize:16];
        [SYUIHUD.share showInView:view enable:YES message:message autoHide:0 finishHandle:^{
            NSLog(@"延迟0秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud不隐藏 view autosize"]) {
        SYUIHUD.share.autoSize = YES;
        SYUIHUD.share.hudColor = UIColor.yellowColor;
        SYUIHUD.share.messageColor = UIColor.redColor;
        SYUIHUD.share.messageFont = [UIFont systemFontOfSize:20];
        SYUIHUD.share.shadowColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
        [SYUIHUD.share showInView:viewSelf enable:YES message:message autoHide:0 finishHandle:^{
            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud不隐藏 view activity"]) {
        SYUIHUD.share.autoSize = YES;
        SYUIHUD.share.shadowColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
        SYUIHUD.share.mode = SYUIHUDModeActivity;
        [SYUIHUD.share showInView:viewSelf enable:YES message:message autoHide:0 finishHandle:^{
            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud不隐藏 view customer text"]) {
        SYUIHUD.share.autoSize = YES;
        SYUIHUD.share.mode = SYUIHUDModeCustomViewText;
        SYUIHUD.share.imageName = @"success";
        SYUIHUD.share.imageAnimation = NO;
        [SYUIHUD.share showInView:viewSelf enable:YES message:message autoHide:0 finishHandle:^{
            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
        }];
    } else if ([text isEqualToString:@"显示hud不隐藏 view customer"]) {
        SYUIHUD.share.autoSize = YES;
        SYUIHUD.share.mode = SYUIHUDModeCustomView;
        SYUIHUD.share.imageName = @"withNetwork";
        SYUIHUD.share.imageAnimation = YES;
        [SYUIHUD.share showInView:viewSelf enable:YES message:message autoHide:0 finishHandle:^{
            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
        }];
    }
}

- (NSArray *)array
{
    if (_array == nil) {
        _array = @[@"隐藏hud",
                   @"显示hud不隐藏 window enble",
                   @"显示hud自动隐藏 window enble",
                   @"显示hud自动隐藏 window unenble",
                   @"显示hud不隐藏 view enable",
                   @"显示hud自动隐藏 view enble",
                   @"显示hud不隐藏 view unenble",
                   @"显示hud自动隐藏 view unenble",
                   @"显示hud不隐藏 window autosize",
                   @"显示hud不隐藏 view autosize",
                   @"显示hud不隐藏 view activity",
                   @"显示hud不隐藏 view customer text",
                   @"显示hud不隐藏 view customer"];
    }
    return _array;
}

- (NSArray *)textArray
{
    if (_textArray == nil) {
        _textArray = @[@"出错了，赶紧找问题吧！",
                       @"正确！",
                       @"因为你的不努力，现在发现了很多存在的隐患，你必须在规定的时间点完成所有的工作。否则后果很严重！",
                       @"网络异常，请检查网络设置",
                       @"每种显示类型都有两个方法，第一个方法默认显示在屏幕中间，第二个方法带有originY参数的是可以自定义显示位置，也就是自定义frame.origin.y。（如果传入的originY<=0，也是显示在屏幕中间）",
                       @"最近梳理项目中的Toast，发现应用的场景并不复杂，于是就自己定义了一个Toast替换之前的。SYUIToast是一个轻量级的提示控件，没有任何依赖。先来看一下效果图。",
                       @"上传失败"];
    }
    return _textArray;
}

@end
