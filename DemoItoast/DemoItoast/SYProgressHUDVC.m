//
//  SYProgressHUDVC.m
//  DemoItoast
//
//  Created by Herman on 2020/4/19.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SYProgressHUDVC.h"
#import "SYUIProgressHUD.h"

@interface SYProgressHUDVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *textArray;

@end

@implementation SYProgressHUDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"SYUIProgressHUD";
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"hideKeyboard" style:UIBarButtonItemStyleDone target:self action:@selector(hideKeyboardClick)];
    //
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    //
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    headerView.backgroundColor = UIColor.whiteColor;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, (headerView.frame.size.width - 40), (headerView.frame.size.height - 20))];
    textField.textColor = UIColor.blackColor;
    textField.layer.borderColor = [UIColor.blackColor colorWithAlphaComponent:0.3].CGColor;
    textField.layer.borderWidth = 0.5;
    textField.layer.cornerRadius = 10;
    textField.layer.masksToBounds = YES;
    [headerView addSubview:textField];
    tableView.tableHeaderView = headerView;
    tableView.tableFooterView = [UIView new];
    
    // 初始化
//    UIView *view = UIApplication.sharedApplication.delegate.window;
//    UIView *view = self.view;
//    [SYUIProgressHUD setContainerView:view];
//    [SYUIProgressHUD setActivityColor:UIColor.redColor];
//    [SYUIProgressHUD setHUDBackgroundColor:UIColor.greenColor];
//    [SYUIProgressHUD setHUDCorner:15];
//    [SYUIProgressHUD setHUDSize:CGSizeMake(300, 50)];
//    [SYUIProgressHUD setHUDAutoSize:NO];
//    [SYUIProgressHUD setHUDPosition:80];
    //
    SYUIProgressHUD.share.activityColor = UIColor.blueColor;
    SYUIProgressHUD.share.hudSize = CGSizeMake(80, 80);
    SYUIProgressHUD.share.hudColor = UIColor.brownColor;
    SYUIProgressHUD.share.hudCorner = 10;
    SYUIProgressHUD.share.isAutoSize = NO;
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
    [SYHUDUtil hide];
}

- (void)hideKeyboardClick
{
    [self.view endEditing:YES];
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
    SYUIProgressHUD.share.backgroundColor = UIColor.clearColor;
    SYUIProgressHUD.share.activityColor = UIColor.blueColor;
    SYUIProgressHUD.share.hudSize = CGSizeMake(80, 80);
    SYUIProgressHUD.share.hudColor = UIColor.brownColor;
    SYUIProgressHUD.share.hudCorner = 10;
    SYUIProgressHUD.share.isAutoSize = NO;
    SYUIProgressHUD.share.textAlign = NSTextAlignmentCenter;
    SYHUDUtil.isFollowKeyboard = YES;
    SYUIProgressHUD.share.isSingleline = YES;
    //
    UIView *view = UIApplication.sharedApplication.delegate.window;
    NSString *message = self.textArray[arc4random() % self.textArray.count];
    //
    NSString *text = self.array[indexPath.row];
    if ([text isEqualToString:@"隐藏HUD"]) {
        [SYHUDUtil hideDelay:0 complete:^{
            NSLog(@"3秒后隐藏");
        }];
    } else if ([text isEqualToString:@"显示HUD不隐藏 仅信息"]) {
        SYUIProgressHUD.share.isAutoSize = YES;
        SYUIProgressHUD.share.isSingleline = NO;
        SYUIProgressHUD.share.textAlign = NSTextAlignmentLeft;
        
//        message = @"因为你的不努力，现在发现了很多存在的隐患，你必须在规定的时间点完成所有的工作。否则后果很严重！";
        [SYHUDUtil showMessage:message view:view];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 仅信息"]) {
        SYUIProgressHUD.share.hudColor = UIColor.yellowColor;
        SYUIProgressHUD.share.textColor = UIColor.redColor;
        SYUIProgressHUD.share.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
        [SYHUDUtil showMessage:message customView:nil view:view mode:HUDModeText autoHide:YES duration:3 enable:YES];
    } else if ([text isEqualToString:@"显示HUD不隐藏 仅符号指示器"]) {
        SYUIProgressHUD.share.activityColor = UIColor.redColor;
        [SYHUDUtil showActivity:view];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 仅符号指示器"]) {
        [SYHUDUtil showMessage:nil customView:nil view:view mode:HUDModeActivity autoHide:YES duration:3 enable:YES];
    } else if ([text isEqualToString:@"显示HUD不隐藏 仅图标"]) {
        UIImage *image = [UIImage imageNamed:@"withNetwork"];
        UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
        [SYUIProgressHUD.share showMessage:nil customView:imageview view:view mode:HUDModeCustomView autoHide:NO duration:3 enable:YES];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 仅图标"]) {
        UIImage *image = [UIImage imageNamed:@"withoutNetwork"];
        UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
        [SYUIProgressHUD.share showMessage:nil customView:imageview view:view mode:HUDModeCustomView autoHide:YES duration:3 enable:YES];
    } else if ([text isEqualToString:@"显示HUD不隐藏 信息和符号指示器"]) {
        SYUIProgressHUD.share.hudSize = CGSizeMake(200, 200);
        SYUIProgressHUD.share.isAutoSize = YES;
        [SYHUDUtil showMessage:message customView:nil view:view mode:HUDModeActivityWithText autoHide:NO duration:0 enable:YES];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 信息和符号指示器"]) {
        [SYHUDUtil showMessage:message customView:nil view:view mode:HUDModeActivityWithText autoHide:YES duration:3 enable:NO];
    } else if ([text isEqualToString:@"显示HUD不隐藏 信息和图标"]) {
        SYUIProgressHUD.share.isAutoSize = YES;
        SYUIProgressHUD.share.isFollowKeyboard = NO;
        UIImage *image = [UIImage imageNamed:@"error"];
        UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
        [SYUIProgressHUD.share showMessage:message customView:imageview view:view mode:HUDModeCustomViewWithText autoHide:NO duration:3 enable:YES];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 信息和图标"]) {
        UIImage *image = [UIImage imageNamed:@"success"];
        UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
        [SYUIProgressHUD.share showMessage:message customView:imageview view:view mode:HUDModeCustomViewWithText autoHide:YES duration:3 enable:NO];
    }
}

- (NSArray *)array
{
    if (_array == nil) {
        _array = @[@"隐藏HUD", @"显示HUD不隐藏 仅信息", @"显示HUD自动隐藏 仅信息", @"显示HUD不隐藏 仅符号指示器", @"显示HUD自动隐藏 仅符号指示器", @"显示HUD不隐藏 仅图标", @"显示HUD自动隐藏 仅图标", @"显示HUD不隐藏 信息和符号指示器", @"显示HUD自动隐藏 信息和符号指示器", @"显示HUD不隐藏 信息和图标", @"显示HUD自动隐藏 信息和图标"];
    }
    return _array;
}

- (NSArray *)textArray
{
    if (_textArray == nil) {
        _textArray = @[@"出错了，赶紧找问题吧！", @"正确！", @"因为你的不努力，现在发现了很多存在的隐患，你必须在规定的时间点完成所有的工作。否则后果很严重！"];
    }
    return _textArray;
}

@end
