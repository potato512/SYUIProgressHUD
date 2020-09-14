//
//  SYToastVC.m
//  DemoItoast
//
//  Created by Herman on 2020/9/13.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SYToastVC.h"
#import "SYUIProgressHUD.h"

@interface SYToastVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *textArray;

@end

@implementation SYToastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"SYUIToast";
    //
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
        
    // 初始化
//    SYUIToast.share.isAmination = YES;
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
//    SYUIToast.share.autoSize = NO;
//    SYUIToast.share.touchHide = NO;
//    SYUIToast.share.toastColor = [UIColor.blackColor colorWithAlphaComponent:0.8];
//    SYUIToast.share.messageColor = UIColor.whiteColor;
//    SYUIToast.share.messageFont = [UIFont systemFontOfSize:13];
//    SYUIToast.share.shadowColor = UIColor.clearColor;
    //
    if ([text isEqualToString:@"隐藏HUD"]) {
//        [SYUIToast.share hideDelay:0 finishHandle:^{
//            NSLog(@"延迟0秒隐藏 -- %ld", indexPath.row);
//        }];
    } else if ([text isEqualToString:@"显示HUD不隐藏 window enble"]) {
//        [SYUIToast.share showInView:view enable:YES message:message autoHide:0 finishHandle:^{
//            NSLog(@"延迟0秒隐藏 -- %ld", indexPath.row);
//        }];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 window enble"]) {
//        [SYUIToast.share showInView:view enable:YES message:message autoHide:3 finishHandle:^{
//            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
//        }];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 window unenble"]) {
//        [SYUIToast.share showInView:view enable:NO message:message autoHide:3 finishHandle:^{
//            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
//        }];
    } else if ([text isEqualToString:@"显示HUD不隐藏 view enable"]) {
//        [SYUIToast.share showInView:viewSelf enable:YES message:message autoHide:0 finishHandle:^{
//            NSLog(@"延迟0秒隐藏 -- %ld", indexPath.row);
//        }];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 view enble"]) {
//        [SYUIToast.share showInView:viewSelf enable:YES message:message autoHide:3 finishHandle:^{
//            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
//        }];
    } else if ([text isEqualToString:@"显示HUD不隐藏 view unenble"]) {
//        [SYUIToast.share showInView:viewSelf enable:NO message:message autoHide:0 finishHandle:^{
//            NSLog(@"延迟0秒隐藏 -- %ld", indexPath.row);
//        }];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 view unenble"]) {
//        [SYUIToast.share showInView:viewSelf enable:NO message:message autoHide:3 finishHandle:^{
//            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
//        }];
    } else if ([text isEqualToString:@"显示HUD不隐藏 window autosize"]) {
//        SYUIToast.share.autoSize = YES;
//        SYUIToast.share.touchHide = YES;
//        SYUIToast.share.toastColor = UIColor.greenColor;
//        SYUIToast.share.messageFont = [UIFont systemFontOfSize:16];
//        [SYUIToast.share showInView:view enable:YES message:message autoHide:0 finishHandle:^{
//            NSLog(@"延迟0秒隐藏 -- %ld", indexPath.row);
//        }];
    } else if ([text isEqualToString:@"显示HUD不隐藏 view autosize"]) {
//        SYUIToast.share.autoSize = YES;
//        SYUIToast.share.toastColor = UIColor.yellowColor;
//        SYUIToast.share.messageColor = UIColor.redColor;
//        SYUIToast.share.messageFont = [UIFont systemFontOfSize:20];
//        SYUIToast.share.shadowColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
//        [SYUIToast.share showInView:viewSelf enable:YES message:message autoHide:3 finishHandle:^{
//            NSLog(@"延迟3秒隐藏 -- %ld", indexPath.row);
//        }];
    }
}

- (NSArray *)array
{
    if (_array == nil) {
        _array = @[@"隐藏HUD", @"显示HUD不隐藏 window enble", @"显示HUD自动隐藏 window enble", @"显示HUD自动隐藏 window unenble", @"显示HUD不隐藏 view enable", @"显示HUD自动隐藏 view enble", @"显示HUD不隐藏 view unenble", @"显示HUD自动隐藏 view unenble",@"显示HUD不隐藏 window autosize", @"显示HUD不隐藏 view autosize"];
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
